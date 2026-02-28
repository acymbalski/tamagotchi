/*
 * PC Simulator entry point for ArduinoGotchi
 * Replaces src/main.cpp for the PC build.
 * Rendering: SDL2   Input: keyboard   Persistence: file-based savestate
 */

#include <windows.h>
// SDL2 VC dev zip: headers are in include/ directly (not include/SDL2/)
#include <SDL.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#include "tamalib.h"
#include "hw.h"
#include "cpu.h"
#include "memory.h"
#include "babysitter.h"
#include "input.h"
#include "pc_savestate.h"

/* ---- Display constants ---- */
#define PIXEL_SIZE    8
#define PIXEL_GAP     1
#define PIXEL_STRIDE  (PIXEL_SIZE + PIXEL_GAP)  /* 9 */

#define LCD_DRAW_W    (LCD_WIDTH  * PIXEL_STRIDE)   /* 32*9 = 288 */
#define LCD_DRAW_H    (LCD_HEIGHT * PIXEL_STRIDE)   /* 16*9 = 144 */

#define MARGIN        16
#define ICON_SIZE     12
#define ICON_GAP      4

#define WIN_W         420
#define WIN_H         280

/* ---- Global state ---- */
static bool_t matrix_buffer[LCD_HEIGHT][LCD_WIDTH / 8] = {{0}};
static bool_t icon_buffer[ICON_NUM] = {0};
static uint32_t current_freq = 0;
static bool isPaused = false;

static SDL_Window   *window   = nullptr;
static SDL_Renderer *renderer = nullptr;

/* ---- Pixel Font (Legible 5x7) ---- */
static const uint32_t font5x7[] = {
    0x00000000, // Space
    0x00000000, // ! (skipped)
    0x00000000, // " (skipped)
    0x00000000, // # (skipped)
    0x00000000, // $ (skipped)
    0x00000000, // % (skipped)
    0x00000000, // & (skipped)
    0x00000000, // ' (skipped)
    0x00000000, // ( (skipped)
    0x00000000, // ) (skipped)
    0x00000000, // * (skipped)
    0x00000000, // + (skipped)
    0x00000000, // , (skipped)
    0x00000000, // - (skipped)
    0x00000000, // . (skipped)
    0x00000000, // / (skipped)
    0x0E111315, 0x19110E00, // 0 (using 2x32bit to store 35 bits safely if needed, or just hex)
};

// Standard 5x7 bitmap font (A-Z, 0-9, :)
static const uint8_t font_data[][7] = {
    {0x00,0x00,0x00,0x00,0x00,0x00,0x00}, // (space)
    {0x0E,0x11,0x11,0x11,0x11,0x11,0x0E}, // 0
    {0x04,0x0C,0x04,0x04,0x04,0x04,0x0E}, // 1
    {0x0E,0x11,0x01,0x02,0x04,0x08,0x1F}, // 2
    {0x1F,0x02,0x04,0x02,0x01,0x11,0x0E}, // 3
    {0x02,0x06,0x0A,0x12,0x1F,0x02,0x02}, // 4
    {0x1F,0x10,0x1E,0x01,0x01,0x11,0x0E}, // 5
    {0x06,0x08,0x10,0x1E,0x11,0x11,0x0E}, // 6
    {0x1F,0x01,0x02,0x04,0x08,0x08,0x08}, // 7
    {0x0E,0x11,0x11,0x0E,0x11,0x11,0x0E}, // 8
    {0x0E,0x11,0x11,0x0F,0x01,0x02,0x0C}, // 9
    {0x00,0x04,0x00,0x00,0x04,0x00,0x00}, // :
    {0x00,0x00,0x00,0x00,0x00,0x00,0x00}, // (spacer)
    {0x0E,0x11,0x11,0x1F,0x11,0x11,0x11}, // A
    {0x1E,0x11,0x11,0x1E,0x11,0x11,0x1E}, // B
    {0x0E,0x11,0x10,0x10,0x10,0x11,0x0E}, // C
    {0x1C,0x12,0x11,0x11,0x11,0x12,0x1C}, // D
    {0x1F,0x10,0x10,0x1E,0x10,0x10,0x1F}, // E
    {0x1F,0x10,0x10,0x1E,0x10,0x10,0x10}, // F
    {0x0E,0x11,0x10,0x17,0x11,0x11,0x0F}, // G
    {0x11,0x11,0x11,0x1F,0x11,0x11,0x11}, // H
    {0x0E,0x04,0x04,0x04,0x04,0x04,0x0E}, // I
    {0x01,0x01,0x01,0x01,0x01,0x11,0x0E}, // J
    {0x11,0x12,0x14,0x18,0x14,0x12,0x11}, // K
    {0x10,0x10,0x10,0x10,0x10,0x10,0x1F}, // L
    {0x11,0x1B,0x15,0x15,0x11,0x11,0x11}, // M
    {0x11,0x11,0x19,0x15,0x13,0x11,0x11}, // N
    {0x0E,0x11,0x11,0x11,0x11,0x11,0x0E}, // O
    {0x1E,0x11,0x11,0x1E,0x10,0x10,0x10}, // P
    {0x0E,0x11,0x11,0x11,0x15,0x12,0x0D}, // Q
    {0x1E,0x11,0x11,0x1E,0x14,0x12,0x11}, // R
    {0x0E,0x11,0x10,0x0E,0x01,0x11,0x0E}, // S
    {0x1F,0x04,0x04,0x04,0x04,0x04,0x04}, // T
    {0x11,0x11,0x11,0x11,0x11,0x11,0x0E}, // U
    {0x11,0x11,0x11,0x11,0x11,0x0A,0x04}, // V
    {0x11,0x11,0x11,0x15,0x15,0x1B,0x11}, // W
    {0x11,0x11,0x0A,0x04,0x0A,0x11,0x11}, // X
    {0x11,0x11,0x0A,0x04,0x04,0x04,0x04}, // Y
    {0x1F,0x01,0x02,0x04,0x08,0x10,0x1F}, // Z
    {0x00,0x00,0x00,0x00,0x00,0x00,0x00}, // [ (space)
    {0x00,0x00,0x00,0x00,0x00,0x00,0x00}, // ] (space)
};

static void draw_char(int x, int y, char c, uint8_t r, uint8_t g, uint8_t b) {
    int idx = 0;
    if (c >= '0' && c <= '9') idx = (c - '0') + 1;
    else if (c == ':') idx = 11;
    else if (c >= 'A' && c <= 'Z') idx = (c - 'A') + 13;
    else if (c >= 'a' && c <= 'z') idx = (c - 'a') + 13;
    else if (c == '[') idx = 0;
    else if (c == ']') idx = 0;
    else return;

    SDL_SetRenderDrawColor(renderer, r, g, b, 255);
    for (int row = 0; row < 7; row++) {
        uint8_t bits = font_data[idx][row];
        for (int col = 0; col < 5; col++) {
            if (bits & (1 << (4 - col))) {
                SDL_Rect rect = { x + col * 2, y + row * 2, 2, 2 };
                SDL_RenderFillRect(renderer, &rect);
            }
        }
    }
}

static void draw_string(int x, int y, const char *s, uint8_t r, uint8_t g, uint8_t b) {
    while (*s) {
        if (*s == ' ') x += 8;
        else if (*s == '/') x += 4;
        else {
            draw_char(x, y, *s, r, g, b);
            x += 12; // 5*2 + 2 spacing
        }
        s++;
    }
}

static LARGE_INTEGER qpc_freq;
static uint64_t lastSaveMs = 0;
static bool exitRequested = false;

/* ---- Investigation Mode State ---- */
static bool investigationMode = false;
static int autoSnapshotMins = 0;
static uint32_t lastSnapshotTicks = 0;
static char loadStatePath[MAX_PATH] = {0};
static bool forceBabysitterOff = false;

/* ---- Speed cycling ---- */
/* 0 = 1x, 1 = 10x, 2 = unlimited (0.0f) */
static int speedIndex = 0;
static const float speedValues[] = {1.0f, 10.0f, 0.0f};

/* ---- BMP Export ---- */
static void save_bmp(const char *filename) {
    // 32x16 1-bit BMP is tiny, but for compatibility we'll write a simple 24-bit BMP
    // (Python can read anything, but 24-bit is easiest to write without bit-packing)
    uint32_t width = LCD_WIDTH;
    uint32_t height = LCD_HEIGHT;
    uint32_t rowSize = (width * 3 + 3) & ~3;
    uint32_t size = 54 + rowSize * height;

    unsigned char header[54] = {
        'B','M', 
        (unsigned char)(size), (unsigned char)(size >> 8), (unsigned char)(size >> 16), (unsigned char)(size >> 24),
        0, 0, 0, 0, 54, 0, 0, 0, 40, 0, 0, 0,
        (unsigned char)(width), (unsigned char)(width >> 8), (unsigned char)(width >> 16), (unsigned char)(width >> 24),
        (unsigned char)(height), (unsigned char)(height >> 8), (unsigned char)(height >> 16), (unsigned char)(height >> 24),
        1, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    };

    FILE *f = fopen(filename, "wb");
    if (!f) return;
    fwrite(header, 1, 54, f);

    unsigned char *pixels = (unsigned char *)calloc(rowSize, height);
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            uint8_t mask = 0x80 >> (x % 8);
            bool on = (matrix_buffer[y][x / 8] & mask) != 0;
            int py = height - 1 - y; // BMP is bottom-up
            int px = x * 3;
            if (on) {
                pixels[py * rowSize + px + 0] = 0;   // B
                pixels[py * rowSize + px + 1] = 0;   // G
                pixels[py * rowSize + px + 2] = 140; // R
            } else {
                pixels[py * rowSize + px + 0] = 200; // B
                pixels[py * rowSize + px + 1] = 200; // G
                pixels[py * rowSize + px + 2] = 200; // R
            }
        }
    }
    fwrite(pixels, 1, rowSize * height, f);
    free(pixels);
    fclose(f);
}

static void take_snapshot() {
    char binPath[MAX_PATH];
    char bmpPath[MAX_PATH];
    uint64_t ts = GetTickCount64();
    
    // Ensure captures directory exists
    CreateDirectoryA("captures", NULL);

    sprintf(binPath, "captures/snap_%llu.bin", ts);
    sprintf(bmpPath, "captures/snap_%llu.bmp", ts);

    pc_save_state_to_file(&cpuState, binPath);
    save_bmp(bmpPath);
    printf("[investigation] Snapshot taken: %llu\n", ts);
    fflush(stdout);
}

/* ======================================================
 * HAL callbacks
 * ====================================================== */

static void hal_halt(void) {
    SDL_Quit();
    exit(0);
}

static void hal_log(log_level_t level, char *buff, ...) {
    (void)level;
    va_list args;
    va_start(args, buff);
    vprintf(buff, args);
    va_end(args);
    printf("\n");
    fflush(stdout);
}

static timestamp_t hal_get_timestamp(void) {
    LARGE_INTEGER count;
    QueryPerformanceCounter(&count);
    return (timestamp_t)((count.QuadPart * 1000000ULL) / (uint64_t)qpc_freq.QuadPart);
}

static void hal_sleep_until(timestamp_t ts) {
    while ((int32_t)(ts - hal_get_timestamp()) > 0) {
        Sleep(1);
    }
}

static void hal_set_lcd_matrix(u8_t x, u8_t y, bool_t val) {
    uint8_t mask;
    if (val) {
        mask = 0x80 >> (x % 8);
        matrix_buffer[y][x / 8] = matrix_buffer[y][x / 8] | mask;
    } else {
        mask = 0b01111111;
        for (uint8_t i = 0; i < (x % 8); i++) {
            mask = (mask >> 1) | 0b10000000;
        }
        matrix_buffer[y][x / 8] = matrix_buffer[y][x / 8] & mask;
    }
}

static void hal_set_lcd_icon(u8_t icon, bool_t val) {
    icon_buffer[icon] = val;
}

static void hal_set_frequency(u32_t freq) {
    current_freq = freq;
}

static void hal_play_frequency(bool_t en) {
    (void)en;
    /* no audio in PC build */
}

/* ---- UI rendering for investigation ---- */
static void draw_status_overlay(void) {
    int y = MARGIN + LCD_DRAW_H + ICON_SIZE + 24;
    
    // Background for status
    SDL_Rect bg = { 0, y - 10, WIN_W, WIN_H - (y - 10) };
    SDL_SetRenderDrawColor(renderer, 20, 20, 20, 255);
    SDL_RenderFillRect(renderer, &bg);

    // Speed Indicator
    draw_string(MARGIN, y, "SPEED:", 180, 180, 180);
    const char* speedNames[] = {"1X", "10X", "TURBO"};
    draw_string(MARGIN + 80, y, speedNames[speedIndex], 255, 255, 255);

    // Snapshot Interval
    draw_string(MARGIN + 140, y, "SNAP:", 180, 180, 180);
    char snapBuf[16];
    if (autoSnapshotMins > 0) {
        sprintf(snapBuf, "%dM", autoSnapshotMins);
        draw_string(MARGIN + 200, y, snapBuf, 255, 255, 255);
    } else {
        draw_string(MARGIN + 200, y, "OFF", 255, 120, 120);
    }

    // Babysitter Indicator
    draw_string(MARGIN + 250, y, "BBY:", 180, 180, 180);
    if (currentIntent != INACTIVE) {
        draw_string(MARGIN + 295, y, "ON", 100, 255, 100);
    } else {
        draw_string(MARGIN + 295, y, "OFF", 255, 100, 100);
    }

    // Hotkeys List
    y += 24;
    SDL_SetRenderDrawColor(renderer, 80, 80, 80, 255);
    SDL_RenderDrawLine(renderer, 0, y, WIN_W, y);
    y += 12;
    
    draw_string(MARGIN, y, "ARROWS:BTNS  F:SPD  S:SAVE  []:SNAP", 200, 200, 150);
    y += 18;
    draw_string(MARGIN, y, "R:RESET  K:SNAP  B:BABY  ESC:QUIT", 200, 200, 150);
}

/* ---- Screen rendering ---- */
static void hal_update_screen(void) {
    SDL_SetRenderDrawColor(renderer, 30, 30, 30, 255);
    SDL_RenderClear(renderer);

    SDL_SetRenderDrawBlendMode(renderer, SDL_BLENDMODE_BLEND);

    for (int y = 0; y < LCD_HEIGHT; y++) {
        for (int x = 0; x < LCD_WIDTH; x++) {
            uint8_t mask = 0x80 >> (x % 8);
            bool on = (matrix_buffer[y][x / 8] & mask) != 0;

            SDL_Rect rect = {
                MARGIN + x * PIXEL_STRIDE,
                MARGIN + y * PIXEL_STRIDE,
                PIXEL_SIZE,
                PIXEL_SIZE
            };

            if (on) {
                SDL_SetRenderDrawColor(renderer, 0, 0, 140, 255);
            } else {
                SDL_SetRenderDrawColor(renderer, 0, 0, 140, 20);
            }
            SDL_RenderFillRect(renderer, &rect);
        }
    }

    /* Icons row below LCD */
    int icon_y = MARGIN + LCD_DRAW_H + ICON_GAP;
    for (int i = 0; i < ICON_NUM; i++) {
        SDL_Rect rect = {
            MARGIN + i * (ICON_SIZE + 4),
            icon_y,
            ICON_SIZE,
            ICON_SIZE
        };
        if (icon_buffer[i]) {
            SDL_SetRenderDrawColor(renderer, 80, 180, 255, 255);
        } else {
            SDL_SetRenderDrawColor(renderer, 20, 40, 80, 255);
        }
        SDL_RenderFillRect(renderer, &rect);
    }

    draw_status_overlay();

    SDL_RenderPresent(renderer);
}

/* ---- Reset ---- */
static void perform_reset(void) {
    pc_delete_save();
    memset(matrix_buffer, 0, sizeof(matrix_buffer));
    memset(icon_buffer,   0, sizeof(icon_buffer));
    tamalib_reset();
    resetBabysitterState();
    printf("[reset] Hard reset complete\n");
    fflush(stdout);
}

/* ---- Event handler ---- */
static int hal_handler(void) {
    SDL_Event event;
    while (SDL_PollEvent(&event)) {
        switch (event.type) {
        case SDL_QUIT:
            exitRequested = true;
            return 1;

        case SDL_KEYDOWN:
            switch (event.key.keysym.sym) {
            case SDLK_ESCAPE:
                exitRequested = true;
                return 1;

            /* Left button: left arrow or Z */
            case SDLK_LEFT:
            case SDLK_z:
                hw_set_button(BTN_LEFT, BTN_STATE_PRESSED);
                simulatingButtons = true;
                manualButtonControl = true;
                break;

            /* Middle button: down arrow or X */
            case SDLK_DOWN:
            case SDLK_x:
                hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
                simulatingButtons = true;
                manualButtonControl = true;
                break;

            /* Right button: right arrow or C */
            case SDLK_RIGHT:
            case SDLK_c:
                hw_set_button(BTN_RIGHT, BTN_STATE_PRESSED);
                simulatingButtons = true;
                manualButtonControl = true;
                break;

            /* Investigation: Manual Snapshot */
            case SDLK_k:
                take_snapshot();
                break;

            /* Investigation: Toggle Babysitter */
            case SDLK_b:
                if (currentIntent == INACTIVE) {
                    currentIntent = PROACTIVE;
                    printf("[babysitter] ACTIVE (Proactive)\n");
                } else {
                    currentIntent = INACTIVE;
                    printf("[babysitter] INACTIVE\n");
                }
                fflush(stdout);
                break;

            case SDLK_f:
                speedIndex = (speedIndex + 1) % 3;
                set_cpu_speed_ratio(speedValues[speedIndex]);
                printf("[speed] %.1fx\n",
                       speedValues[speedIndex] == 0.0f ? 999.0f : speedValues[speedIndex]);
                fflush(stdout);
                break;

            case SDLK_LEFTBRACKET:
                if (autoSnapshotMins > 0) autoSnapshotMins--;
                printf("[investigation] Auto-snapshot every %d mins\n", autoSnapshotMins);
                fflush(stdout);
                break;

            case SDLK_RIGHTBRACKET:
                if (autoSnapshotMins == 0) lastSnapshotTicks = cpuState.tick_counter;
                autoSnapshotMins++;
                printf("[investigation] Auto-snapshot every %d mins\n", autoSnapshotMins);
                fflush(stdout);
                break;

            case SDLK_s:
                pc_save_state(&cpuState);
                break;

            case SDLK_r:
                perform_reset();
                break;

            default:
                break;
            }
            break;

        case SDL_KEYUP:
            switch (event.key.keysym.sym) {
            case SDLK_LEFT:
            case SDLK_z:
                hw_set_button(BTN_LEFT, BTN_STATE_RELEASED);
                simulatingButtons = false;
                manualButtonControl = false;
                break;
            case SDLK_DOWN:
            case SDLK_x:
                hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
                simulatingButtons = false;
                manualButtonControl = false;
                break;
            case SDLK_RIGHT:
            case SDLK_c:
                hw_set_button(BTN_RIGHT, BTN_STATE_RELEASED);
                simulatingButtons = false;
                manualButtonControl = false;
                break;
            default:
                break;
            }
            break;

        default:
            break;
        }
    }
    return 0;
}

static hal_t hal = {
    .halt           = &hal_halt,
    .log            = &hal_log,
    .sleep_until    = &hal_sleep_until,
    .get_timestamp  = &hal_get_timestamp,
    .update_screen  = &hal_update_screen,
    .set_lcd_matrix = &hal_set_lcd_matrix,
    .set_lcd_icon   = &hal_set_lcd_icon,
    .set_frequency  = &hal_set_frequency,
    .play_frequency = &hal_play_frequency,
    .handler        = &hal_handler,
};

/* ======================================================
 * main
 * ====================================================== */
int main(int argc, char **argv) {
    QueryPerformanceFrequency(&qpc_freq);

    /* Parse Arguments */
    for (int i = 1; i < argc; i++) {
        if (_stricmp(argv[i], "--load-state") == 0 && i + 1 < argc) {
            strncpy(loadStatePath, argv[++i], MAX_PATH);
        } else if (_stricmp(argv[i], "--auto-snapshot") == 0 && i + 1 < argc) {
            autoSnapshotMins = atoi(argv[++i]);
            investigationMode = true;
        } else if (_stricmp(argv[i], "--no-ntp") == 0) {
            ntpDisabled = true;
        } else if (_stricmp(argv[i], "--babysitter") == 0 && i + 1 < argc) {
            if (_stricmp(argv[++i], "off") == 0) {
                currentIntent = INACTIVE;
                forceBabysitterOff = true;
            }
        } else if (_stricmp(argv[i], "--turbo") == 0) {
            speedIndex = 2; // Unlimited
        }
    }

    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS) != 0) {
        fprintf(stderr, "SDL_Init error: %s\n", SDL_GetError());
        return 1;
    }

    window = SDL_CreateWindow(
        "ArduinoGotchi PC",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        WIN_W, WIN_H,
        SDL_WINDOW_SHOWN
    );
    if (!window) {
        fprintf(stderr, "SDL_CreateWindow error: %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    renderer = SDL_CreateRenderer(window, -1,
        SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (!renderer) {
        renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_SOFTWARE);
    }
    if (!renderer) {
        fprintf(stderr, "SDL_CreateRenderer error: %s\n", SDL_GetError());
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }

    SDL_SetRenderDrawBlendMode(renderer, SDL_BLENDMODE_BLEND);

    tamalib_register_hal(&hal);
    tamalib_set_framerate(TAMA_DISPLAY_FRAMERATE);
    tamalib_init(1000000);

    /* Try loading a saved state */
    if (loadStatePath[0] != '\0') {
        pc_load_state_from_file(&cpuState, loadStatePath);
    } else {
        pc_load_state(&cpuState);
    }

    if (speedIndex != 0) {
        set_cpu_speed_ratio(speedValues[speedIndex]);
    }

    lastSaveMs = SDL_GetTicks64();
    lastSnapshotTicks = cpuState.tick_counter;

    printf("[pc] Running. Keys: arrows/ZXC=buttons, F=speed, S=save, R=reset, K=snapshot, B=babysitter, Esc=quit\n");
    if (investigationMode) {
        printf("[investigation] Auto-snapshot every %d mins\n", autoSnapshotMins);
    }
    fflush(stdout);

    while (!exitRequested) {
        tamalib_mainloop_step_by_step(isPaused ? 1 : 0);

        if (!isPaused) {
            babysitterLoop();
            
            /* Auto-snapshot logic */
            if (autoSnapshotMins > 0) {
                uint32_t currentTicks = cpuState.tick_counter;
                uint32_t diff;
                if (currentTicks >= lastSnapshotTicks) {
                    diff = currentTicks - lastSnapshotTicks;
                } else {
                    // Tick counter wrapped (it's a 32-bit counter in cpuState, though 
                    // TAMA logic might wrap it sooner, TamaLIB usually keeps it linear)
                    diff = (0xFFFFFFFF - lastSnapshotTicks) + currentTicks + 1;
                }

                // 1 min = 60 * TICK_FREQUENCY
                if (diff >= (uint32_t)(autoSnapshotMins * 60 * TICK_FREQUENCY)) {
                    take_snapshot();
                    lastSnapshotTicks = currentTicks;
                }
            }
        }

        /* Auto-release buttons simulated by babysitter */
        if (simulatingButtons && !manualButtonControl) {
            if (buttonReleaseCounter > 0) {
                buttonReleaseCounter--;
            } else {
                hw_set_button(BTN_LEFT,   BTN_STATE_RELEASED);
                hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
                hw_set_button(BTN_RIGHT,  BTN_STATE_RELEASED);
                simulatingButtons = false;
                printf("Simulated buttons released\n");
                fflush(stdout);
            }
        }

        /* Autosave every 2 minutes */
        uint64_t now = SDL_GetTicks64();
        if (now - lastSaveMs > 2ULL * 60ULL * 1000ULL) {
            lastSaveMs = now;
            pc_save_state(&cpuState);
        }
    }

    pc_save_state(&cpuState);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
