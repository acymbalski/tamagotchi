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
