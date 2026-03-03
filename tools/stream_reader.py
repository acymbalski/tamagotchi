#!/usr/bin/env python3
"""Library for reading and querying .tamstream files."""

import struct
import os
import sys

# Record type tags
REC_RAM_SNAPSHOT     = 0x01
REC_ROM_WRITE        = 0x02
REC_BABYSITTER_WRITE = 0x03
REC_LCD_FRAME        = 0x04
REC_ANNOTATION       = 0x05
REC_TICK_MARKER      = 0x06
REC_BUTTON_EVENT     = 0x07

BFID_NAMES = {
    0: "NONE", 1: "FEED_FOOD", 2: "FEED_SNACK", 3: "GIVE_MEDICINE",
    4: "PLAY_GAME", 5: "TOGGLE_LIGHTS", 6: "CLEAN_POOP", 7: "CHECK_STATS",
    8: "SET_TIME", 9: "FORCE_AGE_UP", 10: "SET_CHARACTER", 11: "FORCE_MODE",
    12: "DISCIPLINE",
}

RECORD_NAMES = {
    REC_RAM_SNAPSHOT: "ram_snapshot", REC_ROM_WRITE: "rom_write",
    REC_BABYSITTER_WRITE: "babysitter_write", REC_LCD_FRAME: "lcd_frame",
    REC_ANNOTATION: "annotation", REC_TICK_MARKER: "tick_marker",
    REC_BUTTON_EVENT: "button_event",
}

BUTTON_NAMES = {0: "LEFT", 1: "MIDDLE", 2: "RIGHT"}
BUTTON_STATES = {0: "RELEASED", 1: "PRESSED"}

# LCD frame sizes by stream version
LCD_BYTES_V1 = 50   # version 1: placeholder zeros (or raw display mem)
LCD_BYTES_V2 = 72   # version 2: matrix_buffer (64) + icon_buffer (8)

def _fixed_sizes(lcd_bytes=LCD_BYTES_V1):
    """Record body sizes (after tag byte), parameterized by LCD frame size."""
    return {
        REC_RAM_SNAPSHOT:     4 + 320,
        REC_ROM_WRITE:        4 + 2 + 1,
        REC_BABYSITTER_WRITE: 4 + 2 + 1 + 1,
        REC_LCD_FRAME:        4 + lcd_bytes,
        REC_TICK_MARKER:      4,
        REC_BUTTON_EVENT:     4 + 1 + 1,
    }

# Default for backward compat (used by code that doesn't have version info)
_FIXED_SIZES = _fixed_sizes(LCD_BYTES_V1)

RAM_BYTES = 320  # packed bytes (640 nibbles)

# Icon labels (must match pc/main.cpp icon_labels)
ICON_LABELS = ["FOOD", "LGHT", "GAME", "MED", "BATH", "STAT", "DISC", "ATTN"]


class TamStream:
    """Read and query a .tamstream capture file."""

    def __init__(self, filepath, progress_callback=None):
        self.filepath = filepath
        self._file = open(filepath, "rb")
        self._parse_header()
        self._build_index(progress_callback)

    def _parse_header(self):
        header = self._file.read(16)
        if len(header) < 16 or header[0:4] != b"TAMS":
            raise ValueError(f"Invalid .tamstream file: {self.filepath}")
        self.version = struct.unpack_from("<H", header, 4)[0]
        self.lcd_bytes = LCD_BYTES_V2 if self.version >= 2 else LCD_BYTES_V1
        self._rec_sizes = _fixed_sizes(self.lcd_bytes)
        self.start_tick = struct.unpack_from("<I", header, 6)[0]
        self.ram_nibbles = struct.unpack_from("<H", header, 10)[0]

    def _build_index(self, progress_callback=None):
        """Scan the file and build an index of record positions."""
        self._records_start = 16
        self._snapshot_positions = []  # (tick, file_offset) for RAM snapshots
        self._lcd_frame_index = []     # (tick, file_offset) for LCD frames
        self._tick_marker_ticks = []   # tick values for tick markers
        self._annotation_records = []  # (tick, text)
        self._button_records = []      # (tick, button_id, state)
        self._first_tick = None
        self._last_tick = None
        self._record_count = 0

        f = self._file
        file_size = f.seek(0, 2)
        f.seek(self._records_start)

        while True:
            pos = f.tell()
            tag_byte = f.read(1)
            if not tag_byte:
                break
            tag = tag_byte[0]

            if tag == REC_ANNOTATION:
                data = f.read(6)
                if len(data) < 6:
                    break
                tick = struct.unpack_from("<I", data, 0)[0]
                text_len = struct.unpack_from("<H", data, 4)[0]
                text_data = f.read(text_len)
                self._annotation_records.append((tick, text_data.decode("utf-8", errors="replace")))
            elif tag in self._rec_sizes:
                size = self._rec_sizes[tag]
                data = f.read(size)
                if len(data) < size:
                    break
                tick = struct.unpack_from("<I", data, 0)[0]
            else:
                break

            if tag == REC_RAM_SNAPSHOT:
                self._snapshot_positions.append((tick, pos))
            elif tag == REC_LCD_FRAME:
                self._lcd_frame_index.append((tick, pos))
            elif tag == REC_TICK_MARKER:
                self._tick_marker_ticks.append(tick)
            elif tag == REC_BUTTON_EVENT:
                button_id = data[4]
                state = data[5]
                self._button_records.append((tick, button_id, state))

            if self._first_tick is None:
                self._first_tick = tick
            self._last_tick = tick
            self._record_count += 1

            # Progress callback every 100k records
            if progress_callback and self._record_count % 100000 == 0:
                pct = min(99, int(f.tell() * 100 / file_size)) if file_size > 0 else 0
                progress_callback(pct, f"Indexing records... {self._record_count:,}")

        if progress_callback:
            progress_callback(100, f"Indexed {self._record_count:,} records")

    @property
    def tick_range(self):
        """(first_tick, last_tick) tuple."""
        return (self._first_tick, self._last_tick)

    def records(self):
        """Generator yielding (record_type, tick, data_dict) tuples."""
        f = self._file
        f.seek(self._records_start)

        while True:
            tag_byte = f.read(1)
            if not tag_byte:
                return
            tag = tag_byte[0]

            if tag == REC_RAM_SNAPSHOT:
                data = f.read(4 + RAM_BYTES)
                tick = struct.unpack_from("<I", data, 0)[0]
                yield (tag, tick, {"memory": data[4:]})

            elif tag == REC_ROM_WRITE:
                data = f.read(7)
                tick, addr = struct.unpack_from("<IH", data, 0)
                value = data[6]
                yield (tag, tick, {"addr": addr, "value": value, "source": "rom"})

            elif tag == REC_BABYSITTER_WRITE:
                data = f.read(8)
                tick, addr = struct.unpack_from("<IH", data, 0)
                value = data[6]
                func_id = data[7]
                yield (tag, tick, {"addr": addr, "value": value, "source": "babysitter",
                                   "func_id": func_id, "func_name": BFID_NAMES.get(func_id, f"UNKNOWN_{func_id}")})

            elif tag == REC_LCD_FRAME:
                data = f.read(4 + self.lcd_bytes)
                tick = struct.unpack_from("<I", data, 0)[0]
                yield (tag, tick, {"display": data[4:]})

            elif tag == REC_ANNOTATION:
                data = f.read(6)
                tick = struct.unpack_from("<I", data, 0)[0]
                text_len = struct.unpack_from("<H", data, 4)[0]
                text = f.read(text_len).decode("utf-8", errors="replace")
                yield (tag, tick, {"text": text})

            elif tag == REC_TICK_MARKER:
                data = f.read(4)
                tick = struct.unpack_from("<I", data, 0)[0]
                yield (tag, tick, {})

            elif tag == REC_BUTTON_EVENT:
                data = f.read(6)
                tick = struct.unpack_from("<I", data, 0)[0]
                button_id = data[4]
                state = data[5]
                yield (tag, tick, {"button_id": button_id, "state": state,
                                   "button_name": BUTTON_NAMES.get(button_id, f"BTN_{button_id}"),
                                   "state_name": BUTTON_STATES.get(state, f"STATE_{state}")})
            else:
                return  # Unknown tag, stop

    def state_at_tick(self, target_tick):
        """Reconstruct full packed RAM (320 bytes) at the given tick."""
        # Find the nearest prior RAM snapshot
        best_snap = None
        for snap_tick, snap_pos in self._snapshot_positions:
            if snap_tick <= target_tick:
                best_snap = (snap_tick, snap_pos)
            else:
                break

        if best_snap is None:
            raise ValueError(f"No RAM snapshot found at or before tick {target_tick}")

        # Read the snapshot
        f = self._file
        f.seek(best_snap[1] + 1 + 4)  # skip tag + tick
        ram = bytearray(f.read(RAM_BYTES))

        # Replay writes from snapshot tick to target tick
        f.seek(self._records_start)
        replaying = False

        while True:
            tag_byte = f.read(1)
            if not tag_byte:
                break
            tag = tag_byte[0]

            if tag == REC_ANNOTATION:
                hdr = f.read(6)
                if len(hdr) < 6:
                    break
                tick = struct.unpack_from("<I", hdr, 0)[0]
                text_len = struct.unpack_from("<H", hdr, 4)[0]
                f.seek(text_len, 1)
            elif tag in self._rec_sizes:
                size = self._rec_sizes[tag]
                data = f.read(size)
                if len(data) < size:
                    break
                tick = struct.unpack_from("<I", data, 0)[0]
            else:
                break

            if tick > target_tick:
                break

            if tick < best_snap[0]:
                continue

            replaying = True

            # Apply writes to RAM
            if tag in (REC_ROM_WRITE, REC_BABYSITTER_WRITE):
                addr = struct.unpack_from("<H", data, 4)[0]
                value = data[6]
                if addr < 640:  # MEM_RAM_SIZE nibbles
                    byte_idx = addr >> 1
                    if byte_idx < RAM_BYTES:
                        if (addr & 1) == 0:
                            ram[byte_idx] = (ram[byte_idx] & 0x0F) | (value << 4)
                        else:
                            ram[byte_idx] = (ram[byte_idx] & 0xF0) | (value & 0x0F)

        return bytes(ram)

    def stats_at_tick(self, target_tick):
        """Return decoded stats dict at a given tick using memory_config."""
        ram = self.state_at_tick(target_tick)
        try:
            sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
            import memory_config
            result = {}
            for name in memory_config.MAP:
                val = memory_config.get_value(ram, name)
                if val is not None:
                    result[name] = val
            return result
        except ImportError:
            return {"error": "memory_config.py not found"}

    def writes_in_range(self, start_tick, end_tick, addr=None, source=None):
        """Filtered iterator for write records in a tick range."""
        for rec_type, tick, data in self.records():
            if tick < start_tick:
                continue
            if tick > end_tick:
                return
            if rec_type not in (REC_ROM_WRITE, REC_BABYSITTER_WRITE):
                continue
            if source == "rom" and rec_type != REC_ROM_WRITE:
                continue
            if source == "babysitter" and rec_type != REC_BABYSITTER_WRITE:
                continue
            if addr is not None and data["addr"] != addr:
                continue
            yield (rec_type, tick, data)

    def annotations(self):
        """List of (tick, text) tuples."""
        return list(self._annotation_records)

    def lcd_frames(self):
        """Generator of (tick, frame_bytes) tuples."""
        for rec_type, tick, data in self.records():
            if rec_type == REC_LCD_FRAME:
                yield (tick, data["display"])

    def button_events(self):
        """Generator of (tick, button_id, state) tuples."""
        return list(self._button_records)

    def read_lcd_frame_at(self, file_offset):
        """Read LCD frame data from a known file offset."""
        f = self._file
        f.seek(file_offset + 1 + 4)  # skip tag + tick
        return f.read(self.lcd_bytes)

    def nearest_lcd_frame(self, target_tick):
        """Return (tick, frame_bytes) closest to given tick. Uses index for speed."""
        if not self._lcd_frame_index:
            return None
        # Binary search for nearest
        import bisect
        ticks = [t for t, _ in self._lcd_frame_index]
        idx = bisect.bisect_left(ticks, target_tick)
        best_idx = idx
        if idx >= len(ticks):
            best_idx = len(ticks) - 1
        elif idx > 0:
            # Check which neighbor is closer
            if abs(ticks[idx - 1] - target_tick) <= abs(ticks[idx] - target_tick):
                best_idx = idx - 1
        tick, offset = self._lcd_frame_index[best_idx]
        frame_data = self.read_lcd_frame_at(offset)
        return (tick, frame_data)

    def close(self):
        if self._file:
            self._file.close()
            self._file = None

    def __del__(self):
        self.close()

    def __enter__(self):
        return self

    def __exit__(self, *args):
        self.close()


class CachedStateTracker:
    """Maintains RAM state with efficient forward/backward stepping.

    Builds an index of all write events with old values for reversibility.
    Supports seek, step_forward, step_backward, and step_to_tick.

    Usage:
        tracker = CachedStateTracker(tam_stream, progress_callback=None)
        tracker.seek(tick)          # Jump to any tick (uses snapshots)
        tracker.step_forward(n)     # Step forward n write-events
        tracker.step_backward(n)    # Step backward n write-events (reverts)
        tracker.step_to_tick(tick)  # Step to exact tick (forward or backward)
        state = tracker.ram         # Current 320-byte RAM state
        diff = tracker.last_diff    # Dict of {addr: (old_val, new_val)}
    """

    def __init__(self, tam_stream, progress_callback=None):
        self._stream = tam_stream
        self._ram = bytearray(RAM_BYTES)
        self._write_cursor = 0   # index into _writes
        self._current_tick = 0
        self._last_diff = {}
        self._writes = []         # [(tick, addr, new_val, old_val, source, func_id), ...]
        self._build_write_index(progress_callback)

    def _build_write_index(self, progress_callback=None):
        """Scan all records and build indexed write list with old_values."""
        # Start from first snapshot to get a baseline
        if not self._stream._snapshot_positions:
            return

        snap_tick, snap_pos = self._stream._snapshot_positions[0]
        f = self._stream._file
        f.seek(snap_pos + 1 + 4)  # skip tag + tick
        running_ram = bytearray(f.read(RAM_BYTES))

        writes = []
        count = 0
        for rec_type, tick, data in self._stream.records():
            if rec_type in (REC_ROM_WRITE, REC_BABYSITTER_WRITE):
                addr = data["addr"]
                new_val = data["value"]
                if addr < 640:
                    byte_idx = addr >> 1
                    if byte_idx < RAM_BYTES:
                        # Get old value
                        if (addr & 1) == 0:
                            old_val = (running_ram[byte_idx] & 0xF0) >> 4
                        else:
                            old_val = running_ram[byte_idx] & 0x0F
                        # Apply new value to running state
                        if (addr & 1) == 0:
                            running_ram[byte_idx] = (running_ram[byte_idx] & 0x0F) | (new_val << 4)
                        else:
                            running_ram[byte_idx] = (running_ram[byte_idx] & 0xF0) | (new_val & 0x0F)

                        source = 0 if rec_type == REC_ROM_WRITE else 1
                        func_id = data.get("func_id", 0)
                        writes.append((tick, addr, new_val, old_val, source, func_id))

            elif rec_type == REC_RAM_SNAPSHOT:
                # Reset running_ram to this snapshot
                mem = data["memory"]
                running_ram = bytearray(mem)

            count += 1
            if progress_callback and count % 200000 == 0:
                progress_callback(None, f"Building write index... {len(writes):,} writes")

        self._writes = writes
        if progress_callback:
            progress_callback(None, f"Write index complete: {len(writes):,} writes")

    @property
    def current_tick(self):
        return self._current_tick

    @property
    def ram(self):
        return bytes(self._ram)

    @property
    def last_diff(self):
        return dict(self._last_diff)

    @property
    def write_cursor(self):
        return self._write_cursor

    @property
    def total_writes(self):
        return len(self._writes)

    def _apply_nibble(self, addr, value):
        """Apply a nibble value to the RAM."""
        byte_idx = addr >> 1
        if byte_idx < RAM_BYTES:
            if (addr & 1) == 0:
                self._ram[byte_idx] = (self._ram[byte_idx] & 0x0F) | (value << 4)
            else:
                self._ram[byte_idx] = (self._ram[byte_idx] & 0xF0) | (value & 0x0F)

    def _read_nibble(self, addr):
        """Read a nibble value from the RAM."""
        byte_idx = addr >> 1
        if byte_idx < RAM_BYTES:
            if (addr & 1) == 0:
                return (self._ram[byte_idx] & 0xF0) >> 4
            else:
                return self._ram[byte_idx] & 0x0F
        return 0

    def seek(self, tick):
        """Jump to any tick. Uses nearest snapshot + replay from write index."""
        self._last_diff = {}

        # Find the nearest prior snapshot
        best_snap = None
        for snap_tick, snap_pos in self._stream._snapshot_positions:
            if snap_tick <= tick:
                best_snap = (snap_tick, snap_pos)
            else:
                break

        if best_snap is None:
            if self._stream._snapshot_positions:
                best_snap = self._stream._snapshot_positions[0]
            else:
                return

        # Load snapshot RAM
        f = self._stream._file
        f.seek(best_snap[1] + 1 + 4)
        self._ram = bytearray(f.read(RAM_BYTES))

        # Binary search for first write at or after snapshot tick
        import bisect
        snap_tick = best_snap[0]
        # Find start position in writes list
        start_idx = bisect.bisect_left([w[0] for w in self._writes], snap_tick)

        # Apply writes from snapshot through target tick
        self._write_cursor = start_idx
        while self._write_cursor < len(self._writes):
            w_tick = self._writes[self._write_cursor][0]
            if w_tick > tick:
                break
            _, addr, new_val, old_val, source, func_id = self._writes[self._write_cursor]
            self._apply_nibble(addr, new_val)
            self._write_cursor += 1

        self._current_tick = tick

    def step_forward(self, n=1):
        """Step forward n write-events. Returns actual steps taken."""
        self._last_diff = {}
        steps = 0
        while steps < n and self._write_cursor < len(self._writes):
            tick, addr, new_val, old_val, source, func_id = self._writes[self._write_cursor]
            cur_val = self._read_nibble(addr)
            self._apply_nibble(addr, new_val)
            self._last_diff[addr] = (cur_val, new_val)
            self._current_tick = tick
            self._write_cursor += 1
            steps += 1
        return steps

    def step_backward(self, n=1):
        """Step backward n write-events. Returns actual steps taken."""
        self._last_diff = {}
        steps = 0
        while steps < n and self._write_cursor > 0:
            self._write_cursor -= 1
            tick, addr, new_val, old_val, source, func_id = self._writes[self._write_cursor]
            cur_val = self._read_nibble(addr)
            self._apply_nibble(addr, old_val)
            self._last_diff[addr] = (cur_val, old_val)
            # Set current_tick to the previous write's tick, or snapshot tick
            if self._write_cursor > 0:
                self._current_tick = self._writes[self._write_cursor - 1][0]
            else:
                # Back at the beginning
                if self._stream._snapshot_positions:
                    self._current_tick = self._stream._snapshot_positions[0][0]
                else:
                    self._current_tick = 0
            steps += 1
        return steps

    def step_to_tick(self, tick):
        """Step to exact tick. Uses incremental stepping if close, seek if far."""
        if tick == self._current_tick:
            return

        if tick > self._current_tick:
            # Step forward until we pass the target tick
            self._last_diff = {}
            while self._write_cursor < len(self._writes):
                w_tick = self._writes[self._write_cursor][0]
                if w_tick > tick:
                    break
                _, addr, new_val, old_val, source, func_id = self._writes[self._write_cursor]
                cur_val = self._read_nibble(addr)
                self._apply_nibble(addr, new_val)
                self._last_diff[addr] = (cur_val, new_val)
                self._write_cursor += 1
            self._current_tick = tick
        else:
            # Step backward
            self._last_diff = {}
            while self._write_cursor > 0:
                prev_tick = self._writes[self._write_cursor - 1][0]
                if prev_tick < tick:
                    break
                self._write_cursor -= 1
                _, addr, new_val, old_val, source, func_id = self._writes[self._write_cursor]
                cur_val = self._read_nibble(addr)
                self._apply_nibble(addr, old_val)
                self._last_diff[addr] = (cur_val, old_val)
            self._current_tick = tick
