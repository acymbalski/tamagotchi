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

def find_calls(path):
    with open(path, 'r') as f:
        content = f.read()
    
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    rom = [int(b, 16) for b in bytes_str]
    
    calls = []
    # Maximum PC based on ROM size
    max_pc = len(rom) * 2 // 3
    for pc in range(max_pc):
        op = get_opcode(rom, pc)
        if (op & 0xF00) == 0x400: # CALL
            target_step = op & 0xFF
            page = pc >> 8
            target = (page << 8) | target_step
            calls.append((pc, target))
            
    return calls

if __name__ == "__main__":
    calls = find_calls("src/rom_12bit.h")
    # Sort by target count
    from collections import Counter
    targets = Counter([c[1] for c in calls])
    
    print("Top call targets:")
    for target, count in targets.most_common(10):
        print(f"Target 0x{target:03X}: called {count} times")
    
    print("\nCalls around 0x771:")
    for pc, target in calls:
        if 0x760 <= pc <= 0x780:
            print(f"0x{pc:03X} calls 0x{target:03X} (return to 0x{pc+1:03X})")
