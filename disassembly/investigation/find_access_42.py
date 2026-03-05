
import sys
import os
import re

def get_opcode(rom, pc):
    i = pc >> 1
    if (pc & 1) == 0:
        if i*3+1 >= len(rom): return 0
        return (rom[i*3] << 4) | ((rom[i*3+1] >> 4) & 0xF)
    else:
        if i*3+2 >= len(rom): return 0
        return ((rom[i*3+1] & 0xF) << 8) | rom[i*3+2]

def find_access(path, target_offset):
    with open(path, 'r') as f:
        content = f.read()
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    max_pc = len(rom) * 2 // 3
    results = []
    for pc in range(max_pc):
        op = get_opcode(rom, pc)
        if (op & 0xF00) in [0xB00, 0x800] and (op & 0xFF) == target_offset:
            reg = "X" if (op & 0xF00) == 0xB00 else "Y"
            results.append((pc, reg))
    return results, rom

if __name__ == "__main__":
    target = 0x42
    hits, rom = find_access("src/rom_12bit.h", target)
    print(f"Accesses to 0x{target:02X}:")
    for pc, reg in hits:
        print(f"0x{pc:03X}: LD_{reg} 0x{target:02X}")
        for i in range(1, 10):
            if pc+i < len(rom)*2//3:
                print(f"  0x{pc+i:03X}: 0x{get_opcode(rom, pc+i):03X}")
