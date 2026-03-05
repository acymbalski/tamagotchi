# Tamagotchi Memory Map - Source of Truth

MAP = {
    "hunger":       {"addr": 0x040, "type": "level"},       # 0-F scaled to 0-4
    "happy":        {"addr": 0x041, "type": "level"},       # 0-F scaled to 0-4
    "discipline":   {"addr": 0x043, "type": "level"},       # 0-F scaled to 0-4
    "attention":    {"addr": 0x02D, "type": "bool"},        # Non-zero = needs attention
    "poop":         {"addr": 0x04D, "type": "nibble"},      # Count of poops
    "sick":         {"addr": 0x049, "type": "level"},       # 0-F scaled to 0-4; derived flag — ROM re-asserts from 0x06D
    "sick_flag2":   {"addr": 0x06D, "type": "bool"},        # Authoritative sick register — 1=sick, 0=healthy; lower nibble of byte 0x036
    "sick_level":   {"addr": 0x048, "type": "nibble"},      # Illness level counter — 0xF=max sick, decreases with medicine
    "sick_severity":{"addr": 0x0F3, "type": "nibble"},      # Death timer — counts up naturally, medicine resets it; 0=cured
    "sleeping":     {"addr": 0x04A, "type": "sleep_logic"}, # 8-F is sleeping
    "age":          {"addr": 0x054, "type": "bcd"},         # Age in years (BCD)
    "weight":       {"addr": 0x046, "type": "bcd"},         # Weight in oz
    "lifecycle":    {"addr": 0x05D, "type": "stage_logic"}, # Lifecycle stage (0, 1, 2, 4...)
    "character":    {"addr": 0x050, "type": "nibble"},      # Character within stage
    "behavior_mistake":{"addr": 0x051, "type": "nibble"},   # Behavior mistakes (discipline calls ignored)
    "neglect":      {"addr": 0x042, "type": "nibble"},      # Neglect counter (hunger/happy ignored)

    # --- Not yet discovered (addr=None until confirmed via analyzer.py) ---
    "life_stage":    {"addr": None, "type": "nibble"},  # 0=egg_new,1=egg_init,2=baby,3=child,4=teen,5=adult,6=senior,7=dead
    "char_id":       {"addr": None, "type": "nibble"},  # character within stage (0-indexed per stage)
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
    elif ctype == "stage_logic":
        val = decode_nibble(mem, addr)
        # Observed: 0=Egg, 1=Baby, 2=Child, 4=Teen, 9=Adult (NOT 8 — confirmed from captures)
        mapping = {0: "Egg", 1: "Baby", 2: "Child", 4: "Teen", 9: "Adult", 16: "Special"}
        return mapping.get(val, "Unknown")
    
    return None
