#ifndef BABYSITTER_H
#define BABYSITTER_H

#include "time.h"

#define MEM_LOC_SELECTION 0x75
#define MEM_LOC_HUNGER 0x40
#define MEM_LOC_HAPPY 0x41
#define MEM_LOC_AGE 0x54
#define MEM_LOC_DISCIPLINE 0x43
#define MEM_LOC_SICK 0x49
#define MEM_LOC_SICK_SECONDARY 0x48
#define MEM_LOC_LIGHTS 0x4B
#define MEM_LOC_POOP 0x4D
#define MEM_LOC_MENU 0x75
#define MEM_LOC_ATTENTION 0x02D
#define MEM_LOC_WEIGHT 0x046

// Addresses not yet discovered — 0x3FF is an out-of-bounds sentinel; reads/writes
// will hit the bounds check in memory.cpp and safely no-op. Replace once confirmed.
#define MEM_LOC_CHARACTER    0x3FF  // creature ID nibble — find via: analyzer.py --field stage (divergent runs)
#define MEM_LOC_CARE_MISTAKES 0x3FF // neglect counter   — find via: delta analysis before/after hunger→0

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
    INACTIVE,
    FORCE
} BabysitterMode;

typedef enum {
    FORCE_OFF = 0,
    FORCE_MIN,
    FORCE_LOW,
    FORCE_MED,
    FORCE_MAX
} ForceLevel;

#define INTENT PROACTIVE
#define RESPONSIVENESS 1 // how many seconds between each babysitter check

extern BabysitterMode currentIntent;
extern ForceLevel currentForceLevel;
extern bool ntpDisabled;

bool isTamaUnstartedEgg();
bool isTamaEgg();
bool isTamaSleeping();

void forceAgeUp();
void setCharacter(uint8_t id);

uint8_t getTamaHunger();
uint8_t getTamaHappiness();
uint8_t getTamaPoop();
uint8_t getTamaSickness();
uint8_t getTamaDiscipline();
bool isTamaSick();
bool isTamaRequestingAttention();

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