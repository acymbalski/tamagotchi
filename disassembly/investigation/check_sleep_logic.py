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

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))
    # We can't import the disassembler easily due to path issues, let's just use it via shell
    print("Extracting annotated block 0x30C-0x340...")
    os.system(f"grep -A 100 \"0x30C:\" {os.path.join(base_dir, 'disassembly', 'rom_disassembly.asm')} | head -n 50")
