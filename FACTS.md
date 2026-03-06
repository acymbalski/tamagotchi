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

## Evolution & Life Stages (Technical)

### Life Stage ID (`0x05D`)
*Note: As this is a 4-bit CPU, these values are stored in a single nibble (0-15).*

| Value | Stage |
|-------|-------|
| 0 | Egg |
| 1 | Baby (Babytchi) |
| 2 | Child (Marutchi) |
| 4 | Teen (Tamatchi / Kuchitamatchi) |
| 9 | Adult (Mametchi, Ginjirotchi, etc.) |
| 11 (0x0B) | Special (Bill / Oyajitchi) |

### Character ID within Stage (`0x050`)
| ID | Character (at Lifecycle stage) |
|----|-------------------------------|
| 1  | Child (Marutchi) |
| 2  | Teen T1 (Tamatchi) |
| 3  | Teen T2 (Tamatchi) |
| 4  | Teen KT1 (Kuchitamatchi) |
| 5  | Teen KT2 (Kuchitamatchi) |
| 15 (0xF) | All Adult / Special Characters |

### Evolution Discovered Routines
| ROM Addr | Function |
|----------|----------|
| **0x354** | **Main Evolution Logic Entry**. Checks lifecycle, mistakes, and determines next form. |
| **0xDC6** | **Evolution Table Router**. Uses `0x50` (Char) + `11` to jump to stage-specific threshold tables. |
| **0x35D** | **Threshold Comparison Loop**. Scans RAM `0x90` (initialized from ROM) to find the first matching tier. |
| **0xD9E** | **Child Initialization Table**. Sets thresholds for evolution into Teen forms. |
| **0xDA6** | **Teen T1 Initialization Table**. Sets thresholds for evolution into Adult forms. |
| **0xDBA** | **Teen KT Initialization Table**. Sets thresholds for lower-tier Adult forms. |
| **0x369** | **Character Commit**. Writes the selected Character ID (`0x50`) and Lifecycle ID (`0x5D`). |
| **0x371** | **Post-Evolution Setup**. Calls `0x89E` to reset graphics, weight, and state for the new form. |

### Manual Evolution Trigger
To force evolution safely (exactly as the CPU does it):
1.  Set **Neglect** (`0x42`) and **Mistakes** (`0x51`) to desired values.
2.  Set **Trigger Flag** `0x5C = 5`.
3.  The ROM will detect `0x5C == 5` on the next timer tick, run the decision tree, and call the re-initialization routines.

**Warning**: Manually writing to `0x50` and `0x5D` without triggering the state machine (Step 3) often leads to a "panic" state (permanent sleep) because the ROM's internal graphics and activity timers are not re-aligned to the new character.

---

## Care Mistakes (Technical)
There are two distinct types of care mistakes tracked by the ROM:

1. **Neglect (Care Mistakes)**
   - **Address:** `0x042` (nibble)
   - **Behavior:** Increments when an Attention call triggered by **Hunger** or **Happiness** hitting zero is ignored for 15 minutes.
   - **Logic:** Incremented via saturated addition at ROM `0xFDF` (calls `0xFE8`).

2. **Behavior Mistakes (Discipline Mistakes)**
   - **Address:** `0x051` (nibble)
   - **Behavior:** Increments when an Attention call triggered by **Discipline** (false call) is ignored.
   - **Logic:** Incremented via saturated addition at ROM `0xFD1` (calls `0xFE8`).

- **Limits:** Both counters are single-nibble and capped at `15` (`0xF`).
