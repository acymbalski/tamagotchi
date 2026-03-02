#include "input.h"
#include "hw.h"
#include <stdio.h>
#ifdef STREAM_CAPTURE_ENABLED
#include "stream_capture.h"
#endif

bool_t simulatingButtons = false;
bool_t manualButtonControl = false;

uint16_t buttonReleaseResetValue = 140;
uint16_t buttonReleaseCounter = 0;

void resetButtonReleaseCounter() {
    buttonReleaseCounter = buttonReleaseResetValue;
}

void pressLeftButton() {
    hw_set_button(BTN_LEFT, BTN_STATE_PRESSED);
#ifdef STREAM_CAPTURE_ENABLED
    stream_log_button(BTN_LEFT, BTN_STATE_PRESSED);
#endif
    simulatingButtons = true;
    resetButtonReleaseCounter();
    printf("Simulated left button pressed\n");
    fflush(stdout);
}

void pressMiddleButton() {
    hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
#ifdef STREAM_CAPTURE_ENABLED
    stream_log_button(BTN_MIDDLE, BTN_STATE_PRESSED);
#endif
    simulatingButtons = true;
    resetButtonReleaseCounter();
    printf("Simulated middle button pressed\n");
    fflush(stdout);
}

void pressRightButton() {
    hw_set_button(BTN_RIGHT, BTN_STATE_PRESSED);
#ifdef STREAM_CAPTURE_ENABLED
    stream_log_button(BTN_RIGHT, BTN_STATE_PRESSED);
#endif
    simulatingButtons = true;
    resetButtonReleaseCounter();
    printf("Simulated right button pressed\n");
    fflush(stdout);
}
