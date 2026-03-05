
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

# Instruction Logic Templates
INST_TEMPLATES = {
    "PSET": "Set NP (New Page) to {arg} for the next jump/call",
    "JP": "Jump to address 0x{target:03X}",
    "CALL": "Call subroutine at 0x{target:03X}",
    "CALZ": "Call subroutine at 0x{target:03X} if Zero flag is set",
    "JP_C": "Jump to 0x{target:03X} if Carry flag is set (overflow occurred)",
    "JP_NC": "Jump to 0x{target:03X} if Carry flag is clear (no overflow)",
    "JP_Z": "Jump to 0x{target:03X} if Zero flag is set (result was zero)",
    "JP_NZ": "Jump to 0x{target:03X} if Zero flag is clear (result was non-zero)",
    "RET": "Return to caller",
    "LD_X": "Set X pointer to RAM address 0x{arg:02X}",
    "LD_Y": "Set Y pointer to RAM address 0x{arg:02X}",
    "INC_X": "Increment the X pointer by 1",
    "INC_Y": "Increment the Y pointer by 1",
    "LD_R_I": "Load {r} with immediate value #{val}",
    "LD_R_Q": "Copy value from {r1} into {r0}",
    "ADD_R_I": "Add immediate #{val} to register {r}",
    "ADD_R_Q": "Add value of {r1} to register {r0}",
    "ADC_R_Q": "Add value of {r1} plus Carry to register {r0}",
    "SUB": "Subtract value of {r1} from register {r0}",
    "CP_R_I": "Compare register {r} with immediate value #{val}",
    "CP_R_Q": "Compare value of {r0} with register {r1}",
    "LDPX_MX": "Load constant #{arg} into [X] and increment X",
    "LDPY_MY": "Load constant #{arg} into [Y] and increment Y",
    "LBPX": "Load constant #{arg} into [X]",
    "LD_A_MN": "Load A from direct RAM address 0x{arg:02X}",
    "LD_B_MN": "Load B from direct RAM address 0x{arg:02X}",
    "LD_MN_A": "Store A into direct RAM address 0x{arg:02X}",
    "LD_MN_B": "Store B into direct RAM address 0x{arg:02X}",
    "PUSH_R": "Push registers A, B and Flags to the stack",
    "POP_R": "Pop registers A, B and Flags from the stack",
    "ADD_[X]_1": "Increment the nibble pointed to by X ([X] = [X] + 1)",
    "ADD_[X]_15": "Decrement the nibble pointed to by X ([X] = [X] - 1)",
    "SCF": "Set Carry Flag",
    "RCF": "Reset (clear) Carry Flag",
    "SZF": "Set Zero Flag",
    "RZF": "Reset (clear) Zero Flag",
    "SDF": "Set Decimal Flag",
    "RDF": "Reset (clear) Decimal Flag",
}

# ---------------------------------------------------------------------------
# ISA & Mnemonic Mapping
# ---------------------------------------------------------------------------

MASK_4B  = 0xF00
MASK_6B  = 0xFC0
MASK_7B  = 0xFE0
MASK_8B  = 0xFF0
MASK_10B = 0xFFC
MASK_12B = 0xFFF

ISA = [
    (0xE40, MASK_7B,  "PSET"),
    (0x000, MASK_4B,  "JP"),
    (0x200, MASK_4B,  "JP_C"),
    (0x300, MASK_4B,  "JP_NC"),
    (0x600, MASK_4B,  "JP_Z"),
    (0x700, MASK_4B,  "JP_NZ"),
    (0x400, MASK_4B,  "CALL"),
    (0x500, MASK_4B,  "CALZ"),
    (0xFDF, MASK_12B, "RET"),
    (0xEE0, MASK_12B, "INC_X"),
    (0xEF0, MASK_12B, "INC_Y"),
    (0xB00, MASK_4B,  "LD_X"),
    (0x800, MASK_4B,  "LD_Y"),
    (0xA80, MASK_8B,  "ADD_R_Q"),
    (0xA90, MASK_8B,  "ADC_R_Q"),
    (0xAA0, MASK_8B,  "SUB"),
    (0xEC0, MASK_8B,  "LD_R_Q"),
    (0xFA0, MASK_8B,  "LD_A_MN"),
    (0xFB0, MASK_8B,  "LD_B_MN"),
    (0xF80, MASK_8B,  "LD_MN_A"),
    (0xF90, MASK_8B,  "LD_MN_B"),
    (0xE60, MASK_8B,  "LDPX_MX"),
    (0xE70, MASK_8B,  "LDPY_MY"),
    (0x900, MASK_4B,  "LBPX"),
    (0xFC0, MASK_10B, "PUSH_R"),
    (0xFD0, MASK_10B, "POP_R"),
    (0xC00, MASK_6B,  "ADD_R_I"),
    (0xDC0, MASK_6B,  "CP_R_I"),
    (0xE00, MASK_6B,  "LD_R_I"),
    (0xF41, MASK_12B, "SCF"),
    (0xF5E, MASK_12B, "RCF"),
    (0xF42, MASK_12B, "SZF"),
    (0xF5D, MASK_12B, "RZF"),
    (0xF44, MASK_12B, "SDF"),
    (0xF5B, MASK_12B, "RDF"),
    (0xC21, MASK_12B, "ADD_[X]_1"),
    (0xC2F, MASK_12B, "ADD_[X]_15"),
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
            if name in ["JP", "CALL", "CALZ", "JP_C", "JP_NC", "JP_Z", "JP_NZ"]:
                instr_str = f"{name:8} 0x{target:03X}"
            elif name == "PSET":
                instr_str = f"{name:8} {arg}"
            elif name in ["LD_X", "LD_Y", "LD_A_MN", "LD_B_MN", "LD_MN_A", "LD_MN_B"]:
                instr_str = f"{name:8} 0x{arg:02X}"
            elif name in ["LD_R_I", "ADD_R_I", "CP_R_I"]:
                instr_str = f"{name:8} {regs[imm_reg]}, #{imm_val}"
            elif name in ["LD_R_Q", "ADD_R_Q", "ADC_R_Q", "SUB"]:
                instr_str = f"{name:8} {regs[r0]}, {regs[r1]}"
            elif name in ["LDPX_MX", "LDPY_MY", "LBPX"]:
                instr_str = f"{name:8} #{arg:X}"

            # Build Detailed Comment
            template = INST_TEMPLATES.get(name, "")
            comment = template.format(arg=arg, target=target, r=regs[imm_reg], val=imm_val, r0=regs[r0], r1=regs[r1])
            
            # Routine labeling in comments
            if "target" in locals() and target in ROUTINE_METADATA:
                comment += f" ({ROUTINE_METADATA[target]['name']})"
            
            return instr_str, comment
            
    return f"UNKNOWN", f"Unrecognized instruction: 0x{op:03X}"

def disassemble(rom):
    import memory_config
    ram_map = {cfg["addr"]: name for name, cfg in memory_config.MAP.items() if cfg.get("addr") is not None}
    
    lines = []
    lines.append("; " + "="*70)
    lines.append("; TAMAGOTCHI P1 MASTER DISASSEMBLY")
    lines.append("; Generated with Deep Annotation Engine")
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
        if (op & MASK_7B) == 0xE40:
            np = op & 0x1F
        
        # Symbol substitution for memory pointers (X/Y)
        if "LD_X" in instr_str or "LD_Y" in instr_str:
            try:
                addr = int(instr_str.split("0x")[1], 16)
                if addr in ram_map:
                    comment += f" (MEM_{ram_map[addr].upper()})"
            except: pass
            
        # Symbol substitution for direct RAM access (MN)
        if "_MN" in instr_str:
            try:
                addr = int(instr_str.split("0x")[1], 16)
                if addr in ram_map:
                    comment += f" (MEM_{ram_map[addr].upper()})"
            except: pass

        line = f"0x{pc:03X}:  {op:03X}  {instr_str:20} ; {comment}"
        lines.append(line)
        
    return "\n".join(lines)

if __name__ == "__main__":
    # Resolve path to rom file
    base_dir = os.path.dirname(os.path.dirname(__file__))
    rom_path = os.path.join(base_dir, "src", "rom_12bit.h")
    
    rom_data = load_rom(rom_path)
    listing = disassemble(rom_data)
    
    # Save output to disassembly folder
    output_path = os.path.join(os.path.dirname(__file__), "rom_disassembly.asm")
    with open(output_path, "w") as f:
        f.write(listing)
    print(f"Detailed disassembly saved to {output_path}")
