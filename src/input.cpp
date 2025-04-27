#include "input.h"
#include "Arduino.h"
#include "hw.h"

bool_t simulatingButtons = false;
bool_t manualButtonControl = false;

// via trial and error it looks like buttons are detected after about 140 cycles
uint16_t buttonReleaseResetValue = 140;
uint16_t buttonReleaseCounter = 0;

void resetButtonReleaseCounter()
{
  buttonReleaseCounter = buttonReleaseResetValue;
}
void pressLeftButton()
{
  hw_set_button(BTN_LEFT, BTN_STATE_PRESSED);
  simulatingButtons = true;
  resetButtonReleaseCounter();
  Serial.println("Simulated left button pressed");
}
void pressMiddleButton()
{
  hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
  simulatingButtons = true;
  resetButtonReleaseCounter();
  Serial.println("Simulated middle button pressed");
}
void pressRightButton()
{
  hw_set_button(BTN_RIGHT, BTN_STATE_PRESSED);
  simulatingButtons = true;
  resetButtonReleaseCounter();
  Serial.println("Simulated right button pressed");
}
