#pragma once
#include "cpu.h"

/* File-based save/load replacing EEPROM savestate for the PC build.
 * Binary layout:
 *   Byte 0:              magic byte (0x12)
 *   Bytes 1..sizeof(cpu_state_t): raw cpu_state_t (pointer field must be fixed up)
 *   Remaining:           MEMORY_SIZE nibble bytes
 * File: tama_save.bin in the working directory.
 */

void pc_save_state(cpu_state_t *state);
bool pc_load_state(cpu_state_t *state);
