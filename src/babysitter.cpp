
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
#include "tamalib.h"

BabysitterMode currentIntent = INTENT;
ForceLevel currentForceLevel = FORCE_OFF;
bool ntpDisabled = false;

static uint32_t elapsed_check_ticks = 0; // ticks since last babysitter check
static uint32_t elapsed_time_check_ticks = 0; // ticks since last time check
static bool eggInitiated = false; // set after hatchEgg() runs; cleared on hard reset

void resetBabysitterState() {
    eggInitiated = false;
}

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
  // The ROM has two distinct egg states:
  //   1. Uninitialized: clock has never been set; the ROM is sitting on the
  //      clock-setting screen. ALL time registers (0x10-0x15) are zero.
  //   2. Initialized (incubating): clock is running; the egg will hatch on
  //      its own. At least one time register is non-zero.
  //
  // Checking only seconds (0x10/0x11) is unreliable - they are legitimately
  // zero at the start of every minute. We check all six BCD time registers.
  // After hatchEgg() sets the time via NTP, at least one register will be
  // non-zero, so all-zero is false and we stop trying to re-hatch.
  // The eggInitiated flag is the primary guard against re-triggering; this
  // check is only the initial trigger on a truly fresh start.
  if (readMemory(0x5D) != 0) return false;  // not an egg at all
  return readMemory(0x10) == 0 &&  // seconds ones
         readMemory(0x11) == 0 &&  // seconds tens
         readMemory(0x12) == 0 &&  // minutes ones
         readMemory(0x13) == 0 &&  // minutes tens
         readMemory(0x14) == 0 &&  // hours ones
         readMemory(0x15) == 0;    // hours tens
}
bool isTamaEgg()
{
  return readMemory(0x5D) == 0;
}

bool isTamaDead()
{
  return false; // stub - not yet implemented
}

bool isTamaSleeping()
{
  // tama is considered sleeping if 4A is 8-F
  uint8_t sleepStatus = readMemory(0x4A);
  return (sleepStatus >= 0x08 && sleepStatus <= 0x0F);
}

bool isTamaRequestingAttention()
{
    uint8_t needsAttention = readMemory(MEM_LOC_ATTENTION);
    // tama is calling for attention if MEM_LOC_ATTENTION is not zero
    return needsAttention != 0;
}

bool isTamaNeedingAttention()
{
  return false; // stub - not yet implemented
}

/* ---- Automation helpers ---- */

// Runs emulator steps until condition() returns true or maxCycles is exceeded.
// Logs a warning on timeout. The emulator advances regardless, so this
// replaces fixed-cycle wait loops while also verifying expected state.
template<typename Pred>
static bool waitFor(Pred condition, uint32_t maxCycles, const char *description) {
    for (uint32_t i = 0; i < maxCycles; i++) {
        tamalib_mainloop_step_by_step(false);
        if (condition()) return true;
    }
    Serial.print("WARNING: timed out waiting for: ");
    Serial.println(description);
    return false;
}

/* ---- Babysitter actions ---- */

void feedTamaFood()
{
    Serial.println("Selecting food menu...");
    setMemory(MEM_LOC_MENU, MENU_FOOD);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    simulatingButtons = true;
    manualButtonControl = true;
    for (int i = 0; i < 3000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    for (int i = 0; i < 33000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);
    pressRightButton();
    manualButtonControl = false;
    setMemory(MEM_LOC_MENU, MENU_NONE);
}

void feedTamaSnack()
{
    Serial.println("Selecting food menu for snack...");
    setMemory(MEM_LOC_MENU, MENU_FOOD);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    simulatingButtons = true;
    manualButtonControl = true;
    for (int i = 0; i < 3000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_LEFT, BTN_STATE_PRESSED);
    for (int i = 0; i < 3000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_LEFT, BTN_STATE_RELEASED);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    for (int i = 0; i < 33000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);
    pressRightButton();
    manualButtonControl = false;
    setMemory(MEM_LOC_MENU, MENU_NONE);
}

void giveTamaMedicine()
{
    Serial.println("Selecting medicine menu...");
    setMemory(MEM_LOC_MENU, MENU_MEDICINE);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    simulatingButtons = true;
    manualButtonControl = true;
    for (int i = 0; i < 3000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    for (int i = 0; i < 33000; i++) tamalib_mainloop_step_by_step(false);
    manualButtonControl = false;
    setMemory(MEM_LOC_MENU, MENU_NONE);
}

void playTamaGame()
{
    Serial.println("Selecting game menu...");
    setMemory(MEM_LOC_MENU, MENU_GAME);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    simulatingButtons = true;
    manualButtonControl = true;
    for (int i = 0; i < 3000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);

    for (int i = 0; i < 5; i++)
    {
        setMemory(0x84, 0x08); // force a win
        hw_set_button(BTN_LEFT, BTN_STATE_PRESSED);
        for (int j = 0; j < 42000; j++) tamalib_mainloop_step_by_step(false);
        hw_set_button(BTN_LEFT, BTN_STATE_RELEASED);
        for (int j = 0; j < 3000; j++) tamalib_mainloop_step_by_step(false);
    }

    manualButtonControl = false;
    setMemory(MEM_LOC_MENU, MENU_NONE);
    Serial.println("Exiting game...");
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
    Serial.println("Selecting clean menu...");
    setMemory(MEM_LOC_MENU, MENU_CLEAN);
    for (int i = 0; i < 1500; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    simulatingButtons = true;
    manualButtonControl = true;
    for (int i = 0; i < 3000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    for (int i = 0; i < 33000; i++) tamalib_mainloop_step_by_step(false);
    manualButtonControl = false;
    setMemory(MEM_LOC_MENU, MENU_NONE);
}

void hatchEgg()
{
    simulatingButtons = true;
    manualButtonControl = true;

    // The time-set screen has a blinking cursor — screenChanged() fires on
    // every blink, not on actual navigation. Use fixed waits here so button
    // presses land at the right time regardless of animation phase.

    // Let the ROM fully settle on the time-set screen before touching anything
    Serial.println("Hatch: waiting for ROM to settle...");
    for (int i = 0; i < 2 * TIMER_1HZ_PERIOD; i++) tamalib_mainloop_step_by_step(false);

    // Open the time-setting screen
    Serial.println("Hatch: opening time-set screen...");
    hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    for (int i = 0; i < 3000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    for (int i = 0; i < TIMER_1HZ_PERIOD; i++) tamalib_mainloop_step_by_step(false);

    // Write NTP time directly into registers while the time-set screen is open
    Serial.println("Hatch: writing NTP time into registers...");
    setTimeViaNTP();
    waitFor([](){
        return readMemory(0x10) != 0 || readMemory(0x11) != 0 ||
               readMemory(0x12) != 0 || readMemory(0x13) != 0 ||
               readMemory(0x14) != 0 || readMemory(0x15) != 0;
    }, TIMER_1HZ_PERIOD, "time registers non-zero after NTP write");

    // Confirm the time to start the simulation
    Serial.println("Hatch: confirming time to start simulation...");
    hw_set_button(BTN_RIGHT, BTN_STATE_PRESSED);
    for (int i = 0; i < 3000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_RIGHT, BTN_STATE_RELEASED);
    for (int i = 0; i < TIMER_1HZ_PERIOD; i++) tamalib_mainloop_step_by_step(false);

    // Close the time-set screen / return to main egg screen
    Serial.println("Hatch: closing time-set screen...");
    hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    for (int i = 0; i < 3000; i++) tamalib_mainloop_step_by_step(false);
    hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    for (int i = 0; i < TIMER_1HZ_PERIOD; i++) tamalib_mainloop_step_by_step(false);

    manualButtonControl = false;
    Serial.println("Hatch: egg clock set. Incubation started - egg will hatch on its own.");
}
void checkTamaStats()
{

  uint16_t msToDisplay = 3000; // ms per page to display stats

  // set menu selection to stats
  Serial.println("Selecting stats menu...");
  setMemory(0x75, 0x06);
  for (int i = 0; i < 1500; i++) {
    tamalib_mainloop_step_by_step(false);
  }

  // press select button for 1500 cycles to open menu
  hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
  simulatingButtons = true;
  manualButtonControl = true;
  Serial.println("Opening stats menu...");
  // cycle to wait for menu to be clicked
  for (int i = 0; i < 3000; i++) {
    tamalib_mainloop_step_by_step(false);
  }
  hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
  manualButtonControl = false;

  // loop for 3000 ms
  Serial.println("Displaying age/weight stats...");
  unsigned long startTime = millis();
  while (millis() - startTime < msToDisplay) {
    tamalib_mainloop_step_by_step(false);
  }

  hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
  startTime = millis();
  Serial.println("Displaying discipline stats...");
  while (millis() - startTime < msToDisplay) {
    tamalib_mainloop_step_by_step(false);
  }
  hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
  for (int i = 0; i < 3000; i++) {
    tamalib_mainloop_step_by_step(false);
  }

  // next page
  hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
  startTime = millis();
  Serial.println("Displaying hunger stats...");
  while (millis() - startTime < msToDisplay) {
    tamalib_mainloop_step_by_step(false);
  }
  hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
  for (int i = 0; i < 3000; i++) {
    tamalib_mainloop_step_by_step(false);
  }

  hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
  startTime = millis();
  Serial.println("Displaying happiness stats...");
  while (millis() - startTime < msToDisplay) {
    tamalib_mainloop_step_by_step(false);
  }
  hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
  for (int i = 0; i < 3000; i++) {
    tamalib_mainloop_step_by_step(false);
  }

  // that's all! exit stats menu
  pressRightButton();
  Serial.println("Exiting stats menu...");
  setMemory(MEM_LOC_MENU, MENU_NONE); // reset menu selection to none
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

void forceAgeUp()
{
    uint8_t age = readMemory(MEM_LOC_AGE);
    setMemory(MEM_LOC_AGE, age + 1);
    Serial.print("forceAgeUp: age ");
    Serial.print(age);
    Serial.print(" -> ");
    Serial.println(age + 1);

#if MEM_LOC_CARE_MISTAKES != 0x3FF
    // Zero care mistakes so the ROM picks the best-quality character at evolution.
    setMemory(MEM_LOC_CARE_MISTAKES, 0);
    Serial.println("forceAgeUp: care_mistakes zeroed");
#endif
}

void setCharacter(uint8_t id)
{
#if MEM_LOC_CHARACTER != 0x3FF
    setMemory(MEM_LOC_CHARACTER, id);
    Serial.print("setCharacter: -> 0x");
    Serial.println(id, HEX);
#else
    Serial.println("setCharacter: MEM_LOC_CHARACTER not yet discovered — no-op");
#endif
}

void babysitterLoop()
{
    if (currentIntent == INACTIVE) return;

    // this loop is called TIMER_1HZ_PERIOD per second
    // we will use ticks instead of actual seconds in case we are not emulating
    // at realtime
    elapsed_check_ticks++;
    elapsed_time_check_ticks++;

    if (!ntpDisabled && !eggInitiated && isTamaUnstartedEgg()) {
        Serial.println("Unstarted egg detected, auto-hatching...");
        hatchEgg();
        eggInitiated = true;
        return;
    }

    if (!ntpDisabled && elapsed_time_check_ticks >= ticks_between_time_checks)
    {
        elapsed_time_check_ticks -= ticks_between_time_checks;

        Serial.println("Syncing time...");

        // update the time via NTP
        setTimeViaNTP();
    }

    if (elapsed_check_ticks >= ticks_between_checks)
    {
        elapsed_check_ticks-= ticks_between_checks;

        if (isTamaEgg())
            return;

        if (currentIntent == FORCE)
        {
            uint8_t target = 0;
            switch (currentForceLevel) {
                case FORCE_MIN: target = 1; break;
                case FORCE_LOW: target = 2; break;
                case FORCE_MED: target = 3; break;
                case FORCE_MAX: target = 4; break;
                default: return;
            }

            // Memory values: 0x0=0, 0x4=1, 0x8=2, 0xC=3, 0xF=4
            uint8_t mem_val = (target == 4) ? 0x0F : (target * 4);
            
            if (getTamaHunger() < target) setMemory(MEM_LOC_HUNGER, mem_val);
            if (getTamaHappiness() < target) setMemory(MEM_LOC_HAPPY, mem_val);
            
            // Instantly clear poop and sickness in any FORCE level
            if (getTamaPoop() > 0) setMemory(MEM_LOC_POOP, 0);
            if (isTamaSick()) setMemory(MEM_LOC_SICK, 0);
            
            return;
        }

        if (currentIntent == PROACTIVE)
        {
            // take care of the tama
            // check for illness
            if (isTamaSick())
            {
                Serial.println("Tama is sick, giving medicine...");
                giveTamaMedicine();
                return;
            }

            // check for poop
            if (getTamaPoop() > 0)
            {
                Serial.println("Tama has poop, cleaning...");
                cleanTamaPoop();
                return;
            }

            // get hunger level
            if (getTamaHunger() < 4)
            {
                Serial.println("Tama is hungry, feeding...");
                feedTamaFood();
                return;
            }
            
            // get happiness level
            if (getTamaHappiness() < 4)
            {
                Serial.println("Tama is sad, playing game...");
                playTamaGame();
                return;
            }

        }
        else if (currentIntent == REACTIVE)
        {
            // if tama needs attention...
            // check for illness
            // get hunger level
            // get happiness level
            // check for poop
        }
        else if (currentIntent == INACTIVE)
        {
            // do nothing
        }
    }

}