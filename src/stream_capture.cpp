#ifdef STREAM_CAPTURE_ENABLED

#include "stream_capture.h"
#include "cpu.h"
#include <cstring>

#ifdef _WIN32
#include <direct.h>  // _mkdir on MSVC
#define mkdir(path, mode) _mkdir(path)
#define PATH_SEP "\\"
#define ftello64 _ftelli64
#else
#include <sys/stat.h>
#include <sys/types.h>
#define PATH_SEP "/"
#define ftello64 ftello
#endif

// Globals
StreamCapture* g_streamCapture = nullptr;
BabysitterFuncId g_currentBabysitterFunc = BFID_NONE;

// RAII guard
BabysitterFuncGuard::BabysitterFuncGuard(BabysitterFuncId id) {
    g_currentBabysitterFunc = id;
}
BabysitterFuncGuard::~BabysitterFuncGuard() {
    g_currentBabysitterFunc = BFID_NONE;
}

// C-linkage wrapper for cpu.c
extern "C" void stream_log_rom_write(uint16_t addr, uint8_t value, uint32_t tick) {
    if (g_streamCapture) g_streamCapture->logRomWrite(tick, addr, value);
}

// C-linkage wrapper for button logging — gets tick from cpu state
extern "C" void stream_log_button(uint8_t buttonId, uint8_t state) {
    if (g_streamCapture) {
        cpu_state_t st;
        cpu_get_state(&st);
        g_streamCapture->logButtonEvent(st.tick_counter, buttonId, state);
    }
}

// StreamCapture implementation

StreamCapture::StreamCapture()
    : file(nullptr), active(false), bufferPos(0), filteredCount(0),
      compressed(false), uncompressedOffset(0),
      segmentIndex(0), segmentStartTick(0), segmented(false) {
    memset(buffer, 0, sizeof(buffer));
    memset(shadowMemory, 0, sizeof(shadowMemory));
    memset(&zstream, 0, sizeof(zstream));
    baseDir[0] = '\0';
}

StreamCapture::~StreamCapture() {
    if (active) stop();
}

void StreamCapture::start(const char* filename, uint32_t startTick, const uint8_t* initialMemory) {
    if (active) stop();

    file = fopen(filename, "wb");
    if (!file) return;

    // Write 16-byte file header
    // [magic:4] [version:u16] [startTick:u32] [ramNibbles:u16] [compress:u8] [reserved:3]
    uint8_t header[16];
    memset(header, 0, sizeof(header));
    memcpy(header + 0, STREAM_MAGIC, 4);
    uint16_t version = STREAM_VERSION;
    memcpy(header + 4, &version, 2);
    memcpy(header + 6, &startTick, 4);
    uint16_t ramNibbles = STREAM_RAM_NIBBLES;
    memcpy(header + 10, &ramNibbles, 2);
    header[12] = STREAM_COMPRESS_ZLIB;
    fwrite(header, 1, 16, file);

    // Initialize raw deflate stream (-15 window bits = no zlib header/footer)
    memset(&zstream, 0, sizeof(zstream));
    mz_deflateInit2(&zstream, MZ_DEFAULT_COMPRESSION, MZ_DEFLATED,
                    -MZ_DEFAULT_WINDOW_BITS, 9, MZ_DEFAULT_STRATEGY);
    compressed = true;

    active = true;
    segmented = false;
    bufferPos = 0;
    uncompressedOffset = 0;
    indexEntries.clear();

    // Sync shadow memory with initial RAM state for delta filtering
    memcpy(shadowMemory, initialMemory, STREAM_RAM_BYTES);
    filteredCount = 0;

    // Write initial RAM snapshot
    logRamSnapshot(startTick, initialMemory);
}

void StreamCapture::stop() {
    if (!active) return;

    // Flush any buffered data through the compressor
    flushBuffer();

    // Finish deflate stream
    if (compressed && file) {
        zstream.next_in = nullptr;
        zstream.avail_in = 0;
        int status;
        do {
            zstream.next_out = compressBuffer;
            zstream.avail_out = STREAM_BUFFER_SIZE;
            status = mz_deflate(&zstream, MZ_FINISH);
            size_t have = STREAM_BUFFER_SIZE - (size_t)zstream.avail_out;
            if (have > 0) fwrite(compressBuffer, 1, have, file);
        } while (status == MZ_OK);
        mz_deflateEnd(&zstream);
        compressed = false;
    }

    // Write on-disk TIDX index (uncompressed, after compressed data)
    if (file && !indexEntries.empty()) {
        uint64_t indexStart = (uint64_t)ftello64(file);
        fwrite(STREAM_INDEX_MAGIC, 1, 4, file);
        uint32_t count = (uint32_t)indexEntries.size();
        fwrite(&count, 4, 1, file);
        for (const auto& e : indexEntries) {
            fwrite(&e.tick, 4, 1, file);
            fwrite(&e.offset, 8, 1, file);
            fwrite(&e.recordType, 1, 1, file);
        }
        fwrite(&indexStart, 8, 1, file);
    }
    indexEntries.clear();

    printf("[stream] Filtered %llu redundant writes\n", (unsigned long long)filteredCount);
    if (file) {
        fclose(file);
        file = nullptr;
    }
    active = false;
}

void StreamCapture::flushBuffer() {
    if (bufferPos > 0 && file) {
        if (compressed) {
            zstream.next_in = buffer;
            zstream.avail_in = (mz_uint32)bufferPos;
            do {
                zstream.next_out = compressBuffer;
                zstream.avail_out = STREAM_BUFFER_SIZE;
                mz_deflate(&zstream, MZ_NO_FLUSH);
                size_t have = STREAM_BUFFER_SIZE - (size_t)zstream.avail_out;
                if (have > 0) fwrite(compressBuffer, 1, have, file);
            } while (zstream.avail_in > 0);
        } else {
            fwrite(buffer, 1, bufferPos, file);
        }
        bufferPos = 0;
    }
}

void StreamCapture::bufferWrite(const void* data, size_t size) {
    if (bufferPos + size > STREAM_BUFFER_SIZE) {
        flushBuffer();
    }
    // If single write exceeds buffer, compress/write directly
    if (size > STREAM_BUFFER_SIZE) {
        if (compressed) {
            zstream.next_in = (const uint8_t*)data;
            zstream.avail_in = (mz_uint32)size;
            do {
                zstream.next_out = compressBuffer;
                zstream.avail_out = STREAM_BUFFER_SIZE;
                mz_deflate(&zstream, MZ_NO_FLUSH);
                size_t have = STREAM_BUFFER_SIZE - (size_t)zstream.avail_out;
                if (have > 0 && file) fwrite(compressBuffer, 1, have, file);
            } while (zstream.avail_in > 0);
        } else if (file) {
            fwrite(data, 1, size, file);
        }
        uncompressedOffset += size;
        return;
    }
    memcpy(buffer + bufferPos, data, size);
    bufferPos += size;
    uncompressedOffset += size;
}

// Record: ROM Write (8 bytes)
// [tag:u8] [tick:u32] [addr:u16] [value:u8]
void StreamCapture::logRomWrite(uint32_t tick, uint16_t addr, uint8_t value) {
    if (!active) return;
    // Delta filter: skip if value unchanged
    if (addr < STREAM_RAM_NIBBLES) {
        uint16_t byteIdx = addr >> 1;
        uint8_t current;
        if ((addr & 1) == 0)
            current = (shadowMemory[byteIdx] >> 4) & 0x0F;
        else
            current = shadowMemory[byteIdx] & 0x0F;
        if (current == (value & 0x0F)) {
            filteredCount++;
            return;
        }
        // Update shadow
        if ((addr & 1) == 0)
            shadowMemory[byteIdx] = (shadowMemory[byteIdx] & 0x0F) | ((value & 0x0F) << 4);
        else
            shadowMemory[byteIdx] = (shadowMemory[byteIdx] & 0xF0) | (value & 0x0F);
    }
    uint8_t rec[8];
    rec[0] = STREAM_REC_ROM_WRITE;
    memcpy(rec + 1, &tick, 4);
    memcpy(rec + 5, &addr, 2);
    rec[7] = value;
    bufferWrite(rec, 8);
}

// Record: Babysitter Write (9 bytes)
// [tag:u8] [tick:u32] [addr:u16] [value:u8] [func_id:u8]
void StreamCapture::logBabysitterWrite(uint32_t tick, uint16_t addr, uint8_t value, BabysitterFuncId func) {
    if (!active) return;
    // Delta filter: skip if value unchanged
    if (addr < STREAM_RAM_NIBBLES) {
        uint16_t byteIdx = addr >> 1;
        uint8_t current;
        if ((addr & 1) == 0)
            current = (shadowMemory[byteIdx] >> 4) & 0x0F;
        else
            current = shadowMemory[byteIdx] & 0x0F;
        if (current == (value & 0x0F)) {
            filteredCount++;
            return;
        }
        // Update shadow
        if ((addr & 1) == 0)
            shadowMemory[byteIdx] = (shadowMemory[byteIdx] & 0x0F) | ((value & 0x0F) << 4);
        else
            shadowMemory[byteIdx] = (shadowMemory[byteIdx] & 0xF0) | (value & 0x0F);
    }
    uint8_t rec[9];
    rec[0] = STREAM_REC_BABYSITTER_WRITE;
    memcpy(rec + 1, &tick, 4);
    memcpy(rec + 5, &addr, 2);
    rec[7] = value;
    rec[8] = static_cast<uint8_t>(func);
    bufferWrite(rec, 9);
}

// Record: RAM Snapshot (325 bytes)
// [tag:u8] [tick:u32] [memory:320 bytes]
void StreamCapture::logRamSnapshot(uint32_t tick, const uint8_t* memory) {
    if (!active) return;
    flushBuffer(); // ensure ordering; also ensures uncompressedOffset is accurate
    // Record index entry BEFORE writing (offset points to start of this record)
    indexEntries.push_back({tick, uncompressedOffset, STREAM_REC_RAM_SNAPSHOT});
    uint8_t hdr[5];
    hdr[0] = STREAM_REC_RAM_SNAPSHOT;
    memcpy(hdr + 1, &tick, 4);
    bufferWrite(hdr, 5);
    bufferWrite(memory, STREAM_RAM_BYTES);
    // Resync shadow with the snapshot so delta filter stays accurate
    memcpy(shadowMemory, memory, STREAM_RAM_BYTES);
}

// Record: LCD Frame (77 bytes)
// [tag:u8] [tick:u32] [display:72 bytes]
void StreamCapture::logLcdFrame(uint32_t tick, const uint8_t* displayMem) {
    if (!active) return;
    // Record index entry BEFORE writing
    indexEntries.push_back({tick, uncompressedOffset, STREAM_REC_LCD_FRAME});
    uint8_t hdr[5];
    hdr[0] = STREAM_REC_LCD_FRAME;
    memcpy(hdr + 1, &tick, 4);
    bufferWrite(hdr, 5);
    bufferWrite(displayMem, STREAM_LCD_BYTES);
}

// Record: Annotation (7+N bytes)
// [tag:u8] [tick:u32] [len:u16] [text:len bytes]
void StreamCapture::logAnnotation(uint32_t tick, const char* text) {
    if (!active) return;
    uint16_t len = (uint16_t)strlen(text);
    uint8_t hdr[7];
    hdr[0] = STREAM_REC_ANNOTATION;
    memcpy(hdr + 1, &tick, 4);
    memcpy(hdr + 5, &len, 2);
    bufferWrite(hdr, 7);
    bufferWrite(text, len);
}

// Record: Tick Marker (5 bytes)
// [tag:u8] [tick:u32]
void StreamCapture::logTickMarker(uint32_t tick) {
    if (!active) return;
    uint8_t rec[5];
    rec[0] = STREAM_REC_TICK_MARKER;
    memcpy(rec + 1, &tick, 4);
    bufferWrite(rec, 5);
}

// Record: Button Event (7 bytes)
// [tag:u8] [tick:u32] [button_id:u8] [state:u8]
void StreamCapture::logButtonEvent(uint32_t tick, uint8_t buttonId, uint8_t state) {
    if (!active) return;
    uint8_t rec[7];
    rec[0] = STREAM_REC_BUTTON_EVENT;
    memcpy(rec + 1, &tick, 4);
    rec[5] = buttonId;
    rec[6] = state;
    bufferWrite(rec, 7);
}

// Segmented stream support

void StreamCapture::startSegmented(const char* dirPath, uint32_t startTick, const uint8_t* initialMemory) {
    if (active) stop();

    strncpy(baseDir, dirPath, sizeof(baseDir) - 1);
    baseDir[sizeof(baseDir) - 1] = '\0';
    segmentIndex = 0;
    segmentStartTick = startTick;

    mkdir(baseDir, 0777);
    openSegment(startTick, initialMemory);
    segmented = true;  // openSegment calls start() which sets segmented=false; restore it
}

void StreamCapture::openSegment(uint32_t tick, const uint8_t* memory) {
    char segPath[600];
    snprintf(segPath, sizeof(segPath), "%s" PATH_SEP "seg_%03u.tamstream", baseDir, segmentIndex);
    start(segPath, tick, memory);
    // Restore segmentation state (start() clears it)
    segmented = true;
    segmentStartTick = tick;
}

bool StreamCapture::shouldRotate(uint32_t tick) const {
    return segmented && active && (tick - segmentStartTick >= STREAM_SEGMENT_TICKS);
}

void StreamCapture::rotateSegment(uint32_t tick, const uint8_t* currentMemory) {
    if (!segmented || !active) return;
    bool wasSegmented = segmented;
    char savedBaseDir[512];
    strncpy(savedBaseDir, baseDir, sizeof(savedBaseDir));
    uint32_t nextSegIdx = segmentIndex + 1;

    stop();  // closes current segment, sets active=false, segmented=false

    // Restore segmentation state for next segment
    strncpy(baseDir, savedBaseDir, sizeof(baseDir));
    segmentIndex = nextSegIdx;
    openSegment(tick, currentMemory);
    segmented = true;
}

#endif // STREAM_CAPTURE_ENABLED
