# Tamagotchi Memory Map - Source of Truth

MAP = {
    "hunger":     {"addr": 0x040, "type": "level"},       # 0-F scaled to 0-4
    "happy":      {"addr": 0x041, "type": "level"},       # 0-F scaled to 0-4
    "discipline": {"addr": 0x043, "type": "nibble"},      # Raw nibble
    "attention":  {"addr": 0x02D, "type": "bool"},        # Non-zero = needs attention
    "poop":       {"addr": 0x04D, "type": "nibble"},      # Count of poops
    "sick":       {"addr": 0x048, "type": "bool_8"},      # >= 8 is sick
    "sleeping":   {"addr": 0x04A, "type": "sleep_logic"}, # 8-F is sleeping
    "age":        {"addr": 0x054, "type": "nibble"},      # Age in years
    "weight":     {"addr": 0x046, "type": "bcd"},         # Weight in oz
    "stage":      {"addr": 0x05D, "type": "egg_logic"},   # Egg/Life stage tracking
}

def decode_nibble(mem, addr):
    byte_idx = addr >> 1
    if byte_idx >= len(mem): return 0
    val = mem[byte_idx]
    return (val & 0xF0) >> 4 if (addr & 1) == 0 else val & 0x0F

def get_value(mem, key):
    config = MAP.get(key)
    if not config: return None
    
    addr = config["addr"]
    ctype = config["type"]
    
    if ctype == "nibble":
        return decode_nibble(mem, addr)
    elif ctype == "level":
        val = decode_nibble(mem, addr)
        return 4 if val == 0xF else val // 4
    elif ctype == "bool":
        return decode_nibble(mem, addr) != 0
    elif ctype == "bool_8":
        return decode_nibble(mem, addr) >= 8
    elif ctype == "sleep_logic":
        val = decode_nibble(mem, addr)
        return val >= 8 and val <= 15
    elif ctype == "bcd":
        # ones at addr, tens at addr+1
        ones = decode_nibble(mem, addr)
        tens = decode_nibble(mem, addr + 1)
        return tens * 10 + ones
    elif ctype == "egg_logic":
        return "Egg (New)" if decode_nibble(mem, addr) == 0 else "Unknown"
    
    return None
