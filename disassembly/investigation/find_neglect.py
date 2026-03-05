
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

def find_pattern(path, pattern_ops):
    with open(path, 'r') as f:
        content = f.read()
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    max_pc = len(rom) * 2 // 3
    hits = []
    for pc in range(max_pc - len(pattern_ops)):
        match = True
        for i, (op_val, mask) in enumerate(pattern_ops):
            if (get_opcode(rom, pc+i) & mask) != op_val:
                match = False
                break
        if match:
            hits.append(pc)
    return hits, rom

if __name__ == "__main__":
    # Pattern: LD A, [X] (0xEC2) then CP A, #0 (0xDC0)
    # Then possibly JP_NZ (0x700 range) or CALL (0x400 range)
    pattern = [
        (0xEC2, 0xFFF), # LD A, [X]
        (0xDC0, 0xFFF)  # CP A, #0
    ]
    hits, rom = find_pattern("src/rom_12bit.h", pattern)
    print("Found LD A, [X]; CP A, #0 at:")
    for pc in hits:
        print(f"0x{pc:03X}")
        # Show what happens after
        for i in range(2, 7):
            op = get_opcode(rom, pc+i)
            print(f"  0x{pc+i:03X}: 0x{op:03X}")
