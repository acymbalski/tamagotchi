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
            for i in range(1, 21):
                if pc + i >= max_pc: break
                next_op = get_opcode(rom, pc+i)
                if next_op == 0xFDF:
                    trace.append((pc+i, "RET"))
                    break
                trace.append((pc+i, next_op))
            results.append((pc, reg, trace))
    return results

if __name__ == "__main__":
    target = 0x40
    results = analyze_logic("src/rom_12bit.h", target)
    
    print(f"Tracing logic for offset 0x{target:02X}:")
    for pc, reg, trace in results:
        header = f"--- Found LD_{reg} 0x{target:02X} at 0x{pc:03X} ---"
        print("\n" + header)
        for t_pc, op in trace:
            if isinstance(op, str):
                print(f"  0x{t_pc:03X}: {op}")
            else:
                desc = "0x%03X" % op
                if (op & 0xFF0) == 0xEC0:
                    arg0 = (op & 0xC) >> 2
                    arg1 = op & 0x3
                    regs = ["A", "B", "[X]", "[Y]"]
                    desc += f" (LD {regs[arg0]}, {regs[arg1]})"
                elif (op & 0xFF0) == 0xA80:
                    arg0 = (op & 0xC) >> 2
                    arg1 = op & 0x3
                    regs = ["A", "B", "[X]", "[Y]"]
                    desc += f" (ADD {regs[arg0]}, {regs[arg1]})"
                elif (op & 0xFF0) == 0xAA0:
                    arg0 = (op & 0xC) >> 2
                    arg1 = op & 0x3
                    regs = ["A", "B", "[X]", "[Y]"]
                    desc += f" (SUB {regs[arg0]}, {regs[arg1]})"
                elif (op & 0xFC0) == 0xE00:
                    arg0 = (op & 0x30) >> 4
                    val = op & 0x0F
                    regs = ["A", "B", "[X]", "[Y]"]
                    desc += f" (LD {regs[arg0]}, #{val})"
                elif (op & 0xF00) == 0x400:
                    desc += f" (CALL 0x{op&0xFF:02X})"
                elif (op & 0xFC0) == 0xC00:
                    # ADD R, I
                    arg0 = (op & 0x30) >> 4
                    val = op & 0x0F
                    regs = ["A", "B", "[X]", "[Y]"]
                    desc += f" (ADD {regs[arg0]}, #{val})"
                elif (op & 0xFC0) == 0xD40:
                    # SBC R, I (used for SUB R, I)
                    arg0 = (op & 0x30) >> 4
                    val = op & 0x0F
                    regs = ["A", "B", "[X]", "[Y]"]
                    desc += f" (SUB {regs[arg0]}, #{val})"
                
                print(f"  0x{t_pc:03X}: {desc}")
