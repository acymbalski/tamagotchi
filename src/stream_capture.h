#ifndef STREAM_CAPTURE_H
#define STREAM_CAPTURE_H

#ifdef STREAM_CAPTURE_ENABLED

#include <cstdint>
#include <cstdio>
#include <vector>

#include "miniz.h"

// File magic and version
#define STREAM_MAGIC        "TAMS"
#define STREAM_VERSION      3

// Compression flags (stored in header byte 12)
#define STREAM_COMPRESS_NONE   0x00
#define STREAM_COMPRESS_ZLIB   0x01

// Segment size: 1 emulated hour = 3600 * 32768 ticks
#define STREAM_SEGMENT_TICKS  (3600UL * 32768UL)

// On-disk index magic
#define STREAM_INDEX_MAGIC "TIDX"

struct StreamIndexEntry {
    uint32_t tick;
    uint64_t offset;     // byte offset in uncompressed record stream (0 = first record byte)
    uint8_t  recordType;
};

// Record type tags
#define STREAM_REC_RAM_SNAPSHOT      0x01
#define STREAM_REC_ROM_WRITE         0x02
#define STREAM_REC_BABYSITTER_WRITE  0x03
#define STREAM_REC_LCD_FRAME         0x04
#define STREAM_REC_ANNOTATION        0x05
#define STREAM_REC_TICK_MARKER       0x06
#define STREAM_REC_BUTTON_EVENT      0x07

// Button constants
#define STREAM_BTN_LEFT     0
#define STREAM_BTN_MIDDLE   1
#define STREAM_BTN_RIGHT    2
#define STREAM_BTN_RELEASED 0
#define STREAM_BTN_PRESSED  1

// RAM snapshot size: 320 packed bytes = 640 nibbles
#define STREAM_RAM_BYTES    320
#define STREAM_RAM_NIBBLES  0x280

// LCD frame data size: matrix_buffer (16*4=64 bytes) + icon_buffer (8 bytes) = 72
#define STREAM_LCD_BYTES    72

// Write buffer size
#define STREAM_BUFFER_SIZE  65536

// Babysitter function IDs for attribution
enum BabysitterFuncId : uint8_t {
    BFID_NONE           = 0,
    BFID_FEED_FOOD      = 1,
    BFID_FEED_SNACK     = 2,
    BFID_GIVE_MEDICINE  = 3,
    BFID_PLAY_GAME      = 4,
    BFID_TOGGLE_LIGHTS  = 5,
    BFID_CLEAN_POOP     = 6,
    BFID_CHECK_STATS    = 7,
    BFID_SET_TIME       = 8,
    BFID_FORCE_AGE_UP   = 9,
    BFID_SET_CHARACTER   = 10,
    BFID_FORCE_MODE     = 11,
    BFID_DISCIPLINE     = 12
};

// RAII guard for setting babysitter func context
struct BabysitterFuncGuard {
    BabysitterFuncGuard(BabysitterFuncId id);
    ~BabysitterFuncGuard();
};

class StreamCapture {
public:
    StreamCapture();
    ~StreamCapture();

    void start(const char* filename, uint32_t startTick, const uint8_t* initialMemory);
    void startSegmented(const char* dirPath, uint32_t startTick, const uint8_t* initialMemory);
    void stop();
    bool isActive() const { return active; }

    bool shouldRotate(uint32_t tick) const;
    void rotateSegment(uint32_t tick, const uint8_t* currentMemory);

    void logRomWrite(uint32_t tick, uint16_t addr, uint8_t value);
    void logBabysitterWrite(uint32_t tick, uint16_t addr, uint8_t value, BabysitterFuncId func);
    void logRamSnapshot(uint32_t tick, const uint8_t* memory);
    void logLcdFrame(uint32_t tick, const uint8_t* displayMem);
    void logAnnotation(uint32_t tick, const char* text);
    void logTickMarker(uint32_t tick);
    void logButtonEvent(uint32_t tick, uint8_t buttonId, uint8_t state);

private:
    void flushBuffer();
    void bufferWrite(const void* data, size_t size);
    void openSegment(uint32_t tick, const uint8_t* memory);

    FILE* file;
    bool active;
    uint8_t buffer[STREAM_BUFFER_SIZE];
    size_t bufferPos;

    // Delta filter shadow memory (320 packed bytes, same layout as cpuState.memory)
    uint8_t shadowMemory[STREAM_RAM_BYTES];
    uint64_t filteredCount;

    // Compression
    mz_stream zstream;
    uint8_t compressBuffer[STREAM_BUFFER_SIZE];
    bool compressed;

    // On-disk index
    std::vector<StreamIndexEntry> indexEntries;
    uint64_t uncompressedOffset;

    // Segmentation
    char baseDir[512];
    uint32_t segmentIndex;
    uint32_t segmentStartTick;
    bool segmented;
};

// Global capture instance (null when not capturing)
extern StreamCapture* g_streamCapture;

// Current babysitter function context for write attribution
extern BabysitterFuncId g_currentBabysitterFunc;

// C-linkage wrapper for cpu.c to call
extern "C" void stream_log_rom_write(uint16_t addr, uint8_t value, uint32_t tick);

// Helper: log button event with explicit tick
inline void stream_log_button_event(uint32_t tick, uint8_t buttonId, uint8_t state) {
    if (g_streamCapture) {
        g_streamCapture->logButtonEvent(tick, buttonId, state);
    }
}

// C-linkage wrapper for button logging (callable from cpu_state contexts)
extern "C" void stream_log_button(uint8_t buttonId, uint8_t state);

#endif // STREAM_CAPTURE_ENABLED
#endif // STREAM_CAPTURE_H
