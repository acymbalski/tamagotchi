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

# Fixed record body sizes (after tag byte)
_FIXED_SIZES = {
    REC_RAM_SNAPSHOT:     4 + 320,
    REC_ROM_WRITE:        4 + 2 + 1,
    REC_BABYSITTER_WRITE: 4 + 2 + 1 + 1,
    REC_LCD_FRAME:        4 + 50,
    REC_TICK_MARKER:      4,
    REC_BUTTON_EVENT:     4 + 1 + 1,
}

RAM_BYTES = 320  # packed bytes (640 nibbles)


class TamStream:
    """Read and query a .tamstream capture file."""

    def __init__(self, filepath):
        self.filepath = filepath
        self._file = open(filepath, "rb")
        self._parse_header()
        self._build_index()

    def _parse_header(self):
        header = self._file.read(16)
        if len(header) < 16 or header[0:4] != b"TAMS":
            raise ValueError(f"Invalid .tamstream file: {self.filepath}")
        self.version = struct.unpack_from("<H", header, 4)[0]
        self.start_tick = struct.unpack_from("<I", header, 6)[0]
        self.ram_nibbles = struct.unpack_from("<H", header, 10)[0]

    def _build_index(self):
        """Scan the file and build an index of record positions."""
        self._records_start = 16
        self._snapshot_positions = []  # (tick, file_offset) for RAM snapshots
        self._first_tick = None
        self._last_tick = None
        self._record_count = 0

        f = self._file
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
                f.seek(text_len, 1)
            elif tag in _FIXED_SIZES:
                size = _FIXED_SIZES[tag]
                data = f.read(size)
                if len(data) < size:
                    break
                tick = struct.unpack_from("<I", data, 0)[0]
            else:
                break

            if tag == REC_RAM_SNAPSHOT:
                self._snapshot_positions.append((tick, pos))

            if self._first_tick is None:
                self._first_tick = tick
            self._last_tick = tick
            self._record_count += 1

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
                data = f.read(4 + 50)
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
            elif tag in _FIXED_SIZES:
                size = _FIXED_SIZES[tag]
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
            for field in memory_config.MAP:
                addr = field.get("address")
                if addr is not None:
                    byte_idx = addr >> 1
                    if byte_idx < RAM_BYTES:
                        if (addr & 1) == 0:
                            val = (ram[byte_idx] >> 4) & 0xF
                        else:
                            val = ram[byte_idx] & 0xF
                        result[field["name"]] = val
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
        result = []
        for rec_type, tick, data in self.records():
            if rec_type == REC_ANNOTATION:
                result.append((tick, data["text"]))
        return result

    def lcd_frames(self):
        """Generator of (tick, frame_bytes) tuples."""
        for rec_type, tick, data in self.records():
            if rec_type == REC_LCD_FRAME:
                yield (tick, data["display"])

    def button_events(self):
        """Generator of (tick, button_id, state) tuples."""
        for rec_type, tick, data in self.records():
            if rec_type == REC_BUTTON_EVENT:
                yield (tick, data["button_id"], data["state"])

    def nearest_lcd_frame(self, target_tick):
        """Return LCD frame data closest to given tick."""
        best = None
        best_dist = None
        for tick, frame in self.lcd_frames():
            dist = abs(tick - target_tick)
            if best_dist is None or dist < best_dist:
                best = (tick, frame)
                best_dist = dist
            if tick > target_tick:
                break  # Past target, won't get closer
        return best

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
