
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

def find_mistake_logic(path):
    with open(path, 'r') as f:
        content = f.read()
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    max_pc = len(rom) * 2 // 3
    
    hits = []
    for pc in range(max_pc):
        op = get_opcode(rom, pc)
        # LD_X 0x40 (Hunger)
        if op == 0xB40:
            # Look forward for a check against 0
            for i in range(1, 20):
                if pc + i >= max_pc: break
                next_op = get_opcode(rom, pc+i)
                # CP A, #0 (0xDC0) or similar
                # LD_A_MN 0x40 is 0xFA4
                pass
                
        # LD_X 0x2D (Attention)
        if op == 0xB2D:
             # Look for clearing it (SET_M 0 or LD [X], #0)
             pass
             
    # Let's just search for LD_X 0x2D and see what it does
    print("LD_X 0x2D (Attention) hits:")
    for pc in range(max_pc):
        if get_opcode(rom, pc) == 0xB2D:
            print(f"0x{pc:03X}:")
            for i in range(1, 11):
                if pc+i < max_pc:
                    nop = get_opcode(rom, pc+i)
                    print(f"  0x{pc+i:03X}: 0x{nop:03X}")
                    
if __name__ == "__main__":
    find_mistake_logic("src/rom_12bit.h")
