# Tamagotchi Memory Investigation Plan

This document outlines the strategy for reverse-engineering the Tamagotchi P1 memory map using a semi-automated "Snapshot & Annotate" workflow.

## 1. Architectural Overview

The system consists of two primary components:
1.  **The Worker (C++ Simulator):** An enhanced version of the existing PC simulator that supports high-speed execution, state loading, and periodic snapshots.
2.  **The Lab Manager (Python GUI):** A PyQt6-based application that manages the simulator lifecycle, handles annotations, and allows for "Live Investigation" of specific memory states.

---

## 2. Component Specifications

### A. Enhanced C++ Simulator (`tamagotchi_pc`)
- **CLI Arguments:**
    - `--load-state <path>`: Starts the simulator from a specific `.bin` save state.
    - `--auto-snapshot <mins>`: Automatically saves a snapshot every N emulated minutes.
    - `--babysitter <on|off>`: Sets the initial state of the babysitter logic.
    - `--turbo`: Starts in unlimited speed mode.
- **Keybinds:**
    - `K`: Manual snapshot trigger.
    - `B`: Toggle babysitter on/off.
    - `F`: Cycle speed (1x, 10x, Turbo).
- **Output:**
    - Saves a pair of files to `captures/`: `snap_<timestamp>.bin` (raw `cpu_state_t`) and `snap_<timestamp>.bmp` (32x16 LCD state).

### B. Python Lab Manager (`investigator.py`)
- **Collection Mode:**
    - Monitors the `captures/` directory.
    - Tracks the number of snapshots; provides real-time status of data collection.
    - Provides a button to "Spawn Turbo Sim" to start the data collection run.
- **Annotation Mode:**
    - Displays the snapshot BMP (scaled up for visibility).
    - **Fields:** Hunger (0-4), Happiness (0-4), Poop (0-4), Sick (Y/N), Stage (Egg/Baby/Child/Teen/Adult/Senior/Angel), Weight, Age.
    - **Pre-population:** Uses current known memory addresses (from `babysitter.h`) to guess values.
    - **Notes:** A text area for qualitative observations.
    - **Persistence:** Automatically saves to `annotations.json` every time the user navigates to a different snapshot.
- **Live Investigation Bridge:**
    - A button to launch a 1x speed simulator instance using the current snapshot's `.bin` file. This allows the user to manually interact with the Tama (e.g., check the stats screen) to fill in missing annotation data.

---

## 3. Data Schema

### captures/
- `snap_17123456.bin`: Binary dump of `cpu_state_t`.
- `snap_17123456.bmp`: 1-bit or 24-bit bitmap of the LCD matrix.

### annotations.json
```json
{
  "snap_17123456": {
    "hunger": 4,
    "happy": 3,
    "poop": 0,
    "sick": false,
    "stage": "child",
    "weight": 15,
    "age": 2,
    "notes": "Just evolved from baby. Sleeping pattern changed.",
    "investigated": true
  }
}
```

---

## 4. Implementation Strategy

### Phase 1: Simulator Upgrades
1.  Update `pc/pc_savestate.h/cpp` to handle arbitrary file paths for saving/loading.
2.  Modify `pc/main.cpp` to parse CLI arguments.
3.  Implement the `auto-snapshot` logic based on emulated ticks.
4.  Implement a simple BMP exporter for the `matrix_buffer`.

### Phase 2: Python Lab Manager
1.  Create `investigator.py` using `PyQt6`.
2.  Implement the folder watcher and subprocess management for the C++ sim.
3.  Build the annotation form with auto-save logic.

### Phase 3: Analysis (Future)
1.  Develop a script to correlate `annotations.json` values with bit-changes in the `.bin` files across the collected snapshot set.

---

## 5. User Workflow
1.  **Initialize:** Start `investigator.py`.
2.  **Collect:** Click "Start Turbo Sim". Manually set the time in the simulator, then let it run at max speed.
3.  **Threshold:** The sim continues until manually stopped by the user once they feel they have enough data.
4.  **Annotate:** Iterate through snapshots. For ambiguous ones, click "Investigate Live" to check menus.
5.  **Finalize:** Annotations are saved; data is ready for memory mapping analysis.
