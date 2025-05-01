#ifndef BABYSITTER_H
#define BABYSITTER_H

#include "time.h"

typedef enum {
    PROACTIVE,
    REACTIVE,
    INACTIVE
} BabysitterMode;

bool isTamaUnstartedEgg();
bool isTamaEgg();
bool isTamaSleeping();

void feedTamaFood();
void feedTamaSnack();
void checkTamaStats();
void toggleLights();
void setTime(tm time);
bool setTimeViaNTP();

void babysitterLoop();

#endif // BABYSITTER_H