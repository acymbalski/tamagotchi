#ifndef BABYSITTER_H
#define BABYSITTER_H

#include "time.h"

#define MEM_LOC_SELECTION 0x75
#define MEM_LOC_HUNGER 0x40
#define MEM_LOC_HAPPY 0x41
#define MEM_LOC_AGE 0x54
#define MEM_LOC_DISCIPLINE 0x43
#define MEM_LOC_SICK 0x48
#define MEM_LOC_LIGHTS 0x4B
#define MEM_LOC_POOP 0x4D
#define MEM_LOC_MENU 0x75
#define MEM_LOC_ATTENTION 0x02D
#define MEM_LOC_WEIGHT 0x046

#define MENU_NONE 0x0
#define MENU_FOOD 0x1
#define MENU_LIGHT 0x2
#define MENU_GAME 0x3
#define MENU_MEDICINE 0x4
#define MENU_CLEAN 0x5
#define MENU_STATS 0x6
#define MENU_DISCIPLINE 0x7

typedef enum {
    PROACTIVE,
    REACTIVE,
    INACTIVE
} BabysitterMode;

#define INTENT PROACTIVE
#define RESPONSIVENESS 1 // how many seconds between each babysitter check

extern BabysitterMode currentIntent;
extern bool ntpDisabled;

bool isTamaUnstartedEgg();
bool isTamaEgg();
bool isTamaSleeping();

uint8_t getTamaHunger();
uint8_t getTamaHappiness();
uint8_t getTamaPoop();
bool isTamaSick();

void hatchEgg();
void feedTamaFood();
void feedTamaSnack();
void playTamaGame();
void checkTamaStats();
void cleanTamaPoop();
void toggleLights();
void setTime(tm time);
bool setTimeViaNTP();

void resetBabysitterState();
void babysitterLoop();

#endif // BABYSITTER_H