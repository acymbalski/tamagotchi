
import struct
import os

def inspect_save(path):
    with open(path, 'rb') as f:
        magic = f.read(1)
        # cpu_state_t is roughly 64 bytes on x64
        # We need to skip it to get to memory
        f.seek(1 + 64) 
        memory = f.read(320)
        
    def get_nibble(addr):
        byte_idx = addr >> 1
        val = memory[byte_idx]
        return (val & 0xF0) >> 4 if (addr & 1) == 0 else val & 0x0F

    # Time is at 0x10-0x15
    sec_ones = get_nibble(0x10)
    sec_tens = get_nibble(0x11)
    min_ones = get_nibble(0x12)
    min_tens = get_nibble(0x13)
    hour_ones = get_nibble(0x14)
    hour_tens = get_nibble(0x15)
    
    print(f"Save File: {path}")
    print(f"Time: {hour_tens}{hour_ones}:{min_tens}{min_ones}:{sec_tens}{sec_ones}")
    print(f"Hunger: {get_nibble(0x40)}")
    print(f"Happy: {get_nibble(0x41)}")
    print(f"Lifecycle: {get_nibble(0x05D)}")
    print(f"Character: {get_nibble(0x050)}")
    print(f"Sleeping: {get_nibble(0x04A)}")

if __name__ == "__main__":
    inspect_save("saves/hatched_baby.bin")
