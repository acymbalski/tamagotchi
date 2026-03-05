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

def find_ops(path):
    with open(path, 'r') as f:
        content = f.read()
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    max_pc = len(rom) * 2 // 3
    
    inc_mn = []
    add_x_1 = []
    
    for pc in range(max_pc):
        op = get_opcode(rom, pc)
        if (op & 0xFF0) == 0xF60: # INC_MN
            addr = op & 0x0F
            inc_mn.append((pc, addr))
        if op == 0xC21: # ADD [X], 1
            add_x_1.append(pc)
            
    return inc_mn, add_x_1, rom

if __name__ == "__main__":
    inc_mn, add_x_1, rom = find_ops("src/rom_12bit.h")
    print("INC_MN (0xF6n) hits:")
    for pc, addr in inc_mn:
        print(f"0x{pc:03X}: INC 0x{addr:02X}")
        
    print("\nADD [X], 1 (0xC21) hits (with context):")
    for pc in add_x_1:
        # Trace back to find LD_X
        ld_x = "???"
        for i in range(-1, -10, -1):
            if pc + i < 0: break
            prev_op = get_opcode(rom, pc+i)
            if (prev_op & 0xF00) == 0xB00:
                ld_x = "0x%02X" % (prev_op & 0xFF)
                break
        print(f"0x{pc:03X}: ADD [X (which is {ld_x})], 1")
