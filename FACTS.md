# ArduinoGotchi — Known Facts Reference

Verified facts about the emulator internals, confirmed from source code and/or reverse engineering.

---

## Tick Counter

| Property | Value |
|----------|-------|
| **Variable** | `tick_counter` (static, in `src/cpu.c:180`) |
| **CPU state field** | `cpu_state_t.tick_counter` (`src/cpu.h:70`) |
| **Type** | `u32_t` — **unsigned 32-bit integer** |
| **Frequency** | **32,768 Hz** (`TICK_FREQUENCY`, `src/cpu.h:25`) — matches the real Tamagotchi crystal |
| **Incremented by** | `wait_for_cycles()` in `src/cpu.c:1805`, called once per instruction with that instruction's cycle count (1–7 cycles) |
| **NOT in emulated RAM** | The counter is a host-side variable, not accessible at a nibble address |
| **Wraparound** | At **4,294,967,295 → 0** (32-bit rollover). With a 349-segment (~349 emu-hour) capture, this happens ~9 times. Wraparound-aware subtraction is used in `pc/main.cpp` |

### How it's read

Callers invoke `cpu_get_state(&st)` then read `st.tick_counter`. All stream capture log functions receive it as a `uint32_t tick` parameter. Example from `stream_capture.cpp`:

```c
cpu_state_t st;
cpu_get_state(&st);
g_streamCapture->logButtonEvent(st.tick_counter, buttonId, state);
```

### Time conversions

```
1 second  = 32,768 ticks
1 minute  = 1,966,080 ticks
1 hour    = 117,964,800 ticks  (STREAM_SEGMENT_TICKS, src/stream_capture.h:21)
Wraparound period ≈ 4,294,967,296 / 32,768 = 131,072 seconds ≈ 36.4 hours (emu-time)
```

### Implications for the stream viewer / tools

- **Tick values are NOT a globally sortable key** once the counter wraps. A given tick value can appear in multiple segments (one per wraparound cycle — roughly every 36 emu-hours / 35–38 segments at turbo speed).
- `bisect` on raw tick values produces wrong results in streams longer than ~36 emu-hours.
- The `CachedStateTracker.current_segment_idx` property uses the write-cursor (byte position in the stream) to identify the current segment unambiguously.
- Wraparound-aware 32-bit distance: `d = min(abs(a-b), 2^32 - abs(a-b))`.

---

## Emulated Timer Periods (from `src/cpu.h`)

| Timer | Period |
|-------|--------|
| 1 Hz  | 32,768 ticks |
| 256 Hz | 128 ticks |

---

## Lifecycle Nibble (`0x05D`)

| Value | Stage |
|-------|-------|
| 0 | Egg |
| 1 | Baby |
| 2 | Child |
| 4 | Teen |
| 9 | Adult |

Death transition: `9 → 1` directly (Adult → Baby). `isTamaEgg()` never fires on death.

---

## Sickness Memory Map

| Address | Meaning |
|---------|---------|
| `0x049` | Visible sick flag (derived; ROM re-asserts from `0x06D`) |
| `0x06D` | **Authoritative sick register** (lower nibble of byte `0x036`) |
| `0x048` | Illness level counter (0xF = max, ~5 at cure) |
| `0x0F3` | Death timer (counts up; medicine resets to 0) |

- **Do NOT write `0x06C`** (upper nibble of same byte `0x036`) — corrupts ROM state.
- Byte `0x036` values: `0x01` = sick, `0xC0` = cured, `0x00` = fresh baby.

---

## Dangerous Nibble Ranges

- `0x060–0x07F` — likely CPU call stack / runtime state. Writing fixed values here causes screen corruption and freeze. **Treat as read-only.**
