
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
#include "networking.h"

#define INTENT PROACTIVE
#define RESPONSIVENESS 1 // how many seconds between each babysitter check

static uint32_t elapsed_check_ticks = 0; // ticks since last babysitter check
static uint32_t elapsed_time_check_ticks = 0; // ticks since last time check

// TODO I would expect this to be as simple as #sec * TIMER_1HZ_PERIOD and yet that math isn't working
// experimentally, 10 * TIMER_1HZ_PERIOD is about once per minute. Hmm...
static uint32_t ticks_between_checks = RESPONSIVENESS * 5 * (TIMER_1HZ_PERIOD); // ticks between babysitter checks
static uint32_t ticks_between_time_checks = 60 * 10 * (TIMER_1HZ_PERIOD); // ticks between time checks (keep relatively infrequent if there is no need to sync perfectly as it may cause an emulation lag spike)

uint8_t getTamaHunger()
{
    // returns tama's hunger level (0-4)
    // A value of 0 is starving, 4 is full
    // the memory values for hunger:
    // 0x0 = hunger 0
    // 0x4 = hunger 1
    // 0x8 = hunger 2
    // 0xC = hunger 3
    // 0xF = hunger 4
    uint8_t hunger = readMemory(MEM_LOC_HUNGER);
    return (hunger == 0xF) ? 4 : hunger / 4;
}
uint8_t getTamaHappiness()
{
    // returns tama's happiness level (0-4)
    // A value of 0 is sad, 4 is happy
    // the memory values for happiness:
    // 0x0 = happiness 0
    // 0x4 = happiness 1
    // 0x8 = happiness 2
    // 0xC = happiness 3
    // 0xF = happiness 4
    uint8_t happiness = readMemory(MEM_LOC_HAPPY);
    return (happiness == 0xF) ? 4 : happiness / 4;
}
uint8_t getTamaPoop()
{
    // return the value of MEM_LOC_POOP
    return readMemory(MEM_LOC_POOP);
}
bool isTamaSick()
{
    // tama is sick if MEM_LOC_SICK is >= 0x08
    uint8_t sickStatus = readMemory(MEM_LOC_SICK);
    return sickStatus >= 0x08;
}

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

  // TODO: check if tama refuses, maybe return False

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

void setTime(tm time)
{
    // 0x0014-15 - Time (hours) (This is a flipped byte. x10 = 1AM, xA0 = 10AM, xF0 = 3PM, x01 = 4PM, x61 = 10PM, x71 = 11PM, x00 = 12PM (midnight)
    /*
    0x00 - 12PM (midnight)
    0x10 - 1AM
    0x20 - 2AM
    0x30 - 3AM
    0x40 - 4AM
    0x50 - 5AM
    0x60 - 6AM
    0x70 - 7AM
    0x80 - 8AM
    0x90 - 9AM
    0xA0 - 10AM
    0xB0 - 11AM
    0xC0 - 12PM (noon)
    0xD0 - 1PM
    0xE0 - 2PM
    0xF0 - 3PM
    0x01 - 4PM
    0x11 - 5PM
    0x21 - 6PM
    0x31 - 7PM
    0x41 - 8PM
    0x51 - 9PM
    0x61 - 10PM
    0x71 - 11PM
    */
   // get the 24h time in DEC, convert to HEX, then flip the bytes
    uint8_t hour = time.tm_hour;
    uint8_t minutes = time.tm_min;
    uint8_t seconds = time.tm_sec;

    // get hex value for each, grab top and bottom digits
    // Ex. 0xA1 = 0xA and 0x1
    uint8_t hoursOnesDigit = hour % 0x10;
    uint8_t hoursTensDigit = hour / 0x10;
    uint8_t minutesOnesDigit = minutes % 10;
    uint8_t minutesTensDigit = minutes / 10;
    uint8_t secondsOnesDigit = seconds % 10;
    uint8_t secondsTensDigit = seconds / 10;

    Serial.println("Setting time in memory...");
    Serial.print("Hour: ");
    Serial.print(hour);
    Serial.print(" (Ones: ");
    Serial.print(hoursOnesDigit, HEX);
    Serial.print(", Tens: ");
    Serial.print(hoursTensDigit, HEX);
    Serial.println(")");
    Serial.print("Minutes: ");
    Serial.print(minutes);
    Serial.print(" (Ones: ");
    Serial.print(minutesOnesDigit, HEX);
    Serial.print(", Tens: ");
    Serial.print(minutesTensDigit, HEX);
    Serial.println(")");
    Serial.print("Seconds: ");
    Serial.print(seconds);
    Serial.print(" (Ones: ");
    Serial.print(secondsOnesDigit, HEX);
    Serial.print(", Tens: ");
    Serial.print(secondsTensDigit, HEX);
    Serial.println(")");

    // TODO I don't like executing 6 memory writes in a row
    setMemory(0x10, secondsOnesDigit);
    setMemory(0x11, secondsTensDigit); // Set 0x11 to seconds in hex (flipped)
    setMemory(0x12, minutesOnesDigit); // Set 0x12 to minutes ones digit in hex (flipped)
    setMemory(0x13, minutesTensDigit); // Set 0x13 to minutes tens digit in hex (flipped)
    setMemory(0x14, hoursOnesDigit); // Set 0x14 to hour in hex (flipped)
    setMemory(0x15, hoursTensDigit);
}
bool setTimeViaNTP()
{
    tm time = getTime();
    setTime(time);
    return true; // Return true if time was successfully set
}

void babysitterLoop()
{
    // this loop is called TIMER_1HZ_PERIOD per second
    // we will use ticks instead of actual seconds in case we are not emulating
    // at realtime
    elapsed_check_ticks++;
    elapsed_time_check_ticks++;

    if (elapsed_time_check_ticks >= ticks_between_time_checks)
    {
        elapsed_time_check_ticks -= ticks_between_time_checks;

        Serial.println("Syncing time...");

        // update the time via NTP
        setTimeViaNTP();
    }

    if (elapsed_check_ticks >= ticks_between_checks)
    {
        elapsed_check_ticks-= ticks_between_checks;

        if (INTENT == PROACTIVE)
        {
            // take care of the tama
            // check for illness
            if (isTamaSick())
            {
                Serial.println("Tama is sick, giving medicine...");
                giveTamaMedicine();
            }

            // get hunger level
            if (getTamaHunger() < 4)
            {
                Serial.println("Tama is hungry, feeding...");
                feedTamaFood();
            }
            
            // get happiness level
            if (getTamaHappiness() < 4)
            {
                Serial.println("Tama is sad, playing game...");
                playTamaGame();
            }

            // check for poop
            if (getTamaPoop() > 0)
            {
                Serial.println("Tama has poop, cleaning...");
                cleanTamaPoop();
            }

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