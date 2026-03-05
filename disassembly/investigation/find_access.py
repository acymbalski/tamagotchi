
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

def find_access(path, target_addr):
    with open(path, 'r') as f:
        content = f.read()
    
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    
    # target_addr is e.g. 0x040
    target_page = target_addr >> 8
    target_offset = target_addr & 0xFF
    
    results = []
    max_pc = len(rom) * 2 // 3
    
    current_page_x = -1
    current_page_y = -1
    
    for pc in range(max_pc):
        op = get_opcode(rom, pc)
        
        # Track LD_XP_R (0xE80) and similar to guess current page
        # But this is hard without full simulation.
        # Let's just look for LD_X target_offset
        if (op & 0xF00) == 0xB00 and (op & 0xFF) == target_offset:
            # Check context
            results.append((pc, "LD_X 0x%02X" % target_offset))
        if (op & 0xF00) == 0x800 and (op & 0xFF) == target_offset:
            results.append((pc, "LD_Y 0x%02X" % target_offset))
            
    return results, rom

if __name__ == "__main__":
    target = 0x040
    hits, rom = find_access("src/rom_12bit.h", target)
    
    print(f"Potential accesses to offset 0x{target & 0xFF:02X}:")
    for pc, desc in hits:
        print(f"0x{pc:03X}: {desc}")
        # Print next 5 instructions
        for i in range(1, 6):
            if pc + i < len(rom) * 2 // 3:
                next_op = get_opcode(rom, pc + i)
                print(f"  0x{pc+i:03X}: 0x{next_op:03X}")
