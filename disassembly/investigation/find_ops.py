
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

def find_op(path, op_val):
    with open(path, 'r') as f:
        content = f.read()
    
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    
    results = []
    max_pc = len(rom) * 2 // 3
    
    for pc in range(max_pc):
        op = get_opcode(rom, pc)
        if op == op_val:
            results.append(pc)
            
    return results, rom

if __name__ == "__main__":
    # 0xA82 = ADD A, [X]
    # 0xAA2 = SUB A, [X]
    # 0xEC2 = LD A, [X]
    # 0xEC8 = LD [X], A
    
    for op_name, op_val in [("ADD A, [X]", 0xA82), ("SUB A, [X]", 0xAA2), 
                            ("LD A, [X]", 0xEC2), ("LD [X], A", 0xEC8)]:
        hits, rom = find_op("src/rom_12bit.h", op_val)
        print(f"{op_name} (0x{op_val:03X}) found at:")
        for pc in hits:
            # Look back 5 instructions to see if X was set
            print(f"  0x{pc:03X}")
            for i in range(-5, 0):
                if pc + i >= 0:
                    prev_op = get_opcode(rom, pc + i)
                    print(f"    0x{pc+i:03X}: 0x{prev_op:03X}")
