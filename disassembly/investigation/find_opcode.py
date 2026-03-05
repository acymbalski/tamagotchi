
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

def find_exact_op(path, op_val):
    with open(path, 'r') as f:
        content = f.read()
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    max_pc = len(rom) * 2 // 3
    
    hits = []
    for pc in range(max_pc):
        if get_opcode(rom, pc) == op_val:
            hits.append(pc)
    return hits

if __name__ == "__main__":
    if len(sys.argv) > 1:
        target = int(sys.argv[1], 16)
    else:
        target = 0xE4F
    hits = find_exact_op("src/rom_12bit.h", target)
    print(f"Opcode 0x{target:03X} found at: {['0x%03X' % p for p in hits]}")
