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

def analyze_logic(path, target_offset):
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
            trace = []
            for i in range(1, 15):
                if pc + i >= max_pc: break
                next_op = get_opcode(rom, pc+i)
                if next_op == 0xFDF: trace.append((pc+i, "RET")); break
                trace.append((pc+i, next_op))
            results.append((pc, reg, trace))
    return results

if __name__ == "__main__":
    target = 0x41 # Happy
    results = analyze_logic("src/rom_12bit.h", target)
    print(f"Tracing logic for HAPPY (0x41):")
    for pc, reg, trace in results:
        print(f"\n--- LD_{reg} 0x41 at 0x{pc:03X} ---")
        for t_pc, op in trace:
            if isinstance(op, str): print(f"  0x{t_pc:03X}: {op}")
            else: print(f"  0x{t_pc:03X}: 0x{op:03X}")
