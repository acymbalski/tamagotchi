# Emulator Determinism Investigation

## Finding: The Emulator Is Deterministic

Given the same `cpu_state_t` save-state and the same sequence of button inputs at the same
tick offsets, the PC simulator produces **bit-identical output** on every replay. This was
confirmed by running two captures from the same initial state with identical babysitter
automation and comparing the resulting `.tamstream` files.

---

## Why It Is Deterministic

### `cpu.c` is a Pure State Machine

The CPU core (`src/cpu.c`) implements the S1C88 instruction set as a pure function of
`cpu_state_t`. All state lives in that struct:

- `memory[160]` — 640 nibbles of RAM, fully captured
- `pc`, `np`, `sp`, `x`, `y`, `a`, `b`, `flags` — all registers
- `tick_counter` — 32-bit monotonic tick count
- `clk_timer_timestamp`, `prog_timer_timestamp`, `prog_timer_data` — all timer state
- `halt`, `interrupt_factor_flags`, `interrupt_mask_flags` — all interrupt state

There is no:
- Global RNG or `rand()` call
- Uninitialized memory access
- Floating-point arithmetic in the tick computation
- Hidden OS clock reads
- Thread-local or global mutable state outside `cpu_state_t`

### `cpu_state_t` Is Complete

`pc_savestate.cpp` serializes/deserializes every field of `cpu_state_t` via
`cpu_get_state()` / `cpu_set_state()`. Loading a save-state and continuing execution is
bit-identical to the original run from that point.

### Button Presses Are the Only External Input

The only way the emulator state changes is through:
1. **CPU execution** (`tamalib_mainloop_step_by_step()`) — deterministic
2. **Button events** (`hw_set_button()`) — fully captured in `.tamstream` as
   `STREAM_REC_BUTTON_EVENT` records

Everything else (LCD output, audio) is derived from the emulator state, not input to it.

---

## The Single Non-Deterministic Input: NTP Time Sync

`src/babysitter.cpp:setTimeViaNTP()` calls `time(nullptr)` (wall clock) to set the
in-game clock. If this function runs during a capture, the in-game time may differ
between captures started at different wall-clock times.

**Mitigation**: Use `--babysitter off` or `--no-ntp` (if implemented) to disable NTP
sync during deterministic replay captures. Alternatively, run headless with the babysitter
operating only on lifecycle events that don't call `setTimeViaNTP()`.

---

## Future Optimization: Compact Replay Format

Because the emulator is deterministic, a much more compact capture format is possible:

**Format**: Store only
- Initial `cpu_state_t` (full RAM snapshot, ~650 bytes)
- Ordered list of button events: `(tick_offset, button_id, state)`

**Replay**: Starting from the initial state, run the emulator forward, injecting button
events at the specified tick offsets. Any intermediate state can be reconstructed by
replaying from the nearest prior checkpoint.

**Size estimate**: A full lifecycle (several emulated days) might be captured in under
1 MB (a few thousand button events × 8 bytes each, plus periodic checkpoints for
fast-seek).

**Tradeoff vs current approach**:
- Current `.tamstream`: instant seek to any tick, ~200–600 MB (post-optimization)
- Compact replay: seconds of background replay to seek to arbitrary ticks, <1 MB

The optimal choice depends on use case. For debugging and investigation (where instant
seek matters), `.tamstream` is preferred. For archival and automated analysis, compact
replay is superior.

---

## Platform Considerations

- **Endianness**: All multi-byte values in the emulator are little-endian. The PC build
  targets x86-64 (little-endian) only.
- **Integer arithmetic**: Tick counting uses `uint32_t` throughout. No `long` or `size_t`
  ambiguity in tick math.
- **Floating-point**: `cpu_speed_ratio` (float) controls wall-clock sleep time between
  ticks, but the tick counter itself increments by a fixed integer on every step. Float
  rounding does not affect emulator state.
- **MSVC vs GCC**: The CPU core uses only C11 standard integer types. No
  compiler-specific behavior affects determinism.
