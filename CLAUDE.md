# ArduinoGotchi — Agent Notes

## How to Build the PC Simulator

The PC simulator (`pc/build/tamagotchi_pc.exe`) is built with **MSVC + Ninja** (not MinGW,
despite what older notes may say). The build directory is `pc/build/` and already contains a
configured `build.ninja`. Do not re-run CMake unless the build system itself needs changing.

### The Only Working Build Command

Direct `ninja` invocation fails from MINGW bash because MSVC's headers aren't on the system
PATH. You must initialize the MSVC environment first. The only reliable method from bash is
to write a `.bat` file and run it via `cmd /c`:

```bat
@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64
cd /d C:\projects\tamagotchi\pc\build
"C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe"
echo EXIT_CODE=%ERRORLEVEL%
```

In a Bash tool call:
```bash
cat > /tmp/build_tama.bat << 'EOF'
@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64
cd /d C:\projects\tamagotchi\pc\build
"C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe"
echo EXIT_CODE=%ERRORLEVEL%
EOF
cmd /c "C:\Windows\System32\cmd.exe /c C:\Users\andrew\AppData\Local\Temp\build_tama.bat" 2>&1
```

A clean build prints `[1/N] Building ...` lines and `EXIT_CODE=0`. No output from ninja
(just the vcvarsall header) means **nothing was rebuilt** — check that your source file
modification timestamp is newer than the exe.

### Why `cmd /c "... && ninja"` Doesn't Work

The `&&` chaining from MINGW bash passes through the shell incorrectly — vcvarsall runs but
its environment exports don't persist to the next command. The `.bat` file approach keeps
everything in one cmd session.

### Key Paths

| Thing | Path |
|-------|------|
| vcvarsall.bat | `C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvarsall.bat` |
| ninja.exe | `C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe` |
| SDL2 headers | `C:\SDL2\include` (set in CMakeCache) |
| Build dir | `C:\projects\tamagotchi\pc\build\` |
| Output exe | `C:\projects\tamagotchi\pc\build\tamagotchi_pc.exe` |

### If You Need to Reconfigure CMake

Only do this if CMakeLists.txt changed. Run from a MSVC Developer Command Prompt or use the
same bat-file trick:

```bat
call vcvarsall.bat x64
cd /d C:\projects\tamagotchi\pc\build
cmake .. -G Ninja -DSDL2_DIR=C:/SDL2/cmake
ninja
```
