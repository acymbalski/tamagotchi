# Tamagotchi Memory Map - Source of Truth

MAP = {
    "hunger":       {"addr": 0x040, "type": "level"},       # 0-F scaled to 0-4
    "happy":        {"addr": 0x041, "type": "level"},       # 0-F scaled to 0-4
    "discipline":   {"addr": 0x043, "type": "nibble"},      # Raw nibble
    "attention":    {"addr": 0x02D, "type": "bool"},        # Non-zero = needs attention
    "poop":         {"addr": 0x04D, "type": "nibble"},      # Count of poops
    "sick":         {"addr": 0x048, "type": "bool_8"},      # >= 8 is sick
    "sleeping":     {"addr": 0x04A, "type": "sleep_logic"}, # 8-F is sleeping
    "age":          {"addr": 0x054, "type": "nibble"},      # Age in years
    "weight":       {"addr": 0x046, "type": "bcd"},         # Weight in oz
    "stage":        {"addr": 0x05D, "type": "egg_logic"},   # Egg/Life stage tracking

    # --- Not yet discovered (addr=None until confirmed via analyzer.py) ---
    # Find via: python analyzer.py --field life_stage  (captures spanning egg→adult)
    "life_stage":    {"addr": None, "type": "nibble"},  # 0=egg_new,1=egg_init,2=baby,3=child,4=teen,5=adult,6=senior,7=dead
    # Find via: python analyzer.py --field char_id  (divergent care runs, e.g. Mametchi vs Tarakotchi)
    "char_id":       {"addr": None, "type": "nibble"},  # character within stage (0-indexed per stage)
    # Find via: delta analysis before/after a neglect event (hunger decay to 0)
    "care_mistakes": {"addr": None, "type": "nibble"},  # neglect counter
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
    if addr is None: return None  # address not yet discovered
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
