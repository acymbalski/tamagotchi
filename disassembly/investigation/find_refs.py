
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

def find_refs_to(path, target_pc):
    with open(path, 'r') as f:
        content = f.read()
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    max_pc = len(rom) * 2 // 3
    
    target_offset = target_pc & 0xFF
    
    for pc in range(max_pc):
        op = get_opcode(rom, pc)
        if (op & 0xFF) == target_offset:
            # 0x0ss = JP
            # 0x4ss = CALL
            # 0x2ss = JP_C
            # 0x3ss = JP_NC
            # 0x6ss = JP_Z
            # 0x7ss = JP_NZ
            # 0x5ss = CALZ
            prefix = (op & 0xF00) >> 8
            if prefix in [0, 2, 3, 4, 5, 6, 7]:
                types = {0:"JP", 2:"JP_C", 3:"JP_NC", 4:"CALL", 5:"CALZ", 6:"JP_Z", 7:"JP_NZ"}
                print(f"0x{pc:03X}: {types[prefix]} 0x{target_offset:02X} (opcode 0x{op:03X})")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        target = int(sys.argv[1], 16)
    else:
        target = 0xFD1
    find_refs_to("src/rom_12bit.h", target)
