
import struct
import os

def dump_all(path):
    with open(path, 'rb') as f:
        magic = f.read(1)
        f.seek(1 + 64) 
        memory = f.read(320)
        
    print(f"Memory Dump for {path}:")
    for addr in range(0, 256):
        byte_idx = addr >> 1
        val = (memory[byte_idx] >> 4) if (addr & 1) == 0 else (memory[byte_idx] & 0x0F)
        print(f"{val:X}", end="")
        if (addr + 1) % 16 == 0:
            print(f"  (0x{addr-15:02X}-0x{addr:02X})")

if __name__ == "__main__":
    dump_all("saves/hatched_baby.bin")
