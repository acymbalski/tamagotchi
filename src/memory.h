
#ifndef MEMORY_H
#define MEMORY_H
#include "cpu.h"

static cpu_state_t cpuState;

uint8_t readMemory(uint16_t address);
void setMemory(uint16_t address, uint8_t value);

#endif // MEMORY_H