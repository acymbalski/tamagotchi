# Tamagotchi P1 Memory Reverse-Engineering Guide

This document provides instructions for using the Tamagotchi Investigation Lab (TIL) system to map the RAM of the P1 Tamagotchi ROM.

## 1. System Architecture

- **The Worker (`tamagotchi_pc.exe`)**: A C++ simulator (SDL2) modified to support high-speed execution, save-state loading, and periodic snapshotting of RAM and LCD.
- **The Lab (`investigator.py`)**: A PyQt6 GUI that manages the simulator, displays captures, and allows for manual annotation of truth values (Hunger, Weight, etc.).
- **The Source of Truth (`memory_config.py`)**: A centralized Python module containing known memory addresses and decoding logic.
- **The Brain (`analyzer.py`)**: A script that correlates manual annotations with raw binary memory dumps to identify or strengthen memory address candidates.

---

## 2. Standard Workflow

### Phase A: Data Collection
1.  Run `python investigator.py`.
2.  Click **"Start Turbo Sim (Collect)"**.
3.  In the simulator window:
    - Set the time manually (NTP is disabled during collection).
    - Press **'B'** to toggle the Babysitter ON/OFF as needed.
    - Press **'F'** to cycle speed to **TURBO**.
    - The sim will automatically save a `.bin` (RAM) and `.bmp` (LCD) every 5 emulated minutes to the `captures/` folder.
    - **Manual Snap**: Press **'K'** to take an immediate snapshot.

### Phase B: Annotation
1.  In the TIL GUI, navigate snapshots using **Previous/Next**.
2.  Review the **Pre-populated** fields (guesses based on current assumptions).
3.  **Confirm Truth**:
    - If a guess is correct, click the **"Confirm"** checkbox.
    - If a guess is wrong, type the correct value. The field will turn **Red** to indicate a discrepancy.
    - For missing info (Weight/Age), click **"Investigate Live"** to spawn a 1x speed simulator at that exact state, navigate the menus, then return to TIL.
4.  Click **"Save & Next"** to commit the entry to `annotations.json`.

### Phase C: Analysis
1.  Run `python analyzer.py`.
2.  **Review the Report**:
    - **STRENGTHENED**: Current assumptions are 100% accurate.
    - **DOUBTED**: User truth differs from memory guess (accuracy < 100%).
    - **DISCOVERY**: Lists new memory address candidates that perfectly match your annotations.
3.  **Update Assumptions**: If a new address is found with high confidence (e.g., exactly 1 candidate), update `memory_config.py`.

---

## 3. Data Schema

- **`captures/`**: Stores `snap_<timestamp>.bin` (raw `cpu_state_t` + 1280 RAM nibbles) and `snap_<timestamp>.bmp` (LCD + Status Icons).
- **`annotations.json`**:
    - `truth`: Values verified/modified by the user.
    - `guesses`: Compact keys representing what the logic *thought* the values were.
    - `mod`: List of fields where user truth overrode the guess.

---

## 4. Current Knowledge & Gaps

### Known Locations (Source: `memory_config.py`)
- **Weight**: `0x046` (BCD) - *Confirmed*
- **Age**: `0x054` (Nibble) - *High Confidence*
- **Attention**: `0x02D` (Bool) - *High Confidence*
- **Sleeping**: `0x04A` (8-F range) - *Confirmed*
- **Hunger/Happy**: `0x040`/`0x041` - *Doubted* (Scaling logic `val // 4` is likely incomplete).

### Major Gaps
1.  **Life Stages**: We have official names, but we do not know the memory address that stores the creature ID.
2.  **Screens**: We need to find the address that identifies which menu is currently open (Main, Stats, Game, etc.).
3.  **Hunger Scaling**: Address `0x040` is correct, but we need to determine the exact bit-thresholds for the 4 hearts.
4.  **Angel/Death**: Identify the "Dead" flag triggered when the Tama passes away.

---

## 5. Maintenance
After updating `memory_config.py`, click **"Rebuild Assumptions (All)"** in TIL to re-process existing captures with the new logic. Use `ninja` in `pc/build` to rebuild the C++ sim if you change any `MEM_LOC_` defines in `babysitter.h`.

---

## 6. Field-by-Field Analysis Strategy

This section documents the canonical methodology for identifying an unknown memory address for a specific field. The implementation lives in `analyzer.py` and is invoked with `python analyzer.py --field <attr>`.

### 6.1 Core Method — Value-Grouping with Cross-Validation

For a field `F` with observed truth values `{v0, v1, …}`:

#### Step A — Within-Group Stacking

- Collect all captures where `truth[F] == v`.
- For every nibble address, record the observed nibble across all captures in the group.
- An address is *group-consistent* for value `v` if every capture in that group shows the **same nibble value** at that address.
- `consistent[v] = { addr → nibble_value }`

#### Step B — Cross-Group Contrast

- Intersect consistent addresses across all value groups → candidate addresses seen in every group.
- At each candidate, the nibble values across groups should be **different** (otherwise it's a constant unrelated to the field). Discard candidates where all groups agree on the same nibble.
- For ordinal fields (hunger 0–4), check that the nibble values form a **monotonic sequence** across the ordered values — this is strong confirmatory evidence.
- **Multi-nibble fields (BCD, byte): use address-pair units.** For fields like Weight encoded as a two-nibble BCD pair, contrast must be evaluated at the *decoded level*, not per-nibble. Example: weight=5 → (tens=0, ones=5), weight=6 → (tens=0, ones=6). The tens nibble is 0 in both groups — it would be incorrectly disqualified by a raw-nibble contrast check. Instead, track candidate address *pairs* as a single unit and check that the decoded BCD value differs across groups. Only discard a BCD pair if its decoded value is identical across all truth groups with enough distinct truth values to produce different tens digits. When truth values don't span enough range to exercise all nibbles of a pair, assign *partial confidence* rather than disqualifying.

#### Step C — Disqualification / Doubt Assignment

- If a candidate passes all groups except one, assign *partial doubt* rather than full rejection — the outlier group may contain a mis-annotated snapshot (natural value decay during "Investigate Live" is a common source).
- Track: `confidence = groups_consistent / groups_with_≥2_captures`.
- 100% → strong candidate; ≥80% → plausible; <80% → doubted.

#### Step D — Annotation-Error Tolerance

- Allow **one outlier per group** before failing it. If 7/8 captures agree and 1 disagrees, mark that single snapshot as a suspected annotation error rather than discarding the address.
- Always document the exception with the snapshot name so it can be re-verified.

---

### 6.2 Additional Methods

**A. Invariant Elimination**
- Find all addresses whose nibble value **never changes** across all captures.
- These are ROM constants or persistent flags — exclude them first to shrink the search space.

**B. Delta / Change Analysis**
- Find consecutive capture pairs where only ONE truth field changed (e.g., hunger 4→3).
- The set of RAM nibble addresses that changed between those two captures are prime candidates for that field.
- Most powerful when paired with value-grouping: the delta narrows candidates before stacking.

**C. Monotonicity / Correlation Check**
- For numeric fields (hunger, happy, age, weight), compute the rank-correlation between `nibble_value(addr)` and `truth_value` across all captures.
- High correlation (|r| > 0.85) is strong evidence. Inverse correlation is fine — the address might count *down* as the field goes *up*.

**D. Unique-Value Count Pruning**
- Hunger has at most 5 distinct values (0–4). An address showing 10+ distinct nibble values across captures cannot be a simple hunger register. Prune early.

**E. Cross-Field Exclusion**
- Once an address is confirmed for field A, mark it "claimed" and exclude it from future candidate sets for other fields. This speeds searches and avoids false re-discovery.

**F. Category Enumeration (Stage / Screen)**
- For categorical fields, each category maps to one expected nibble value. Collect all captures per category, apply within-group stacking (Step A), then verify the nibble values differ across categories. Since categories are discrete and few (≤5), even 2–3 captures per category is often sufficient.
- Stage identification priority: we have Baby, Child, Angel captures — stack each, then contrast.

**G. Temporal Drift Awareness**
- Captures taken seconds apart should have near-identical truth values. Captures from different sessions may have drifted. When assessing annotation errors, check if the outlier snapshot is isolated in time — if so, drift is the likely culprit, not a bad memory address.
