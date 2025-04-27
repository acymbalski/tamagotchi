
#ifndef MEMORY_H
#define MEMORY_H
#include "cpu.h"

#define MEM_LOC_SELECTION 0x75
#define MEM_LOC_HUNGER 0x40
#define MEM_LOC_HAPPY 0x41
#define MEM_LOC_DISCIPLINE 0x43
#define MEM_LOC_LIGHTS 0x4B
#define MEM_LOC_POOP 0x4D

#define MENU_NONE 0x0
#define MENU_FOOD 0x1
#define MENU_LIGHT 0x2
#define MENU_GAME 0x3
#define MENU_MEDICINE 0x4
#define MENU_CLEAN 0x5
#define MENU_STATS 0x6
#define MENU_DISCIPLINE 0x7

static cpu_state_t cpuState;

uint8_t readMemory(uint16_t address);
void setMemory(uint16_t address, uint8_t value);

#endif // MEMORY_H