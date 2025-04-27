#pragma once

#include "hal.h"

extern bool simulatingButtons;
extern bool_t manualButtonControl;

extern uint8_t buttonReleaseResetValue;
extern uint8_t buttonReleaseCounter;

void resetButtonReleaseCounter();
void pressLeftButton();
void pressMiddleButton();
void pressRightButton();
