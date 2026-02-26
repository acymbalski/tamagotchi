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

#define WIN_W         320
#define WIN_H         196

/* ---- Global state ---- */
static bool_t matrix_buffer[LCD_HEIGHT][LCD_WIDTH / 8] = {{0}};
static bool_t icon_buffer[ICON_NUM] = {0};
static uint32_t current_freq = 0;
static bool isPaused = false;

static SDL_Window   *window   = nullptr;
static SDL_Renderer *renderer = nullptr;

static LARGE_INTEGER qpc_freq;
static uint64_t lastSaveMs = 0;
static bool exitRequested = false;

/* ---- Speed cycling ---- */
/* 0 = 1x, 1 = 10x, 2 = unlimited (0.0f) */
static int speedIndex = 0;
static const float speedValues[] = {1.0f, 10.0f, 0.0f};

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

    SDL_RenderPresent(renderer);
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

            case SDLK_f:
                speedIndex = (speedIndex + 1) % 3;
                set_cpu_speed_ratio(speedValues[speedIndex]);
                printf("[speed] %.1fx\n",
                       speedValues[speedIndex] == 0.0f ? 999.0f : speedValues[speedIndex]);
                fflush(stdout);
                break;

            case SDLK_s:
                pc_save_state(&cpuState);
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
    (void)argc; (void)argv;

    QueryPerformanceFrequency(&qpc_freq);

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
    pc_load_state(&cpuState);

    lastSaveMs = SDL_GetTicks64();

    printf("[pc] Running. Keys: arrows/ZXC=buttons, F=speed, S=save, Esc=quit\n");
    fflush(stdout);

    while (!exitRequested) {
        tamalib_mainloop_step_by_step(isPaused ? 1 : 0);

        if (!isPaused) {
            babysitterLoop();
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
