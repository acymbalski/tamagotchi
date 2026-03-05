
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

def find_calls_to(path, target_pc):
    with open(path, 'r') as f:
        content = f.read()
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    max_pc = len(rom) * 2 // 3
    
    results = []
    target_offset = target_pc & 0xFF
    
    for pc in range(max_pc):
        op = get_opcode(rom, pc)
        if (op & 0xF00) == 0x400 and (op & 0xFF) == target_offset:
            results.append((pc, op))
            
    return results

if __name__ == "__main__":
    if len(sys.argv) > 1:
        target = int(sys.argv[1], 16)
    else:
        target = 0xFD1
    hits = find_calls_to("src/rom_12bit.h", target)
    print(f"Calls to offset 0x{target&0xFF:02X}:")
    for pc, op in hits:
        print(f"0x{pc:03X}: 0x{op:03X}")
