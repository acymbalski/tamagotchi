#pragma once
/* PC stub for src/input.h — shadows Arduino version, no Arduino dependency */
#include "hal.h"

extern bool_t simulatingButtons;
extern bool_t manualButtonControl;

extern uint16_t buttonReleaseResetValue;
extern uint16_t buttonReleaseCounter;

void resetButtonReleaseCounter();
void pressLeftButton();
void pressMiddleButton();
void pressRightButton();
