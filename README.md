<h3 align="center"> arduinogotchi - a real tamagotchi emulator for arduino uno </h3>

> this repository is forked; this is my attempt to make tamagotchi with some minor changes
> ### fork notice ( previous )
> 
> I did the following changes after forking [original repo](https://github.com/GaryZ88/ArduinoGotchi)
> - Created a platformio project, so it is easy to target multiple platforms
> - Created ports for ESP8266 and ESP32, mainly because speed on 8-bit AVR is just too slow
> - Added long click on "back" button - if you press it for 5 seconds, it will reset memory back to egg state
> - Added inverted Speaker connection setting. Mainly because the Piezo modules that I have are active on Low. Another reason is mentioned below.
> 
> I personally assembled the ESP8266 version with Wemos D1 Mini on perf board, using built-in LED together with speaker, so when it sounds, LED is blinking as well.

### fork notice

I did the following changes after forking [above forked repo](https://github.com/anabolyc/Tamagotchi)
- Removed `esp8266-space-invaders` from `firmware`
- Rearranged directories
- Created a casing for the hardware

### synopsis

**ArduinoGotchi** is a real [Tamagotchi P1](https://tamagotchi.fandom.com/wiki/Tamagotchi_(1996_Pet)) emulator running in Arduino UNO hardware. The emulation core is based on [TamaLib](https://github.com/jcrona/tamalib) with intensive optimization to make it fit into UNO's hardware that only comes with 32K Flash 2K RAM.

![Tamagotchi P1 Actual Devices](images/TamaP1_devices.jpg)

## How to build and run

Use Platformio. Run `build` task to build for all platforms. Next, run the `Upload` task for a specific platform

### Additional notes
- To activate your pet, you have to configure the clock by pressing the middle button. Otherwise, your pet will not be alive.
- The emulator will save the game status every 5 minutes. You can change that by changing the AUTO_SAVE_MINUTES setting
- The speed of the emulator is a bit slower than the actual Tamagotchi device on AVR, still, it is fun. On ESPs it runs smoothly.
- There are a few costs in the `platformio.ini` that you can adjust to fit your needs:
```
  -D DISPLAY_I2C_ADDRESS=0x3C
  -D SCREEN_WIDTH=128
  -D SCREEN_HEIGHT=64
  -D ENABLE_TAMA_SOUND
  -D ENABLE_TAMA_SOUND_ACTIVE_LOW
  -D ENABLE_AUTO_SAVE_STATUS
  -D ENABLE_LOAD_STATE_FROM_EEPROM
```

> ### license
> ArduinoGotchi is distributed under the GPLv2 license. See the LICENSE file for more information.
> ### where to buy
> You may support my work by ordering the kit on [Tindie](https://www.tindie.com/products/sonocotta/esp8266-tamagotchi-diy-kit/) or [Elecrow](https://www.elecrow.com/esp8266-tamagotchi-diy-kit.html)
