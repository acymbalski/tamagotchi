#ifndef BABYSITTER_H
#define BABYSITTER_H


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

void babysitterLoop();

#endif // BABYSITTER_H