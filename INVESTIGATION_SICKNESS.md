# Sickness Logic Investigation

**Objective:** Determine how "Sickness" is represented in memory, why Force mode's sick-clearing
oscillates (sick → cleared → sick → cleared), and what the correct set of addresses to write is.

---

## Phase 1 — Manual Medicine Dataset

Five snapshots taken while manually administering medicine to a sick adult:

| Snap | Label | 0x048 | 0x049 | 0x06D | 0x0F3 | poop |
|------|-------|-------|-------|-------|-------|------|
| snap_3269993921 | Sick + poop    | 0xF | 1 | 1 | 12 | 1 |
| snap_3270031281 | Sick, no poop  | 0xF | 1 | 1 | 15 | 0 |
| snap_3270084000 | Med ×2         | 0x9 | 1 | 1 |  4 | 0 |
| snap_3270112375 | Med ×3         | 0xC | 1 | 1 |  1 | 0 |
| snap_3270139796 | Med ×4 (cured) | 0x5 | 0 | 0 |  0 | 0 |

### Conclusions from dataset

**0x049** — Binary "sick" flag. 1 = sick, 0 = healthy. This is what `MEM_LOC_SICK` already tracks.
Force mode writes 0 here correctly.

**0x06D** (lower nibble of byte 0x036) — A second binary sick flag with *identical* behaviour to
0x049: consistently 1 in every sick snapshot, 0 only when fully cured. Force mode was not writing
this address at all, making it the prime suspect for the oscillation root cause. See Phase 2.

**0x048** (`MEM_LOC_SICK_SECONDARY`) — An illness-level counter. Starts at 0xF (max) when sick,
decreases with each medicine dose, and is below some threshold (~8?) when cured (value was 5 at
cure). It is *not* monotonically decreasing between doses — the ROM appears to increment it back
up between medicine administrations. Force mode was writing this correctly (comment was wrongly
removed; it should stay cleared).

**0x0F3** (`MEM_LOC_SICK_SEVERITY`) — A death timer. Counts *up* naturally (12 → 15 between
snap 1 and snap 2), then medicine resets it sharply downward (15 → 4 → 1 → 0). When it reaches
0 the tama is cured. Force mode already clears this correctly.

**byte 0x036 in known states:**
- Sick:  `0x01`  (0x06C = 0, 0x06D = 1)
- Cured: `0xC0`  (0x06C = C, 0x06D = 0)
- New baby (post-death / fresh start): `0x00` (both 0)

---

## Phase 2 — Force Mode Oscillation Analysis

Examining recent captures taken while Force Max was running (pre-fix build):

| Snap | 0x049 | 0x06D | 0x048 | 0x0F3 | Note |
|------|-------|-------|-------|-------|------|
| snap_3269829328 | 0 | **1** | 0 | 1 | Force cleared 0x049, but 0x06D still 1 |
| snap_3269840906 | 0 | **1** | 0 | 6 | 0x0F3 counting up |
| snap_3269926500 | 0 | **1** | 0 | 9 | 0x0F3 still rising |
| snap_3269993921 | 1 | **1** | F | 12 | SICK AGAIN — ROM re-asserted |

**Root cause confirmed:** Force mode cleared `0x049` (and `0x0F3`) each cycle, but left `0x06D = 1`.
The ROM reads `0x06D`, sees the tama is still sick, and re-asserts `0x049 = 1` and resets
`0x048 = 0xF` on its next tick. The sick icon clears briefly (one babysitter cycle) then
immediately returns.

---

## Phase 3 — Fix Attempts and Results

### Attempt 1 — Clear `0x06D`
Added `setMemory(0x06D, 0)` to the Force mode block alongside the existing `0x049` and `0x0F3`
clears. Also re-enabled the `0x048` clear (was incorrectly commented out).

Result: Could not get a clean test. The tama died from accumulated sickness (0x0F3 was not
staying at 0 between checks), the ROM transitioned directly from lifecycle=9 (Adult) to
lifecycle=1 (Baby) without passing through lifecycle=0 (Egg), and the sim froze on that
death-to-rebirth transition. This is a **pre-existing bug unrelated to sickness** — see
"Side Findings" below.

### Attempt 2 — Also write `0x06C = 0xC`
Added `setMemory(0x06C, 0xC)` to set the full byte 0x036 to `0xC0`, matching the properly-cured
state observed in Phase 1.

**This was a mistake.** `0x06C` is not a stable data register — the normal-baby snapshot showed
`0x06C = 0xE`, the cured snapshot showed `0x06C = 0xC`. It varies. Writing a fixed value here
corrupted the ROM (likely overwrote a call-stack entry or critical runtime variable in the
`0x060–0x07F` region). Immediate symptoms:
- 5 phantom poop icons on screen (screen corruption)
- Sim freeze

The `0x06C` write was reverted. **Never write to `0x06C` (or any address in `0x060–0x07F`)
without fully understanding its role.**

### Net state after Phase 3
All changes reverted by the user. Force mode sick-clearing is back to the original (broken)
state. The sickness oscillation bug remains open.

---

## Recommended Fix (not yet confirmed working)

The fix that was never cleanly tested:

```cpp
setMemory(MEM_LOC_SICK, 0);          // 0x049: visible sick flag
setMemory(MEM_LOC_SICK_SECONDARY, 0);// 0x048: illness level counter
setMemory(0x06D, 0);                 // 0x06D: authoritative sick flag (root of oscillation)
setMemory(MEM_LOC_SICK_SEVERITY, 0); // 0x0F3: death timer
// DO NOT write 0x06C — it is not a stable data register
```

This was believed to be correct based on analysis but could not be confirmed because the
death-rebirth freeze terminated every test run before the effect could be observed. **To test
properly, fix the death-rebirth freeze first** (see Side Findings), then run Force Max on a
fresh baby and observe whether the sick icon oscillates.

---

## Side Findings

### lifecycle = 9 is Adult, not 8
The `memory_config.py` stage_logic mapping lists Adult as `8`. Every Adult capture in this
dataset shows `0x05D = 9`. The full observed evolution path is:
```
0 (Egg) → 1 (Baby) → 2 (Child) → 4 (Teen) → 9 (Adult)
```
The `memory_config.py` mapping and `babysitter.h` `isTamaEgg()` check are unaffected (they
only test for 0), but any code that checks for Adult explicitly will be wrong. **Update
stage_logic mapping: Adult = 9, not 8.**

### Death-to-rebirth freeze (pre-existing, unrelated to sickness)
When the tama dies as an Adult (lifecycle=9), the ROM jumps directly to lifecycle=1 (Baby)
without passing through lifecycle=0 (Egg). This means `isTamaEgg()` never returns true and
the babysitter's egg-detection / `eggInitiated` guard never fires — yet the new baby is
alive and active. The sim appears to freeze at this transition, likely because the babysitter
(in its previous non-Force state or during the lifecycle change) enters some unexpected
condition. This is the `eggInitiated` reset bug described in `TODO.md` and needs its own fix
before Force mode sickness testing can proceed reliably.

### `0x060–0x07F` is dangerous territory
Writing to addresses in the `0x060–0x07F` nibble range caused immediate ROM corruption (screen
garbage, infinite loop / freeze). This range likely contains the CPU call stack or critical
runtime state. Treat as read-only from babysitter code until the ROM's memory layout is better
understood.
