
import sys
import os
import re

# Add parent dir to path so we can import memory_config
sys.path.append(os.path.join(os.path.dirname(__file__), "..", ".."))

def load_rom(path):
    with open(path, 'r') as f:
        content = f.read()
    bytes_str = re.findall(r'0x[0-9A-Fa-f]{2}', content)
    return [int(b, 16) for b in bytes_str]

def get_opcode(rom, pc):
    i = pc >> 1
    if (pc & 1) == 0:
        if i*3+1 >= len(rom): return 0
        return (rom[i*3] << 4) | ((rom[i*3+1] >> 4) & 0xF)
    else:
        if i*3+2 >= len(rom): return 0
        return ((rom[i*3+1] & 0xF) << 8) | rom[i*3+2]

def find_refs_to_addr(rom, target_addr):
    refs = []
    max_pc = len(rom) * 2 // 3
    for pc in range(max_pc):
        op = get_opcode(rom, pc)
        # LD_X target_addr
        if (op & 0xF00) == 0xB00 and (op & 0xFF) == target_addr:
            refs.append((pc, "LD_X"))
        # LD_Y target_addr
        if (op & 0xF00) == 0x800 and (op & 0xFF) == target_addr:
            refs.append((pc, "LD_Y"))
        # LD_A_MN target_addr
        if (op & 0xFF0) == 0xFA0 and (op & 0x0F) == (target_addr & 0x0F):
            # This is only a partial match (lower 4 bits of address)
            pass
    return refs

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))
    rom_path = os.path.join(base_dir, "src", "rom_12bit.h")
    rom = load_rom(rom_path)
    
    sleeping_addr = 0x04A
    refs = find_refs_to_addr(rom, sleeping_addr)
    
    print(f"References to SLEEPING (0x{sleeping_addr:02X}):")
    for pc, type in refs:
        print(f"0x{pc:03X}: {type}")
        # Print context
        for i in range(1, 10):
            if pc+i < len(rom)*2//3:
                op = get_opcode(rom, pc+i)
                print(f"  0x{pc+i:03X}: 0x{op:03X}")
