#pragma once
#include "cpu.h"

/* File-based save/load replacing EEPROM savestate for the PC build.
 * Binary layout:
 *   Byte 0:              magic byte (0x12)
 *   Bytes 1..sizeof(cpu_state_t): raw cpu_state_t (pointer field must be fixed up)
 *   Remaining:           MEMORY_SIZE nibble bytes
 */

void pc_save_state(cpu_state_t *state, void *extra = nullptr, size_t extra_size = 0);
bool pc_load_state(cpu_state_t *state, void *extra = nullptr, size_t extra_size = 0);
void pc_delete_save(void);

// New functions for specific investigation snapshots
void pc_save_state_to_file(cpu_state_t *state, const char *filename, void *extra = nullptr, size_t extra_size = 0);
bool pc_load_state_from_file(cpu_state_t *state, const char *filename, void *extra = nullptr, size_t extra_size = 0);
