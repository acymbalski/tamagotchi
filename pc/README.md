# PC Simulator — Build & Run

Runs the full Tamagotchi simulation in a window on Windows. Same creature, same babysitter AI,
same logic as the ESP32 build. SDL2 handles the window and keyboard input.

---

## Prerequisites

### 1. Visual Studio Build Tools 2022
Download from **visualstudio.microsoft.com → Build Tools**.
During install, select **"Desktop development with C++"**.

### 2. CMake
Download from **cmake.org** and install. Make sure "Add CMake to PATH" is checked.

### 3. SDL2 development libraries (VC version)
1. Go to **github.com/libsdl-org/SDL/releases**
2. Find the latest SDL2 release (not SDL3)
3. Download **`SDL2-devel-x.y.z-VC.zip`** (the VC version, not mingw)
4. Extract it — you should get a folder like `SDL2-2.32.10\` containing `include\` and `lib\`
5. Place the extracted folder somewhere permanent, e.g. `C:\SDL2\SDL2-2.32.10`

---

## Build

Open **"x64 Native Tools Command Prompt for VS 2022"** from the Start menu.
(Not the regular Developer Command Prompt — the x64 one is required for 64-bit output.)

```cmd
cd C:\projects\tamagotchi\pc
mkdir build
cd build
cmake .. -G "Ninja" -DSDL2_ROOT=C:\SDL2\SDL2-2.32.10
ninja
```

Replace `C:\SDL2\SDL2-2.32.10` with wherever you extracted the SDL2 zip.

CMake will print the resolved SDL2 paths during configuration — verify they look correct.
After a successful build, `tamagotchi_pc.exe` and `SDL2.dll` will both appear in `pc\build\`.

---

## Run

From the same command prompt:

```cmd
tamagotchi_pc.exe
```

Or double-click `tamagotchi_pc.exe` in Explorer (SDL2.dll must be in the same folder, which
the build step handles automatically).

A 320×196 window opens showing the LCD grid and icon row.

---

## Controls

| Key | Action |
|-----|--------|
| `←` Left arrow or `Z` | Left button |
| `↓` Down arrow or `X` | Middle button |
| `→` Right arrow or `C` | Right button |
| `F` | Cycle speed: 1× → 10× → unlimited |
| `S` | Save state to `tama_save.bin` |
| `Esc` | Quit (state is saved automatically) |

Babysitter runs in **PROACTIVE** mode by default — watch stdout for feeding/play activity.

---

## Save States

The simulator saves to `tama_save.bin` in the working directory:
- Automatically every 2 minutes while running
- When `S` is pressed
- On exit (Esc or window close)

On next launch the save file is loaded automatically. Delete `tama_save.bin` to start fresh.

---

## Rebuilding after source changes

No need to re-run cmake. From `pc\build\`:

```cmd
ninja
```

## Reconfiguring (e.g. different SDL2 path)

```cmd
del CMakeCache.txt
rmdir /s /q CMakeFiles
cmake .. -G "Ninja" -DSDL2_ROOT=C:\new\path\to\SDL2
ninja
```
