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

def dump_rom(path, start, end):
    with open(path, 'r') as f:
        content = f.read()
    
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    
    print(f"ROM dump from 0x{start:03X} to 0x{end:03X}:")
    for pc in range(start, end + 1):
        op = get_opcode(rom, pc)
        print(f"0x{pc:03X}: 0x{op:03X}")

if __name__ == "__main__":
    if len(sys.argv) > 2:
        dump_rom("src/rom_12bit.h", int(sys.argv[1], 16), int(sys.argv[2], 16))
    else:
        dump_rom("src/rom_12bit.h", 0x050, 0x060)
