/*
* ArduinoGotchi - A real Tamagotchi emulator for Arduino ESP32
*
* Copyright (C) 2022 Gary Kwok - Arduino Uno Implementation
* Copyright (C) 2022 Marcel Ochsendorf - ESP32 Plattform Support
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public License
* as published by the Free Software Foundation; either version 2
* of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

#include <U8g2lib.h>
#include <Wire.h>

#include "tamalib.h"
#include "hw.h"
#include "bitmaps.h"
#include "cpu.h"
#if defined(ENABLE_AUTO_SAVE_STATUS) || defined(ENABLE_LOAD_STATE_FROM_EEPROM)
#include "savestate.h"
#endif

#if defined(ESP32)
//#include "Tone32.h"
#endif

/***** Set display orientation, U8G2_MIRROR_VERTICAL is not supported *****/
#define U8G2_LAYOUT_NORMAL
// #define U8G2_LAYOUT_ROTATE_180
// #define U8G2_LAYOUT_MIRROR
/**************************************************************************/

#ifdef U8G2_LAYOUT_NORMAL
U8G2_SSD1306_128X64_NONAME_2_HW_I2C display(U8G2_R0);
#endif

#ifdef U8G2_LAYOUT_ROTATE_180
U8G2_SSD1306_128X64_NONAME_2_HW_I2C display(U8G2_R2);
#endif

#ifdef U8G2_LAYOUT_MIRROR
U8G2_SSD1306_128X64_NONAME_2_HW_I2C display(U8G2_MIRROR);
#endif

#if defined(ESP8266_KIT_A)
#define PIN_BTN_L 12
#define PIN_BTN_M 13
#define PIN_BTN_R 15
#define PIN_BUZZER 2
#elif defined(ESP8266_KIT_B)
#define PIN_BTN_L 12
#define PIN_BTN_M 13
#define PIN_BTN_R 15
#define PIN_BUZZER 0
#define ENABLE_TAMA_SOUND
#define ENABLE_TAMA_SOUND_ACTIVE_LOW

#elif defined(ESP32)
#define PIN_BTN_L 26
#define PIN_BTN_M 25
#define PIN_BTN_R 33
#define PIN_BUZZER 15
#define BUZZER_CHANNEL 0
#define TONE_CHANNEL 15

#else
// #define PIN_BTN_L 2
// #define PIN_BTN_M 3
// #define PIN_BTN_R 4
// #define PIN_BUZZER 9
#endif

#define MEM_LOC_SELECTION 75
#define MEM_LOC_HUNGER 40
#define MEM_LOC_HAPPY 41
#define MEM_LOC_DISCIPLINE 43
#define MEM_LOC_LIGHTS 4B
#define MEM_LOC_POOP 4D

#define MENU_NONE 0
#define MENU_FOOD 1
#define MENU_LIGHT 2
#define MENU_GAME 3
#define MENU_MEDICINE 4
#define MENU_CLEAN 5
#define MENU_STATS 6
#define MENU_DISCIPLINE 7

#if defined(ESP32)
void esp32_noTone(uint8_t pin, uint8_t channel)
{
  // ledcDetachPin(pin);
  // ledcWrite(channel, 0);
}

void esp32_tone(uint8_t pin, unsigned int frequency, unsigned long duration, uint8_t channel)
{
  // if (!ledcRead(channel))
  // {
  //   ledcAttachPin(pin, channel);
  // }

  // ledcWriteTone(channel, frequency);
}
#endif

void displayTama();

void setMemory(uint16_t address, uint8_t value);
uint8_t readMemory(uint16_t address);
void dumpStateToSerial();
void dumpStateToSerial2();
bool isTamaUnstartedEgg();
bool isTamaEgg();
bool isTamaSleeping();

void feedTamaFood();

void resetButtonReleaseCounter();
void pressLeftButton();
void pressMiddleButton();
void pressRightButton();

/**** TamaLib Specific Variables ****/
static uint16_t current_freq = 0;
static bool_t matrix_buffer[LCD_HEIGHT][LCD_WIDTH / 8] = {{0}};
// static byte runOnceBool = 0;
static bool_t icon_buffer[ICON_NUM] = {0};
static cpu_state_t cpuState;
static unsigned long lastSaveTimestamp = 0;
static bool isPaused = false;
static bool simulatingButtons = false;
static bool_t manualButtonControl = false;

// via trial and error it looks like buttons are detected after about 140 cycles
static uint8_t buttonReleaseResetValue = 140;
static uint8_t buttonReleaseCounter = 0;
/************************************/

static void hal_halt(void)
{
  Serial.println("Halt!");
}

static void hal_log(log_level_t level, char *buff, ...)
{
  Serial.println(buff);
}

static timestamp_t hal_get_timestamp(void)
{
  return millis() * 1000;
}

static void hal_sleep_until(timestamp_t ts)
{
  int32_t remaining = (int32_t) (ts - hal_get_timestamp());

  if (remaining > 0)
  {
    delayMicroseconds(remaining / 1000);
  }
}

static void hal_update_screen(void)
{
  displayTama();
}

static void hal_set_lcd_matrix(u8_t x, u8_t y, bool_t val)
{
  uint8_t mask;
  if (val)
  {
    mask = 0b10000000 >> (x % 8);
    matrix_buffer[y][x / 8] = matrix_buffer[y][x / 8] | mask;
  }
  else
  {
    mask = 0b01111111;
    for (byte i = 0; i < (x % 8); i++)
    {
      mask = (mask >> 1) | 0b10000000;
    }
    matrix_buffer[y][x / 8] = matrix_buffer[y][x / 8] & mask;
  }
}

static void hal_set_lcd_icon(u8_t icon, bool_t val)
{
  icon_buffer[icon] = val;
}

static void hal_set_frequency(u32_t freq)
{
  current_freq = freq;
}

static void hal_play_frequency(bool_t en)
{
#ifdef ENABLE_TAMA_SOUND
  if (en)
  {

#if defined(ESP32)
    esp32_tone(PIN_BUZZER, current_freq, 500, BUZZER_CHANNEL);
#else
#endif
  }
  else
  {
#if defined(ESP32)
    esp32_noTone(PIN_BUZZER, BUZZER_CHANNEL);
#else
#endif
  }
#endif
}

static bool_t button4state = 0;

static int hal_handler(void)
{
#ifdef ENABLE_SERIAL_DEBUG_INPUT
  if (Serial.available() > 0)
  {
    int incomingByte = Serial.read();
    Serial.println(incomingByte, DEC);
    if (incomingByte == 49)
    {
      hw_set_button(BTN_LEFT, BTN_STATE_PRESSED);
    }
    else if (incomingByte == 50)
    {
      hw_set_button(BTN_LEFT, BTN_STATE_RELEASED);
    }
    else if (incomingByte == 51)
    {
      hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    }
    else if (incomingByte == 52)
    {
      hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    }
    else if (incomingByte == 53)
    {
      hw_set_button(BTN_RIGHT, BTN_STATE_PRESSED);
    }
    else if (incomingByte == 54)
    {
      hw_set_button(BTN_RIGHT, BTN_STATE_RELEASED);
    }
  }
#endif

  // support memory operations from serial
  if (Serial.available() > 0)
  {
    String input = Serial.readStringUntil('\n');
    input.trim();
    int spaceIndex = input.indexOf(' ');
    if (input.equalsIgnoreCase("dump"))
    {
      dumpStateToSerial();
    }
    else if (input.equalsIgnoreCase("dump2"))
    {
      dumpStateToSerial2();
    }
    else if (input.startsWith("step"))
    {
      isPaused = true;

      String stepCountStr = input.substring(5);
      stepCountStr.trim();
      int stepCount = stepCountStr.toInt();
      if (stepCount <= 0)
      {
        stepCount = 1; // Default to 1 if no number is given or invalid input
      }

      Serial.print("Stepping CPU ");
      Serial.print(stepCount);
      Serial.println(" time(s)");

      for (int i = 0; i < stepCount; i++)
      {
        tamalib_mainloop_step_by_step(false);
      }
      Serial.println("Done");
    }
    else if (input.equalsIgnoreCase("resume"))
    {
      isPaused = false;
      Serial.println("Resuming CPU");
    }
    else if (input.equalsIgnoreCase("reset"))
    {
      tamalib_init(1000000);
    }
    else if (input.equalsIgnoreCase("egg"))
    {
      if (isTamaUnstartedEgg())
      {
        Serial.println("Tama is an unstarted egg");
      }
      else if (isTamaEgg())
      {
        Serial.println("Tama is an egg");
      }
      else
      {
        Serial.println("Tama is not egg");
      }
    }
    else if (input.equalsIgnoreCase("sleeping"))
    {
      if (isTamaSleeping())
      {
        Serial.println("Tama is sleeping");
      }
      else
      {
        Serial.println("Tama is not sleeping");
      }
    }
    else if (input.equalsIgnoreCase("feed food"))
    {
      Serial.println("Feeding Tama food");
      feedTamaFood();
    }
    else if (input.equalsIgnoreCase("LD"))
    {
      // press L button
      hw_set_button(BTN_LEFT, BTN_STATE_PRESSED);
      Serial.println("Left button pressed");
      simulatingButtons = true;
      manualButtonControl = true;
    }
    else if (input.equalsIgnoreCase("LU"))
    {
      hw_set_button(BTN_LEFT, BTN_STATE_RELEASED);
      Serial.println("Left button released");
      simulatingButtons = false;
    }
    else if (input.equalsIgnoreCase("MD"))
    {
      hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
      Serial.println("Middle button pressed");
      simulatingButtons = true;
      manualButtonControl = true;
    }
    else if (input.equalsIgnoreCase("MU"))
    {
      hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
      Serial.println("Middle button released");
      simulatingButtons = false;
      manualButtonControl = false;
    }
    else if (input.equalsIgnoreCase("RD"))
    {
      hw_set_button(BTN_RIGHT, BTN_STATE_PRESSED);
      Serial.println("Right button pressed");
      simulatingButtons = true;
      manualButtonControl = true;
    }
    else if (input.equalsIgnoreCase("RU"))
    {
      hw_set_button(BTN_RIGHT, BTN_STATE_RELEASED);
      Serial.println("Right button released");
      simulatingButtons = false;
      manualButtonControl = false;
    }
    else if (input.equalsIgnoreCase("L"))
    {
      pressLeftButton();
    }
    else if (input.equalsIgnoreCase("M"))
    {
      pressMiddleButton();
    }
    else if (input.equalsIgnoreCase("R"))
    {
      pressRightButton();
    }

    else if (input.startsWith("speed"))
    {
      String speedStr = input.substring(6);
      float speed = speedStr.toFloat();
      if (speed >= 0)
      {
        set_cpu_speed_ratio(speed);
        Serial.print("CPU speed ratio set to: ");
        Serial.println(speed);
      }
      else
      {
        Serial.println("Invalid speed value");
      }
    }
    else if (input.equalsIgnoreCase("load"))
    {
      loadHardcodedState(&cpuState);
    }
    else if (spaceIndex == -1)
    {
      // Only address provided
      uint16_t address = strtol(input.c_str(), NULL, 16);
      uint8_t value = readMemory(address);
      dumpStateToSerial2();
      Serial.println("");
      Serial.print("Value at 0x");
      Serial.print(address, HEX);
      Serial.print(": 0x");
      Serial.println(value, HEX);
    }
    else
    {
      // Address and value provided
      String addressStr = input.substring(0, spaceIndex);
      String valueStr = input.substring(spaceIndex + 1);
      uint16_t address = strtol(addressStr.c_str(), NULL, 16);
      uint8_t value = strtol(valueStr.c_str(), NULL, 16);
      setMemory(address, value);
      Serial.print("Set 0x");
      Serial.print(address, HEX);
      Serial.print(" to 0x");
      Serial.println(value, HEX);
    }
  }

  // support buttons

  // if we are simulating buttons via serial or other means, do not attempt
  // to set/reset button state via hardware pins
  if (!simulatingButtons)
  {
    if (digitalRead(PIN_BTN_L) == BUTTON_VOLTAGE_LEVEL_PRESSED)
    {
      hw_set_button(BTN_LEFT, BTN_STATE_PRESSED);
    }
    else
    {
      hw_set_button(BTN_LEFT, BTN_STATE_RELEASED);
    }

    if (digitalRead(PIN_BTN_M) == BUTTON_VOLTAGE_LEVEL_PRESSED)
    {
      hw_set_button(BTN_MIDDLE, BTN_STATE_PRESSED);
    }
    else
    {
      hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
    }

    if (digitalRead(PIN_BTN_R) == BUTTON_VOLTAGE_LEVEL_PRESSED)
    {
      hw_set_button(BTN_RIGHT, BTN_STATE_PRESSED);
    }
    else
    {
      hw_set_button(BTN_RIGHT, BTN_STATE_RELEASED);
    }
  }
  return 0;
}

static hal_t hal = {
    .halt = &hal_halt,
    .log = &hal_log,
    .sleep_until = &hal_sleep_until,
    .get_timestamp = &hal_get_timestamp,
    .update_screen = &hal_update_screen,
    .set_lcd_matrix = &hal_set_lcd_matrix,
    .set_lcd_icon = &hal_set_lcd_icon,
    .set_frequency = &hal_set_frequency,
    .play_frequency = &hal_play_frequency,
    .handler = &hal_handler,
};

// memory manipulation

uint8_t readMemory(uint16_t address)
{
  cpu_get_state(&cpuState);
  if (address < MEMORY_SIZE)
  {
    uint16_t original_address = address;
    // take memory address and divide it by two
    // if it has an odd address, read the lower nibble, otherwise the upper nibble
    // read correct value
    if ((address & 0x1) == 0)
    {
      // even address, read upper nibble
      address = address >> 1; // divide by 2
      return (cpuState.memory[address] & 0xF0) >> 4;
    }
    else
    {
      // odd address, read lower nibble
      address = address >> 1; // divide by 2
      return cpuState.memory[address] & 0x0F;
    }
    Serial.println("Reading memory");
    return cpuState.memory[address];
  }
  else
  {
    Serial.println("Error: Address out of bounds");
    return 0;
  }
}

void setMemory(uint16_t address, uint8_t value)
{

  cpu_get_state(&cpuState);

  if (address < MEMORY_SIZE)
  {
    uint16_t original_address = address;
    // take memory address and divide it by two
    // if it has an odd address, set the lower nibble, otherwise the upper nibble

    if ((address & 0x1) == 0)
    {
      // even address, set upper nibble
      value = (value << 4) | (cpuState.memory[address] & 0x0F);
    }
    else
    {
      // odd address, set lower nibble
      value = (value & 0x0F) | (cpuState.memory[address] & 0xF0);
    }
    // divide address by 2 to get the correct memory location
    address = address >> 1;

    Serial.print("Updating memory from ");
    Serial.print(cpuState.memory[address], HEX);
    Serial.print(" to ");
    Serial.println(value, HEX);
    cpuState.memory[address] = value;
    cpu_set_state(&cpuState);
    return;
  }
  else
  {
    Serial.println("Error: Address out of bounds");
    return;
  }
}

// drawing

void drawTriangle(uint8_t x, uint8_t y)
{
  // display.drawLine(x,y,x+6,y);
  display.drawLine(x + 1, y + 1, x + 5, y + 1);
  display.drawLine(x + 2, y + 2, x + 4, y + 2);
  display.drawLine(x + 3, y + 3, x + 3, y + 3);
}

void drawTamaRow(uint8_t tamaLCD_y, uint8_t ActualLCD_y, uint8_t thick)
{
  uint8_t i;
  for (i = 0; i < LCD_WIDTH; i++)
  {
    uint8_t mask = 0b10000000;
    mask = mask >> (i % 8);
    if ((matrix_buffer[tamaLCD_y][i / 8] & mask) != 0)
    {
      display.drawBox(i + i + i + 16, ActualLCD_y, 2, thick);
    }
  }
}

// Draw icons on screen
void drawTamaSelection(uint8_t y)
{
  uint8_t i;
  for (i = 0; i < 7; i++)
  {
    if (icon_buffer[i])
      drawTriangle(i * 16 + 5, y);
    display.drawXBMP(i * 16 + 4, y + 6, 16, 9, bitmaps + i * 18);
  }
  if (icon_buffer[7])
  {
    drawTriangle(7 * 16 + 5, y);
    display.drawXBMP(7 * 16 + 4, y + 6, 16, 9, bitmaps + 7 * 18);
  }
}

void displayTama()
{
  uint8_t j;
  display.firstPage();
#ifdef U8G2_LAYOUT_ROTATE_180
  drawTamaSelection(49);
  display.nextPage();

  for (j = 11; j < LCD_HEIGHT; j++)
  {
    drawTamaRow(j, j + j + j, 2);
  }
  display.nextPage();

  for (j = 5; j <= 10; j++)
  {
    if (j == 5)
    {
      drawTamaRow(j, j + j + j + 1, 1);
    }
    else
    {
      drawTamaRow(j, j + j + j, 2);
    }
  }
  display.nextPage();

  for (j = 0; j <= 5; j++)
  {
    if (j == 5)
    {
      drawTamaRow(j, j + j + j, 1);
    }
    else
    {
      drawTamaRow(j, j + j + j, 2);
    }
  }
  display.nextPage();
#else
  for (j = 0; j < LCD_HEIGHT; j++)
  {
    if (j != 5)
      drawTamaRow(j, j + j + j, 2);
    if (j == 5)
    {
      drawTamaRow(j, j + j + j, 1);
      display.nextPage();
      drawTamaRow(j, j + j + j + 1, 1);
    }
    if (j == 10)
      display.nextPage();
  }
  display.nextPage();
  drawTamaSelection(49);
  display.nextPage();
#endif
}

void dumpStateToSerial()
{
  uint16_t i, count = 0;
  char tmp[10];
  cpu_get_state(&cpuState);
  u4_t *memTemp = cpuState.memory;
  uint8_t *cpuS = (uint8_t *)&cpuState;

  Serial.println("");
  Serial.println("static const uint8_t hardcodedState[] PROGMEM = {");
  for (i = 0; i < sizeof(cpu_state_t); i++, count++)
  {
    sprintf(tmp, "0x%02X,", cpuS[i]);
    Serial.print(tmp);
    if ((count % 16) == 15)
      Serial.println("");
  }
  Serial.print(":::");
  for (i = 0; i < MEMORY_SIZE; i++, count++)
  {
    sprintf(tmp, "0x%02X,", memTemp[i]);
    Serial.print(tmp);
    if ((count % 16) == 15)
      Serial.println("");
  }
  Serial.println("};");
  /*
    Serial.println("");
    Serial.println("static const uint8_t bitmaps[] PROGMEM = {");
    for(i=0;i<144;i++) {
      sprintf(tmp, "0x%02X,", bitmaps_raw[i]);
      Serial.print(tmp);
      if ((i % 18)==17) Serial.println("");
    }
    Serial.println("};");  */
}

void dumpStateToSerial2()
{
  dumpStateToSerial();
  uint16_t i = 0;
  uint16_t count = 1;
  char tmp[10];
  cpu_get_state(&cpuState);
  u4_t *memTemp = cpuState.memory;
  uint8_t *cpuS = (uint8_t *)&cpuState;

  Serial.println("");
  Serial.println("CPU State Dump:");
  Serial.println("========================================");

  uint8_t rowNum = 0;

  Serial.printf("0x%03X: ", rowNum * 0x080);
  rowNum++;

  for (i = 0; i < sizeof(cpu_state_t); i++, count++)
  {
    Serial.printf("%02X", cpuS[i]);

    if (count % 64 == 0)
    {
      Serial.println("");
      Serial.printf("0x%03X: ", rowNum * 0x080);
      rowNum++;
    }
  }

  Serial.println("");
  Serial.println("");
  Serial.println("Memory Dump:");
  Serial.println("========================================");
  count = 1;
  rowNum = 0;
  Serial.printf("0x%03X: ", rowNum * 0x080);
  rowNum++;

  for (i = 0; i < MEMORY_SIZE; i++, count++)
  {
      Serial.printf("%02X", memTemp[i]);

    if (count % 64 == 0)
    {
      Serial.println("");
      Serial.printf("0x%03X: ", rowNum * 0x080);
      rowNum++;
    }
  }

  Serial.println("");
}

uint8_t reverseBits(uint8_t num)
{
  uint8_t reverse_num = 0;
  uint8_t i;
  for (i = 0; i < 8; i++)
  {
    if ((num & (1 << i)))
      reverse_num |= 1 << ((8 - 1) - i);
  }
  return reverse_num;
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

}
void giveTamaMedicine()
{

}
void playTamaGame()
{

}
void toggleLights()
{

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

void setup()
{
  Serial.begin(SERIAL_BAUD);

  pinMode(PIN_BTN_L, INPUT);
  pinMode(PIN_BTN_M, INPUT);
  pinMode(PIN_BTN_R, INPUT);

#if defined(ESP32)
  //ledcSetup(BUZZER_CHANNEL, NOTE_C4, 8);
#endif

//  display.setI2CAddress(DISPLAY_I2C_ADDRESS * 2);
  display.begin();

  tamalib_register_hal(&hal);
  tamalib_set_framerate(TAMA_DISPLAY_FRAMERATE);
  tamalib_init(1000000);

#if defined(ENABLE_AUTO_SAVE_STATUS) || defined(ENABLE_LOAD_STATE_FROM_EEPROM)
  initEEPROM();
#endif

#ifdef ENABLE_LOAD_STATE_FROM_EEPROM
  if (validEEPROM())
  {
    loadStateFromEEPROM(&cpuState);
  }
  else
  {
    Serial.println(F("No magic number in state, skipping state restore"));
  }
#elif ENABLE_LOAD_HARCODED_STATE_WHEN_START
  loadHardcodedState();
#endif

#ifdef ENABLE_DUMP_STATE_TO_SERIAL_WHEN_START
  dumpStateToSerial();
#endif
}

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

uint32_t right_long_press_started = 0;

void loop()
{
  tamalib_mainloop_step_by_step(isPaused);

  if (simulatingButtons && !manualButtonControl)
  {
    // if we are simulating buttons, we need to release them after a few cycles
    // to ensure the input is caught
    if (buttonReleaseCounter > 0)
    {
      buttonReleaseCounter--;
    }
    else
    {
      // if we simulated a button down, reset the button state now that it has
      // been processed
      // release buttons after set amount of cycles
      hw_set_button(BTN_LEFT, BTN_STATE_RELEASED);
      hw_set_button(BTN_MIDDLE, BTN_STATE_RELEASED);
      hw_set_button(BTN_RIGHT, BTN_STATE_RELEASED);
      simulatingButtons = false;
      Serial.println("Simulated buttons released");
    }
  }

#ifdef ENABLE_AUTO_SAVE_STATUS
  if ((millis() - lastSaveTimestamp) > (AUTO_SAVE_MINUTES * 60 * 1000))
  {
    lastSaveTimestamp = millis();
    saveStateToEEPROM(&cpuState);
  }

  if (digitalRead(PIN_BTN_M) == BUTTON_VOLTAGE_LEVEL_PRESSED)
  {
    if (millis() - right_long_press_started > AUTO_SAVE_MINUTES * 1000)
    {
      eraseStateFromEEPROM();
      Serial.println("Erased EEPROM, restarting...");
#if defined(ESP8266) || defined(ESP32)
      ESP.restart();
#endif
    }
  }
  else
  {
    right_long_press_started = millis();
  }
#endif
}