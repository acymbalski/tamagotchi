import sys
import os
import re

# Add parent dir to path so we can import memory_config
sys.path.append(os.path.join(os.path.dirname(__file__), ".."))

# ---------------------------------------------------------------------------
# Metadata & Knowledge Base
# ---------------------------------------------------------------------------

ROUTINE_METADATA = {
    0x0100: {
        "name": "RESET_VECTOR",
        "trigger": "Power on / Reset",
        "logic": "Initialize registers and jump to main loop"
    },
    0x0FD1: {
        "name": "INC_BEHAVIOR_MISTAKE",
        "trigger": "Discipline call timed out or was ignored",
        "logic": "Increments [0x51] using saturated logic (max 15)"
    },
    0x0FDF: {
        "name": "INC_NEGLECT",
        "trigger": "Attention call (Hunger/Happy=0) timed out",
        "logic": "Increments [0x42] using saturated logic (max 15)"
    },
    0x0FE8: {
        "name": "SATURATED_INC_ROUTINE",
        "trigger": "Internal sub-call",
        "logic": "[X] = Min([X] + 1, 15). Prevents overflow wrap-around."
    },
    0x07A5: {
        "name": "EXTRACT_HEART_COUNT",
        "trigger": "Drawing status screen or checking neglect",
        "logic": "Converts raw level nibble (0-F) to heart count (0-4)"
    },
    0x03C3: {
        "name": "CHECK_HUNGER_NEGLECT",
        "trigger": "Main timer tick",
        "logic": "If Hunger hearts == 0, proceed to neglect timer check"
    },
    0x017B: {
        "name": "PROCESS_HUNGER_CHANGE",
        "trigger": "Feeding or Tick",
        "logic": "Modifies Hunger level [0x40] and updates internal counters"
    }
}

# ---------------------------------------------------------------------------
# Full ISA from Core CPU Manual / cpu.c
# ---------------------------------------------------------------------------

ISA = [
    (0xE40, 0xFE0, "PSET"),
    (0x000, 0xF00, "JP"),
    (0x200, 0xF00, "JP_C"),
    (0x300, 0xF00, "JP_NC"),
    (0x600, 0xF00, "JP_Z"),
    (0x700, 0xF00, "JP_NZ"),
    (0xFE8, 0xFFF, "JPBA"),
    (0x400, 0xF00, "CALL"),
    (0x500, 0xF00, "CALZ"),
    (0xFDF, 0xFFF, "RET"),
    (0xFDE, 0xFFF, "RETS"),
    (0x100, 0xF00, "RETD"),
    (0xFFB, 0xFFF, "NOP5"),
    (0xFFF, 0xFFF, "NOP7"),
    (0xFF8, 0xFFF, "HALT"),
    (0xEE0, 0xFFF, "INC_X"),
    (0xEF0, 0xFFF, "INC_Y"),
    (0xB00, 0xF00, "LD_X"),
    (0x800, 0xF00, "LD_Y"),
    (0xE80, 0xFFC, "LD_XP_R"),
    (0xE84, 0xFFC, "LD_XH_R"),
    (0xE88, 0xFFC, "LD_XL_R"),
    (0xE90, 0xFFC, "LD_YP_R"),
    (0xE94, 0xFFC, "LD_YH_R"),
    (0xE98, 0xFFC, "LD_YL_R"),
    (0xEA0, 0xFFC, "LD_R_XP"),
    (0xEA4, 0xFFC, "LD_R_XH"),
    (0xEA8, 0xFFC, "LD_R_XL"),
    (0xEB0, 0xFFC, "LD_R_YP"),
    (0xEB4, 0xFFC, "LD_R_YH"),
    (0xEB8, 0xFFC, "LD_R_YL"),
    (0xA00, 0xFF0, "ADC_XH"),
    (0xA10, 0xFF0, "ADC_XL"),
    (0xA20, 0xFF0, "ADC_YH"),
    (0xA30, 0xFF0, "ADC_YL"),
    (0xA40, 0xFF0, "CP_XH"),
    (0xA50, 0xFF0, "CP_XL"),
    (0xA60, 0xFF0, "CP_YH"),
    (0xA70, 0xFF0, "CP_YL"),
    (0xFA0, 0xFF0, "LD_A_MN"),
    (0xFB0, 0xFF0, "LD_B_MN"),
    (0xF80, 0xFF0, "LD_MN_A"),
    (0xF90, 0xFF0, "LD_MN_B"),
    (0xE60, 0xFF0, "LDPX_MX"),
    (0xE70, 0xFF0, "LDPY_MY"),
    (0x900, 0xF00, "LBPX"),
    (0xF40, 0xFF0, "SET"),
    (0xF50, 0xFF0, "RST"),
    (0xF41, 0xFFF, "SCF"),
    (0xF5E, 0xFFF, "RCF"),
    (0xF42, 0xFFF, "SZF"),
    (0xF5D, 0xFFF, "RZF"),
    (0xF44, 0xFFF, "SDF"),
    (0xF5B, 0xFFF, "RDF"),
    (0xF48, 0xFFF, "EI"),
    (0xF57, 0xFFF, "DI"),
    (0xFDB, 0xFFF, "INC_SP"),
    (0xFCB, 0xFFF, "DEC_SP"),
    (0xFC0, 0xFFC, "PUSH_R"),
    (0xFC4, 0xFFF, "PUSH_XP"),
    (0xFC5, 0xFFF, "PUSH_XH"),
    (0xFC6, 0xFFF, "PUSH_XL"),
    (0xFC7, 0xFFF, "PUSH_YP"),
    (0xFC8, 0xFFF, "PUSH_YH"),
    (0xFC9, 0xFFF, "PUSH_YL"),
    (0xFCA, 0xFFF, "PUSH_F"),
    (0xFD0, 0xFFC, "POP_R"),
    (0xFD4, 0xFFF, "POP_XP"),
    (0xFD5, 0xFFF, "POP_XH"),
    (0xFD6, 0xFFF, "POP_XL"),
    (0xFD7, 0xFFF, "POP_YP"),
    (0xFD8, 0xFFF, "POP_YH"),
    (0xFD9, 0xFFF, "POP_YL"),
    (0xFDA, 0xFFF, "POP_F"),
    (0xFE0, 0xFFC, "LD_SPH_R"),
    (0xFF0, 0xFFC, "LD_SPL_R"),
    (0xFE4, 0xFFC, "LD_R_SPH"),
    (0xFF4, 0xFFC, "LD_R_SPL"),
    (0xC00, 0xFC0, "ADD_R_I"),
    (0xC40, 0xFC0, "ADC_R_I"),
    (0xD40, 0xFC0, "SBC_R_I"),
    (0xC80, 0xFC0, "AND_R_I"),
    (0xCC0, 0xFC0, "OR_R_I"),
    (0xD00, 0xFC0, "XOR_R_I"),
    (0xDC0, 0xFC0, "CP_R_I"),
    (0xD80, 0xFC0, "FAN_R_I"),
    (0xE00, 0xFC0, "LD_R_I"),
    (0xA80, 0xFF0, "ADD_R_Q"),
    (0xA90, 0xFF0, "ADC_R_Q"),
    (0xAA0, 0xFF0, "SUB"),
    (0xAB0, 0xFF0, "SBC_R_Q"),
    (0xAC0, 0xFF0, "AND_R_Q"),
    (0xAD0, 0xFF0, "OR_R_Q"),
    (0xAE0, 0xFF0, "XOR_R_Q"),
    (0xEC0, 0xFF0, "LD_R_Q"),
    (0xEE0, 0xFF0, "LDPX_R"),
    (0xEF0, 0xFF0, "LDPY_R"),
    (0xF00, 0xFF0, "CP_R_Q"),
    (0xF10, 0xFF0, "FAN_R_Q"),
    (0xAF0, 0xFF0, "RLC"),
    (0xE8C, 0xFFC, "RRC"),
    (0xF60, 0xFF0, "INC_MN"),
    (0xF70, 0xFF0, "DEC_MN"),
    (0xF28, 0xFFC, "ACPX"),
    (0xF2C, 0xFFC, "ACPY"),
    (0xF38, 0xFFC, "SCPX"),
    (0xF3C, 0xFFC, "SCPY"),
    (0xD0F, 0xFCF, "NOT"),
]

# ---------------------------------------------------------------------------
# Core Logic
# ---------------------------------------------------------------------------

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

def decode_instruction(pc, op, np):
    for base, mask, name in ISA:
        if (op & mask) == base:
            arg = op & (~mask & 0xFFF)
            
            # Formatting Arguments
            target = (np << 8) | (arg & 0xFF)
            regs = ["A", "B", "[X]", "[Y]"]
            r0 = (op & 0x0C) >> 2
            r1 = (op & 0x03)
            imm_val = op & 0x0F
            imm_reg = (op & 0x30) >> 4

            instr_str = name
            comment = ""
            
            if name in ["JP", "CALL", "CALZ", "JP_C", "JP_NC", "JP_Z", "JP_NZ"]:
                instr_str = f"{name:8} 0x{target:03X}"
                comment = f"Flow to 0x{target:03X}"
                if target in ROUTINE_METADATA:
                    comment += f" ({ROUTINE_METADATA[target]['name']})"
            elif name == "PSET":
                instr_str = f"{name:8} #{arg:X}"
                comment = f"Set next Page to {arg}"
            elif name in ["LD_X", "LD_Y"]:
                instr_str = f"{name:8} 0x{arg:02X}"
                comment = f"Set pointer to RAM 0x{arg:02X}"
            elif name in ["LD_A_MN", "LD_B_MN", "LD_MN_A", "LD_MN_B"]:
                instr_str = f"{name:8} 0x{arg:02X}"
                comment = f"Direct RAM access at 0x{arg:02X}"
            elif name in ["LD_R_I", "ADD_R_I", "CP_R_I", "OR_R_I", "AND_R_I"]:
                instr_str = f"{name:8} {regs[imm_reg]}, #{imm_val}"
                comment = f"Register {regs[imm_reg]} op with immediate #{imm_val}"
            elif name in ["LD_R_Q", "ADD_R_Q", "ADC_R_Q", "SUB", "CP_R_Q", "AND_R_Q", "OR_R_Q", "XOR_R_Q", "FAN_R_Q"]:
                instr_str = f"{name:8} {regs[r0]}, {regs[r1]}"
                comment = f"Register {regs[r0]} op with {regs[r1]}"
            elif name in ["LDPX_MX", "LDPY_MY", "LBPX"]:
                instr_str = f"{name:8} #{arg:X}"
                comment = f"Store constant #{arg:X} into memory pointer"
            elif name == "RETD":
                instr_str = f"{name:8} 0x{arg:02X}"
                comment = f"Table lookup return from 0x{arg:02X}"

            return instr_str, comment
            
    return f"UNKNOWN", f"Unrecognized instruction: 0x{op:03X}"

def disassemble(rom):
    import memory_config
    ram_map = {cfg["addr"]: name for name, cfg in memory_config.MAP.items() if cfg.get("addr") is not None}
    
    lines = []
    lines.append("; " + "="*70)
    lines.append("; TAMAGOTCHI P1 MASTER DISASSEMBLY")
    lines.append("; " + "="*70 + "\n")

    np = 1
    for pc in range(len(rom) * 2 // 3):
        op = get_opcode(rom, pc)
        
        # Header for Known Routines
        if pc in ROUTINE_METADATA:
            meta = ROUTINE_METADATA[pc]
            lines.append(f"\n; {'='*57}")
            lines.append(f"; ROUTINE: {meta['name']}")
            lines.append(f"; Location: 0x{pc:03X} (Page {pc >> 8}, Step {pc & 0xFF:02X})")
            lines.append(f"; Trigger:  {meta['trigger']}")
            lines.append(f"; Logic:    {meta['logic']}")
            lines.append(f"; {'='*57}\n")

        instr_str, comment = decode_instruction(pc, op, np)
        
        # Track NP
        if (op & 0xFE0) == 0xE40: # PSET
            np = op & 0x1F
        
        # Symbol substitution
        addr_match = re.search(r'0x([0-9A-F]{2})', instr_str)
        if addr_match:
            addr = int(addr_match.group(1), 16)
            if addr in ram_map:
                comment += f" (MEM_{ram_map[addr].upper()})"

        line = f"0x{pc:03X}:  {op:03X}  {instr_str:20} ; {comment}"
        lines.append(line)
        
    return "\n".join(lines)

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.dirname(__file__))
    rom_path = os.path.join(base_dir, "src", "rom_12bit.h")
    rom_data = load_rom(rom_path)
    listing = disassemble(rom_data)
    
    output_path = os.path.join(os.path.dirname(__file__), "rom_disassembly.asm")
    with open(output_path, "w") as f:
        f.write(listing)
    print(f"Detailed disassembly saved to {output_path}")
