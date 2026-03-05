import re
import os

def extract_isa(cpu_c_path):
    with open(cpu_c_path, 'r') as f:
        content = f.read()
    
    # Find the ops0 array
    match = re.search(r'static const op_t0 ops0\[\] PROGMEM = \{(.*?)\};', content, re.DOTALL)
    if not match:
        return []
    
    ops_block = match.group(1)
    # Extract entries: {0xXXX, MASK_XXX, cycles}, // MNEMONIC
    # Handles both MASK_XXX and raw hex masks
    pattern = r'\{0x([0-9A-F]+),\s+([0-9A-Z_]+)\s+,\s+\d+\s+\},\s+//\s+(\w+)'
    ops = re.findall(pattern, ops_block)
    
    # Map masks to values
    masks = {
        "MASK_4B":  0xF00,
        "MASK_6B":  0xFC0,
        "MASK_7B":  0xFE0,
        "MASK_8B":  0xFF0,
        "MASK_10B": 0xFFC,
        "MASK_12B": 0xFFF,
        "0xFCF":    0xFCF
    }
    
    isa = []
    for base_hex, mask_str, name in ops:
        base = int(base_hex, 16)
        mask = masks.get(mask_str, int(mask_str, 16) if mask_str.startswith("0x") else 0)
        isa.append((base, mask, name))
        
    return isa

if __name__ == "__main__":
    isa = extract_isa("src/cpu.c")
    for base, mask, name in isa:
        print(f"    (0x{base:03X}, 0x{mask:03X}, \"{name}\"),")
