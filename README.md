# Tamagotchi

A Tamagotchi P1 emulator for ESP32, extended with an autonomous babysitter AI and a PC simulator for development.

The emulation core is [TamaLib](https://github.com/jcrona/tamalib) by Jean-Christophe Rona. This project builds on two prior forks ([GaryZ88/ArduinoGotchi](https://github.com/GaryZ88/ArduinoGotchi), [anabolyc/Tamagotchi](https://github.com/anabolyc/Tamagotchi)) which added ESP32 support and PlatformIO packaging.

## What this fork adds

**Babysitter AI** (`src/babysitter.cpp`) — monitors the tama's internal memory state and automatically issues button presses to feed it, play games, clean poop, give medicine, and toggle lights. Three modes:
- `PROACTIVE` — acts without being asked
- `REACTIVE` — acts only when the creature signals distress
- `INACTIVE` — does nothing

**WiFi / NTP sync** — connects to a configured network and syncs the emulator's clock to real time via NTP.

**Serial command interface** — send commands over the serial monitor to read/write memory, step the CPU, press buttons, dump state, adjust emulation speed, and more.

**PC simulator** (`pc/`) — compiles the same emulator and babysitter code to a native Windows executable using SDL2. Keyboard input replaces physical buttons. Useful for rapid iteration without flashing hardware. See `pc/README.md` for build instructions.

## Hardware (ESP32)

- ESP32 board (tested: `esp32dev`, `nodemcu-32s`, `heltec_wifi_lora_32_V3`)
- SSD1306 128x64 OLED display (I2C)
- Three momentary push buttons (left, middle, right)
- Optional piezo buzzer

## Building for ESP32

Uses [PlatformIO](https://platformio.org). Open the project in VS Code with the PlatformIO extension, or use the CLI:

```sh
pio run -e esp32          # build
pio run -e esp32 -t upload # flash
pio device monitor         # serial output
```

Available environments: `esp32`, `nodemcu-32s`, `heltec_wifi_lora_32_V3`.

## Configuration

Copy `src/wifi_config.h.sample` to `src/wifi_config.h` and fill in your network credentials for WiFi/NTP support.

Notable `platformio.ini` flags:

| Flag | Effect |
|------|--------|
| `ENABLE_AUTO_SAVE_STATUS` | Save state to EEPROM periodically |
| `ENABLE_LOAD_STATE_FROM_EEPROM` | Restore state on boot |
| `AUTO_SAVE_MINUTES` | Autosave interval (default 2) |
| `ENABLE_TAMA_SOUND` | Enable buzzer output |
| `TAMA_DISPLAY_FRAMERATE` | LCD refresh rate |

## PC Simulator

See [`pc/README.md`](pc/README.md).

## License

GPLv2. See `LICENSE`.
