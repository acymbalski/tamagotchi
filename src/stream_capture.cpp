#ifdef STREAM_CAPTURE_ENABLED

#include "stream_capture.h"
#include <cstring>

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

// StreamCapture implementation

StreamCapture::StreamCapture()
    : file(nullptr), active(false), bufferPos(0) {
    memset(buffer, 0, sizeof(buffer));
}

StreamCapture::~StreamCapture() {
    if (active) stop();
}

void StreamCapture::start(const char* filename, uint32_t startTick, const uint8_t* initialMemory) {
    if (active) stop();

    file = fopen(filename, "wb");
    if (!file) return;

    // Write 16-byte file header
    // [magic:4] [version:u16] [startTick:u32] [ramNibbles:u16] [reserved:4]
    uint8_t header[16];
    memset(header, 0, sizeof(header));
    memcpy(header + 0, STREAM_MAGIC, 4);
    uint16_t version = STREAM_VERSION;
    memcpy(header + 4, &version, 2);
    memcpy(header + 6, &startTick, 4);
    uint16_t ramNibbles = STREAM_RAM_NIBBLES;
    memcpy(header + 10, &ramNibbles, 2);
    // bytes 12-15 reserved (already zeroed)
    fwrite(header, 1, 16, file);

    active = true;
    bufferPos = 0;

    // Write initial RAM snapshot
    logRamSnapshot(startTick, initialMemory);
}

void StreamCapture::stop() {
    if (!active) return;
    flushBuffer();
    if (file) {
        fclose(file);
        file = nullptr;
    }
    active = false;
}

void StreamCapture::flushBuffer() {
    if (bufferPos > 0 && file) {
        fwrite(buffer, 1, bufferPos, file);
        bufferPos = 0;
    }
}

void StreamCapture::bufferWrite(const void* data, size_t size) {
    if (bufferPos + size > STREAM_BUFFER_SIZE) {
        flushBuffer();
    }
    // If single write exceeds buffer, write directly
    if (size > STREAM_BUFFER_SIZE) {
        if (file) fwrite(data, 1, size, file);
        return;
    }
    memcpy(buffer + bufferPos, data, size);
    bufferPos += size;
}

// Record: ROM Write (8 bytes)
// [tag:u8] [tick:u32] [addr:u16] [value:u8]
void StreamCapture::logRomWrite(uint32_t tick, uint16_t addr, uint8_t value) {
    if (!active) return;
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
    flushBuffer(); // ensure ordering
    uint8_t hdr[5];
    hdr[0] = STREAM_REC_RAM_SNAPSHOT;
    memcpy(hdr + 1, &tick, 4);
    bufferWrite(hdr, 5);
    bufferWrite(memory, STREAM_RAM_BYTES);
}

// Record: LCD Frame (55 bytes)
// [tag:u8] [tick:u32] [display:50 bytes]
void StreamCapture::logLcdFrame(uint32_t tick, const uint8_t* displayMem) {
    if (!active) return;
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

#endif // STREAM_CAPTURE_ENABLED
