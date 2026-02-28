#include "pc_savestate.h"
#include "cpu.h"
#include <stdio.h>
#include <string.h>

#define SAVE_MAGIC    0x12
#define SAVE_FILENAME "tama_save.bin"

void pc_save_state_to_file(cpu_state_t *state, const char *filename) {
    cpu_get_state(state);

    FILE *f = fopen(filename, "wb");
    if (!f) {
        fprintf(stderr, "[savestate] Failed to open %s for writing\n", filename);
        return;
    }

    uint8_t magic = SAVE_MAGIC;
    fwrite(&magic, 1, 1, f);

    /* Save the raw struct bytes. The memory pointer inside will be
     * corrupted on load — we fix it up after fread. */
    fwrite(state, sizeof(cpu_state_t), 1, f);

    /* Save the nibble array that memory points to */
    fwrite(state->memory, sizeof(u4_t), MEMORY_SIZE, f);

    fclose(f);
    printf("[savestate] State saved to %s\n", filename);
    fflush(stdout);
}

void pc_save_state(cpu_state_t *state) {
    pc_save_state_to_file(state, SAVE_FILENAME);
}

bool pc_load_state_from_file(cpu_state_t *state, const char *filename) {
    FILE *f = fopen(filename, "rb");
    if (!f) {
        printf("[savestate] No save file found (%s)\n", filename);
        fflush(stdout);
        return false;
    }

    uint8_t magic = 0;
    fread(&magic, 1, 1, f);
    if (magic != SAVE_MAGIC) {
        fprintf(stderr, "[savestate] Bad magic 0x%02X in %s, skipping\n", magic, filename);
        fclose(f);
        return false;
    }

    /* Populate state->memory from the CPU's internal state (tamalib_init must have run) */
    cpu_get_state(state);

    /* Save the valid memory pointer — the raw struct read would otherwise trash it */
    u4_t *mem_ptr = state->memory;

    fread(state, sizeof(cpu_state_t), 1, f);

    /* Restore the pointer — the raw bytes from file would have trashed it */
    state->memory = mem_ptr;

    fread(state->memory, sizeof(u4_t), MEMORY_SIZE, f);

    fclose(f);

    cpu_set_state(state);

    printf("[savestate] State loaded from %s\n", filename);
    fflush(stdout);
    return true;
}

bool pc_load_state(cpu_state_t *state) {
    return pc_load_state_from_file(state, SAVE_FILENAME);
}

void pc_delete_save(void) {
    if (remove(SAVE_FILENAME) == 0) {
        printf("[savestate] Save file deleted (%s)\n", SAVE_FILENAME);
    } else {
        printf("[savestate] No save file to delete (%s)\n", SAVE_FILENAME);
    }
    fflush(stdout);
}
