
/*

Babysitter logic to manage the tama
Can be set to PROACTIVE, REACTIVE, or INACTIVE
* PROACTIVE: babysitter will automatically take care of the tama
* REACTIVE: babysitter will only take care of the tama when it is called
* INACTIVE: babysitter will not take care of the tama at all



*/
#include "babysitter.h"
#include "cpu.h"
#include "Arduino.h"
#include "input.h"
#include "memory.h"
#include "hw.h"

#define INTENT PROACTIVE
#define RESPONSIVENESS 1 // how many seconds between each babysitter check

static uint32_t elapsed_ticks = 0; // ticks since last babysitter check
static uint32_t ticks_between_checks = RESPONSIVENESS * (TIMER_1HZ_PERIOD / 1000); // ticks between babysitter checks

// uint8_t getTamaHunger()
// {

// }

bool isTamaUnstartedEgg()
{
  // tama is an unstarted egg if tama evolution (5D) is 0 and tama age (tens and ones digits) are both 0
  // realisitically only one memory location is required but I am just being safe here

  // it's important to note that 5D DOES report if the tama is an egg, but
  // if the user has set the time and "started" the tama's life, its age will
  // start incrementing. So if it's an egg AND it has no age, it needs to be
  // "started."
  return readMemory(0x5D) == 0 && readMemory(0x10) == 0 && readMemory(0x11) == 0;
}
bool isTamaEgg()
{
  return readMemory(0x5D) == 0;
}

bool isTamaDead()
{

}

bool isTamaSleeping()
{
  // tama is considered sleeping if 4A is 8-F
  uint8_t sleepStatus = readMemory(0x4A);
  return (sleepStatus >= 0x08 && sleepStatus <= 0x0F);
}

bool isTamaRequestingAttention()
{

}

void feedTamaFood()
{
  // set menu selection to food
  Serial.println("Selecting food menu...");
  setMemory(0x75, 0x01);
  for (int i = 0; i < 1500; i++) {
    loop();
  }
  // press select button for 1500 cycles to open menu
  hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);

  simulatingButtons = true;
  manualButtonControl = true;

  Serial.println("Opening food menu...");
  // cycle to wait for menu to be clicked
  for (int i = 0; i < 3000; i++) {
    loop();
  }
  hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);

  Serial.println("Waiting for food menu to open...");
  // wait for menu to open
  for (int i = 0; i < 1500; i++) {
    loop();
  }

  // select food
  hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
  Serial.println("Selecting food...");
  // wait for tama to finish eating
  for (int i = 0; i < 33000; i++) {
    loop();
  }
  // release button
  hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
  Serial.println("Food selected, tama has eaten.");

  for (int i = 0; i < 1500; i++) {
    loop();
  }
  // we're done, press exit button to close menu
  pressRightButton();
  Serial.println("Exiting food menu...");
  manualButtonControl = false;
  
  setMemory(0x75, 0x00);
}
void feedTamaSnack()
{
  // set menu selection to food
  Serial.println("Selecting food menu...");
  setMemory(0x75, 0x01);
  for (int i = 0; i < 1500; i++) {
    loop();
  }
  // press select button for 1500 cycles to open menu
  hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);

  simulatingButtons = true;
  manualButtonControl = true;

  Serial.println("Opening food menu...");
  // cycle to wait for menu to be clicked
  for (int i = 0; i < 3000; i++) {
    loop();
  }
  hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);

  Serial.println("Waiting for food menu to open...");
  // wait for menu to open
  for (int i = 0; i < 1500; i++) {
    loop();
  }

  // select snack
  hw_set_button(BTN_LEFT, BTN_STATE_PRESSED);
  for (int i = 0; i < 1500; i++) {
    loop();
  }
  hw_set_button(BTN_LEFT, BTN_STATE_RELEASED);

  hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
  Serial.println("Selecting snack...");
  // wait for tama to finish eating
  for (int i = 0; i < 33000; i++) {
    loop();
  }
  // release button
  hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
  Serial.println("Food selected, tama has eaten.");

  for (int i = 0; i < 1500; i++) {
    loop();
  }
  // we're done, press exit button to close menu
  pressRightButton();
  Serial.println("Exiting food menu...");
  manualButtonControl = false;

  setMemory(0x75, 0x00);
}
void giveTamaMedicine()
{

}
void playTamaGame()
{

}
void toggleLights()
{
  // TODO: This is a little broken for some reason
  // toggle lights
  uint8_t currentLights = readMemory(MEM_LOC_LIGHTS);
  if (currentLights == 0x0F)
  {
    Serial.println("Turning off lights...");
    setMemory(MEM_LOC_LIGHTS, 0x00);
  }
  else
  {
    Serial.println("Turning on lights...");
    setMemory(MEM_LOC_LIGHTS, 0x0F);
  }
}
void disciplineTama()
{

}
void cleanTamaPoop()
{

}
void hatchEgg()
{

}
void checkTamaStats()
{

  uint16_t msToDisplay = 3000; // ms per page to display stats

  // set menu selection to stats
  Serial.println("Selecting stats menu...");
  setMemory(0x75, 0x06);
  for (int i = 0; i < 1500; i++) {
    loop();
  }

  // press select button for 1500 cycles to open menu
  hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
  simulatingButtons = true;
  manualButtonControl = true;
  Serial.println("Opening stats menu...");
  // cycle to wait for menu to be clicked
  for (int i = 0; i < 3000; i++) {
    loop();
  }
  hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
  manualButtonControl = false;

  // loop for 3000 ms
  Serial.println("Displaying age/weight stats...");
  unsigned long startTime = millis();
  while (millis() - startTime < msToDisplay) {
    loop();
  }

  pressMiddleButton();
  startTime = millis();
  Serial.println("Displaying discipline stats...");
  while (millis() - startTime < msToDisplay) {
    loop();
  }

  // next page
  pressMiddleButton();
  startTime = millis();
  Serial.println("Displaying hunger stats...");
  while (millis() - startTime < msToDisplay) {
    loop();
  }

  pressMiddleButton();
  startTime = millis();
  Serial.println("Displaying happiness stats...");
  while (millis() - startTime < msToDisplay) {
    loop();
  }

  // that's all! exit stats menu
  pressRightButton();
  Serial.println("Exiting stats menu...");
  setMemory(0x75, 0x00); // reset menu selection to none
}

void setTamaHunger(uint8_t hunger)
{

}
void setTamaHappiness(uint8_t happiness)
{

}
void setTamaDiscipline(uint8_t discipline)
{

}
void setTamaPoop(uint8_t poop)
{

}

bool setTimeViaNTP() {
  // Stub implementation
  // Add NTP time synchronization logic here
  return false; // Return true if time was successfully set
}
void setTime(const char* timeText) {
  // Stub implementation
  // Add logic to parse and set time here
}

void babysitterLoop()
{
    // this loop is called TIMER_1HZ_PERIOD per second
    // we will use ticks instead of actual seconds in case we are not emulating
    // at realtime
    elapsed_ticks++;



    if (elapsed_ticks >= ticks_between_checks)
    {
        elapsed_ticks-= ticks_between_checks;

        if (INTENT == PROACTIVE)
        {
            // take care of the tama
            // check for illness
            // get hunger level
            // get happiness level
            // check for poop

        }
        else if (INTENT == REACTIVE)
        {
            // if tama needs attention...
            // check for illness
            // get hunger level
            // get happiness level
            // check for poop
        }
        else if (INTENT == INACTIVE)
        {
            // do nothing
        }
    }

}