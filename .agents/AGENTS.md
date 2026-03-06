# Tamagotchi P1 Emulation & Reverse Engineering

This document serves as the primary technical reference for all AI agents (Gemini, Claude, etc.) working on this project.

## Project Overview

The project is an ecosystem for Tamagotchi P1 emulation and memory analysis, split into three main components:
1.  **Core Emulator (TamaLib):** A hardware-agnostic C implementation of the Epson E0C6S46 (E0C6200 core) 4-bit CPU.
2.  **Harnesses:**
    *   **PC Simulator:** SDL2-based harness (`pc/`) built with MSVC.
    *   **Embedded:** ESP32-based implementation using PlatformIO.
3.  **Investigation & Disassembly Lab:**
    *   **Disassembly (`disassembly/`):** Contains the master ROM disassembly (`rom_disassembly.asm`) and the generation tools.
    *   **Stream Analysis (`tools/`):** Python-based tools for capturing and analyzing execution streams (`.tamstream`).
    *   **Investigator GUI:** PyQt6 application for viewing/annotating memory snapshots.

## Directory Structure

*   `src/`: Shared C/C++ source code (emulator core, babysitter logic, stream capture).
*   `pc/`: Windows-specific simulator harness using SDL2.
*   `disassembly/`: Master ROM disassembly and automated generation tools.
    *   `disassembly/investigation/`: Archive of helper scripts used for memory discovery.
*   `captures/`: Storage for memory snapshots (`.bin`) and streams (`.tamstream`).
*   `tools/`: Helper scripts and the `stream_viewer.py` timeline analysis tool.
*   `memory_config.py`: **Source of Truth** for the RAM map. Update this when new addresses are discovered.

## Building the PC Simulator

The PC simulator can be built for both Windows and Linux.

### Windows (MSVC + Ninja)
The simulator (`pc/build/tamagotchi_pc.exe`) is built with **MSVC + Ninja**.
To build from a shell, you must initialize the MSVC environment via a `.bat` file:

```bat
@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64
cd /d C:\projects	amagotchi\pc\build
"C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja
inja.exe"
```

### Linux (GCC + Make)
The simulator (`pc/linux/tamagotchi_pc`) is built using a standard Makefile.

```bash
cd pc/linux
make -j$(nproc)
```

## Discovery Routine

Follow these steps when a new RAM address is identified:
1.  **Update `memory_config.py`**: Add the address and type to the `MAP` dictionary.
2.  **Update `tools/stream_viewer.py`**: Add a color to `FIELD_COLORS` and add the field to `stat_names`.
3.  **Update `pc/main.cpp`**: Add a new `STAT_ROW` to the live stats panel.
4.  **Update `src/babysitter.h`**: Sync the `MEM_LOC_...` macro.
5.  **Update `FACTS.md`**: Document the ROM logic and trigger conditions.
6.  **Regenerate Disassembly**: Run `python disassembly/disassemble_rom.py` to refresh labels.

## Key Memory Findings

| Address | Name | Type | Description |
| :--- | :--- | :--- | :--- |
| **0x040** | `hunger` | `level` | 0-4 Hearts |
| **0x041** | `happy` | `level` | 0-4 Hearts |
| **0x042** | `neglect` | `nibble` | Hunger/Happy ignored mistakes. |
| **0x051** | `behavior_mistake`| `nibble` | Discipline ignored mistakes. |
| **0x02D** | `attention` | `bool` | Active calling icon. |
| **0x054** | `age` | `bcd` | Age in years. |
| **0x05D** | `lifecycle` | `stage` | Egg, Baby, Child, Teen, Adult. |

## Knowledge Base
*   **`FACTS.md`**: Detailed technical specs on timers, flags, and CPU initial state.
*   **`GAME_RULES.md`**: Gameplay mechanics and evolution requirements.
*   **`disassembly/rom_disassembly.asm`**: Heavily annotated listing of the entire program.
