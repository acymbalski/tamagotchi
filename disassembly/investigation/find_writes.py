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

def find_writes(path, target_addr):
    with open(path, 'r') as f:
        content = f.read()
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    max_pc = len(rom) * 2 // 3
    
    hits = []
    for pc in range(max_pc):
        op = get_opcode(rom, pc)
        # LD_X or LD_Y
        if (op & 0xF00) in [0xB00, 0x800] and (op & 0xFF) == target_addr:
            # Look forward for a write
            for i in range(1, 10):
                if pc + i >= max_pc: break
                next_op = get_opcode(rom, pc+i)
                if next_op == 0xEC8: # LD [X], A
                    hits.append((pc+i, "LD [X], A"))
                if next_op == 0xECA: # LD [X], B
                    hits.append((pc+i, "LD [X], B"))
                if next_op == 0xEC9: # LD [Y], A
                    hits.append((pc+i, "LD [Y], A"))
                if next_op == 0xECB: # LD [Y], B
                    hits.append((pc+i, "LD [Y], B"))
                if (next_op & 0xFF0) == 0xE60: # LDPX_MX
                    hits.append((pc+i, "LDPX_MX #%d" % (next_op & 0x0F)))
                if (next_op & 0xFF0) == 0xE70: # LDPY_MY
                    hits.append((pc+i, "LDPY_MY #%d" % (next_op & 0x0F)))
                    
    return hits

if __name__ == "__main__":
    target = 0x02D # Attention
    hits = find_writes("src/rom_12bit.h", target)
    print(f"Writes to 0x{target:02X}:")
    for pc, desc in hits:
        print(f"0x{pc:03X}: {desc}")
