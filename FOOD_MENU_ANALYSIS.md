# Food Menu Reverse Engineering Analysis

## Overview
Deep analysis of the Tamagotchi P1 Food menu mechanics, derived from ROM disassembly (`disassembly/rom_disassembly.asm`) and tamstream captures (`captures/streams/stream_45313520`).

## Display Cursor Position
These bytes show which menu item is **currently highlighted** when the Food menu is open.

| Register | Nibble Address | Value | Meaning |
|----------|---|---|---|
| `byte[0x48]` | `0x90`, `0x91` | `0x72` | **Meal is highlighted** |
| `byte[0x48]` | `0x90`, `0x91` | `0xFF` | Meal is NOT highlighted |
| `byte[0x4C]` | `0x98`, `0x99` | `0x72` | **Snack is highlighted** |
| `byte[0x4C]` | `0x98`, `0x99` | `0xFF` | Snack is NOT highlighted |

**Critical caveat**: These bytes **persist even after the Food menu is closed**. If you exit the menu without selecting, the cursor position bytes remain from before you exited. So `byte[0x48] == 0x72` does NOT guarantee the Food menu is currently open—it may just be stale state. Detecting menu-open state requires additional signals (see open questions below).

When the Food menu has never been opened, these bytes may be `0x00` instead of `0xFF`.

## Last-Selected Register
This register remembers which food item was **last confirmed/selected**, and is written **only when you confirm a selection** (press A button). Navigation without confirmation does not change this register.

| Register | Nibble Address | Value | Meaning |
|----------|---|---|---|
| `byte[0x39]`, LOW nibble | `0x073` | `0` | **Meal was last selected** |
| `byte[0x39]`, LOW nibble | `0x073` | `1` | **Snack was last selected** |

**Important distinction**: This register (`0x073`) does NOT perfectly track the currently-highlighted item. It only updates on confirm. When you navigate the menu with arrows, the display cursor updates (via `byte[0x48]`/`byte[0x4C]`), but `0x073` does not change until you press confirm.

### Example sequence:
1. Food menu opens; last selection was Meal (`0x073 = 0`)
2. Arrow highlights Snack (`byte[0x4C] = 0x72`, `byte[0x48] = 0xFF`)
3. Press A to confirm → `0x073` updates to `1` (Snack)
4. Exit menu
5. Open menu again → arrow points to Snack (from `0x073 = 1`), display reflects Snack cursor

## ROM Execution Flow

### Menu initialization (ROM 0x710–0x719)
```
0x713:  LD_X 0x73              ; X = nibble 0x073 (last-selection register)
0x714:  LD_R_Q A, [X]          ; A = [0x073] (load last selection into cursor)
0x716:  LD_R_Q [0x78], A       ; backup cursor to 0x078
0x717:  LD_X 0x90              ; X = display memory base
0x719:  CALL 0xBE8             ; render food menu (arrow positions set from A)
```

### Button handler / navigation (ROM 0xE5A, relevant snippet 0xE68–0xE70)
When you press A to confirm, the button handler updates `0x073` with the confirmed selection.

### Confirmation dispatch (ROM 0x723–0x726)
```
0x723:  CALZ 0x5F2             ; (timing/delay check)
0x724:  LDPX_R                 ; A = [0x073] (re-read, NOW contains confirmed selection)
0x725:  CP_R_I A, #0           ; is A == 0 (Meal)?
0x726:  JP_NZ 0x539            ; if not 0 (i.e., Snack), jump to Snack path
```

If A == 0, execute Meal path (increment `MEM_HUNGER`). If A == 1, execute Snack path (increment `MEM_HAPPY`).

## Open Questions

1. **How to detect if the Food menu is currently open?**
   - Display cursor bytes (`0x48`, `0x4C`) persist after menu closes, so they alone are insufficient
   - Possible signals to investigate:
     - Write activity pattern to display registers (ROM 0xBE8 renderer produces periodic FF↔72 oscillations during menu)
     - State of other menu-related registers (stack pointer, return address, or other ROM state tracking)
   - Not yet solved

2. **Memory inspection to predict confirm action**
   - Read `byte[0x48]`: if `0x72`, Meal will be selected on confirm
   - Read `byte[0x4C]`: if `0x72`, Snack will be selected on confirm
   - These accurately reflect what will execute, assuming the Food menu is open (see caveat above)

## Nibble Packing Reminder

The Tamagotchi P1 uses 4-bit (nibble) addressing in ROM, but RAM is stored as packed 8-bit bytes. The conversion:
- **Even nibble address** `n` → HIGH nibble (bits 7–4) of `byte[n >> 1]`
- **Odd nibble address** `n` → LOW nibble (bits 3–0) of `byte[n >> 1]`

Example: nibble `0x073` is odd, so it lives in the LOW nibble of `byte[0x039]`.

```c
// Read last-selection from nibble 0x073
uint8_t last_selected = ram[0x039] & 0x0F;  // LOW nibble

// Write to nibble 0x073
ram[0x039] = (ram[0x039] & 0xF0) | (new_value & 0x0F);
```

## References
- ROM disassembly: `disassembly/rom_disassembly.asm` (sections 0x710–0x739, 0xBE8–0xBEF, 0xE68–0xE70)
- Stream analysis: `captures/streams/stream_45313520` with `stream_45313520.annotations.json`
- CPU nibble packing: `src/cpu.c:set_memory()` (lines 682–714)
