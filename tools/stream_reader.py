#!/usr/bin/env python3
"""Library for reading and querying .tamstream files."""

import struct
import os
import sys
import bisect
import io
import zlib
import glob as _glob
from collections import defaultdict
from dataclasses import dataclass, field
from typing import Optional

# Compression flags
STREAM_COMPRESS_NONE = 0x00
STREAM_COMPRESS_ZLIB = 0x01

# On-disk index magic
STREAM_INDEX_MAGIC = b"TIDX"

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


@dataclass
class SegmentInfo:
    """Metadata for a single segment file. Loaded eagerly; stream data loaded lazily."""
    index: int
    filename: str
    file_index: int = 0
    version: int = 1
    start_tick: int = 0
    end_tick: int = 0
    loaded: bool = False
    stream: Optional[object] = None         # TamStream when loaded, None otherwise
    # Lightweight metadata (always available)
    snapshot_count: int = 0
    lcd_frame_count: int = 0
    annotation_records: list = field(default_factory=list)
    button_records: list = field(default_factory=list)
    tick_marker_ticks: list = field(default_factory=list)
    lcd_change_ticks: list = field(default_factory=list)
    snapshot_positions: list = field(default_factory=list)   # (tick, local_offset)
    lcd_frame_index: list = field(default_factory=list)      # (tick, local_offset)
    last_snapshot_tick: int = 0
    last_snapshot_ram: Optional[bytes] = None    # 320 bytes
    first_lcd_frame: Optional[bytes] = None      # 72 bytes
    last_lcd_frame: Optional[bytes] = None       # 72 bytes
    compressed_size: int = 0
    decompressed_size: int = 0


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
        self.compression = header[12] if self.version >= 3 else STREAM_COMPRESS_NONE
        self._raw_file = None

        if self.compression == STREAM_COMPRESS_ZLIB:
            # Read all remaining compressed data and decompress into BytesIO
            compressed_data = self._file.read()
            self._raw_file = self._file   # keep raw file handle for TIDX index
            self._file = io.BytesIO(zlib.decompress(compressed_data, -15))
            self._records_start = 0       # BytesIO starts at first record byte
        else:
            self._records_start = 16      # raw file: records start after 16-byte header

    def _try_read_ondisk_index(self):
        """Try to read TIDX on-disk index. Returns True if found and loaded."""
        try:
            raw = self._raw_file if self._raw_file else self._file
            if raw is None:
                return False
            # Read index_start from last 8 bytes of raw file
            raw.seek(-8, 2)
            idx_start_bytes = raw.read(8)
            if len(idx_start_bytes) < 8:
                return False
            index_start = struct.unpack("<Q", idx_start_bytes)[0]
            # Seek to index start and verify magic
            raw.seek(index_start)
            magic = raw.read(4)
            if magic != STREAM_INDEX_MAGIC:
                return False
            count_bytes = raw.read(4)
            if len(count_bytes) < 4:
                return False
            count = struct.unpack("<I", count_bytes)[0]
            snaps = []
            lcds = []
            for _ in range(count):
                entry_data = raw.read(13)  # tick(4) + offset(8) + type(1)
                if len(entry_data) < 13:
                    return False
                tick = struct.unpack_from("<I", entry_data, 0)[0]
                offset = struct.unpack_from("<Q", entry_data, 4)[0]
                rec_type = entry_data[12]
                # For compressed streams: offset is BytesIO position (0-based)
                # For uncompressed streams: offset is from start of records (add 16 for raw file)
                seek_pos = offset if self._raw_file else (offset + 16)
                if rec_type == REC_RAM_SNAPSHOT:
                    snaps.append((tick, seek_pos))
                elif rec_type == REC_LCD_FRAME:
                    lcds.append((tick, seek_pos))
            self._snapshot_positions = snaps
            self._lcd_frame_index = lcds
            return True
        except Exception:
            return False

    def _build_index(self, progress_callback=None):
        """Scan the file and build an index of record positions."""
        # _records_start set by _parse_header based on compression
        self._snapshot_positions = []  # (tick, seek_offset) for RAM snapshots
        self._lcd_frame_index = []     # (tick, seek_offset) for LCD frames
        self._tick_marker_ticks = []   # tick values for tick markers
        self._annotation_records = []  # (tick, text)
        self._button_records = []      # (tick, button_id, state)
        self._first_tick = None
        self._last_tick = None
        self._record_count = 0

        # Try TIDX fast path (skips linear scan for snapshots/LCD frames)
        if self._try_read_ondisk_index() and self._snapshot_positions:
            # Set tick range from the index
            if self._snapshot_positions:
                self._first_tick = self._snapshot_positions[0][0]
                self._last_tick = self._snapshot_positions[-1][0]
            if self._lcd_frame_index:
                last_lcd_tick = self._lcd_frame_index[-1][0]
                if self._last_tick is None or last_lcd_tick > self._last_tick:
                    self._last_tick = last_lcd_tick
            # Still need annotations/buttons/tick markers — do a lightweight metadata scan
            f = self._file
            f.seek(self._records_start)
            while True:
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
                    if tag == REC_TICK_MARKER:
                        self._tick_marker_ticks.append(tick)
                    elif tag == REC_BUTTON_EVENT:
                        button_id = data[4]
                        state = data[5]
                        self._button_records.append((tick, button_id, state))
                else:
                    break
            # Build LCD change index from the TIDX-loaded lcd_frame_index
            self._lcd_change_ticks = []
            prev_data = None
            for tick, offset in self._lcd_frame_index:
                frame_data = self.read_lcd_frame_at(offset)
                if prev_data is not None and frame_data != prev_data:
                    self._lcd_change_ticks.append(tick)
                prev_data = frame_data
            if progress_callback:
                progress_callback(100, f"Indexed {len(self._snapshot_positions)} snapshots (TIDX)")
            return

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

        # Build LCD change index: ticks where display actually changed
        self._lcd_change_ticks = []
        prev_data = None
        for tick, offset in self._lcd_frame_index:
            frame_data = self.read_lcd_frame_at(offset)
            if prev_data is not None and frame_data != prev_data:
                self._lcd_change_ticks.append(tick)
            prev_data = frame_data

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

    def next_lcd_change(self, current_tick):
        """Return the tick of the next LCD screen change after current_tick, or None."""
        import bisect
        idx = bisect.bisect_right(self._lcd_change_ticks, current_tick)
        if idx < len(self._lcd_change_ticks):
            return self._lcd_change_ticks[idx]
        return None

    def prev_lcd_change(self, current_tick):
        """Return the tick of the previous LCD screen change before current_tick, or None."""
        import bisect
        idx = bisect.bisect_left(self._lcd_change_ticks, current_tick)
        if idx > 0:
            return self._lcd_change_ticks[idx - 1]
        return None

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

    def read_snapshot_at(self, snap_key):
        """Read 320 bytes of RAM from a snapshot key (integer offset for TamStream)."""
        self._file.seek(snap_key + 1 + 4)  # skip tag byte + tick field
        return bytearray(self._file.read(RAM_BYTES))

    def close(self):
        if self._file:
            self._file.close()
            self._file = None
        if self._raw_file:
            self._raw_file.close()
            self._raw_file = None

    def __del__(self):
        self.close()

    def __enter__(self):
        return self

    def __exit__(self, *args):
        self.close()


class SegmentedTamStream:
    """Read a directory of segmented .tamstream files with lazy segment loading.

    On init: scans metadata for ALL segments (cheap — keeps only indices and
    small buffers), then loads only the first, last, and any bookmarked segments.
    Middle segments can be loaded/unloaded on demand via load_segment/unload_segment.

    Exposes the same interface as TamStream; CachedStateTracker works via the
    read_snapshot_at() abstraction.
    """

    def __init__(self, dirpath, progress_callback=None, bookmark_ticks=None, start_seg=None, end_seg=None):
        self.dirpath = dirpath
        self.filepath = dirpath  # viewer compatibility

        seg_files = sorted(_glob.glob(os.path.join(dirpath, "seg_*.tamstream")))

        # Filter by segment number if requested
        if start_seg is not None or end_seg is not None:
            filtered = []
            import re
            for f in seg_files:
                match = re.search(r'seg_(\d+)', os.path.basename(f))
                if match:
                    num = int(match.group(1))
                    if start_seg is not None and num < start_seg:
                        continue
                    if end_seg is not None and num > end_seg:
                        continue
                filtered.append(f)
            seg_files = filtered

        if not seg_files:
            raise ValueError(f"No segments found in: {dirpath}")

        # --- Phase 1: scan metadata for every segment ---
        self.segments: list[SegmentInfo] = []
        global_offset = 0
        prev_raw_end = None
        
        for i, path in enumerate(seg_files):
            if progress_callback:
                pct = int(i * 80 / len(seg_files))
                progress_callback(pct, f"Scanning segment {i+1}/{len(seg_files)}...")
            info = self._scan_segment_metadata(path, i)
            raw_start = info.start_tick
            raw_end   = info.end_tick

            # Inter-segment wrap: new seg starts far before previous seg ended
            if prev_raw_end is not None:
                if raw_start < prev_raw_end and (prev_raw_end - raw_start) > (1 << 31):
                    global_offset += (1 << 32)

            info.start_tick = raw_start + global_offset

            # Intra-segment wrap: segment end wrapped around within this segment
            if raw_end < raw_start and (raw_start - raw_end) > (1 << 31):
                info.end_tick = raw_end + global_offset + (1 << 32)
                global_offset += (1 << 32)   # next segment is in new epoch
                prev_raw_end = raw_end
            else:
                info.end_tick = raw_end + global_offset
                prev_raw_end = raw_end

            self.segments.append(info)

        # Sorted list of segment start ticks for binary search
        self._segment_tick_starts = [s.start_tick for s in self.segments]

        # --- Phase 2: merge metadata (always available, even for unloaded segs) ---
        self._lcd_change_ticks: list[int] = []
        self._annotation_records: list = []
        self._button_records: list = []
        self._tick_marker_ticks: list[int] = []
        # All LCD frame positions across all segments; (tick, seg_idx, local_offset)
        self._lcd_frame_index_all: list = []

        for seg in self.segments:
            seg_offset = seg.start_tick - (seg.start_tick % (1 << 32))
            
            # Map segment-local ticks to monotonic global ticks
            def _monot(t): return t + seg_offset

            self._lcd_change_ticks.extend(map(_monot, seg.lcd_change_ticks))
            self._annotation_records.extend([(t + seg_offset, txt) for t, txt in seg.annotation_records])
            self._button_records.extend([(t + seg_offset, bid, s) for t, bid, s in seg.button_records])
            self._tick_marker_ticks.extend(map(_monot, seg.tick_marker_ticks))
            for tick, offset in seg.lcd_frame_index:
                self._lcd_frame_index_all.append((tick + seg_offset, seg.index, offset))

        self._lcd_change_ticks.sort()
        self._annotation_records.sort(key=lambda x: x[0])
        self._button_records.sort(key=lambda x: x[0])
        self._tick_marker_ticks.sort()

        # Version / geometry
        version = max((s.version for s in self.segments), default=1)
        self.version = version
        self.lcd_bytes = LCD_BYTES_V2 if version >= 2 else LCD_BYTES_V1
        self._rec_sizes = _fixed_sizes(self.lcd_bytes)
        self.ram_nibbles = 0x280
        self.compression = STREAM_COMPRESS_NONE
        self._raw_file = None

        # Snapshot / LCD index from LOADED segments only; populated by load_segment()
        # Entries are (tick, (seg_idx, local_offset)) tuples
        self._snapshot_positions: list = []
        self._lcd_frame_index: list = []

        # --- Phase 3: load first, last, and any bookmarked segments ---
        if progress_callback:
            progress_callback(85, "Loading first segment...")
        self.load_segment(0)
        if len(self.segments) > 1:
            if progress_callback:
                progress_callback(90, "Loading last segment...")
            self.load_segment(len(self.segments) - 1)

        if bookmark_ticks:
            for tick in bookmark_ticks:
                idx = self.segment_for_tick(tick)
                if idx is not None and not self.segments[idx].loaded:
                    self.load_segment(idx)

        if progress_callback:
            n = sum(1 for s in self.segments if s.loaded)
            progress_callback(100, f"Ready — {len(self.segments)} segments ({n} loaded)")

        if progress_callback:
            n = sum(1 for s in self.segments if s.loaded)
            progress_callback(100, f"Ready — {len(self.segments)} segments ({n} loaded)")

    # ------------------------------------------------------------------
    # Metadata scan: fast TIDX-based path (no decompression for compressed segments)
    # ------------------------------------------------------------------

    @staticmethod
    def _read_tidx_fast(raw_file):
        """Read TIDX index from the raw (possibly compressed) file without decompressing.
        Returns (snapshot_positions, lcd_frame_positions) as [(tick, offset)] each.
        The offsets are BytesIO positions in the decompressed data — valid for seeking
        once the segment is loaded via TamStream.
        """
        try:
            raw_file.seek(-8, 2)
            idx_start_bytes = raw_file.read(8)
            if len(idx_start_bytes) < 8:
                return [], []
            index_start = struct.unpack('<Q', idx_start_bytes)[0]
            raw_file.seek(index_start)
            magic = raw_file.read(4)
            if magic != STREAM_INDEX_MAGIC:
                return [], []
            count = struct.unpack('<I', raw_file.read(4))[0]
            snaps, lcds = [], []
            for _ in range(count):
                entry = raw_file.read(13)
                if len(entry) < 13:
                    break
                tick = struct.unpack_from('<I', entry, 0)[0]
                offset = struct.unpack_from('<Q', entry, 4)[0]
                rec_type = entry[12]
                if rec_type == REC_RAM_SNAPSHOT:
                    snaps.append((tick, offset))
                elif rec_type == REC_LCD_FRAME:
                    lcds.append((tick, offset))
            return snaps, lcds
        except Exception:
            return [], []

    def _scan_segment_metadata(self, path: str, index: int) -> SegmentInfo:
        """Fast metadata scan.  For compressed segments reads only the TIDX header
        (no decompression). Annotations, buttons, and lcd_change_ticks are populated
        lazily when the segment is fully loaded via load_segment().
        """
        import re
        match = re.search(r'seg_(\d+)', os.path.basename(path))
        file_index = int(match.group(1)) if match else index
        
        info = SegmentInfo(index=index, filename=path, file_index=file_index)
        info.compressed_size = os.path.getsize(path)

        with open(path, 'rb') as f:
            header = f.read(16)
            if len(header) < 16 or header[0:4] != b'TAMS':
                raise ValueError(f'Invalid tamstream: {path}')
            version = struct.unpack_from('<H', header, 4)[0]
            info.version = version
            compression = header[12] if version >= 3 else STREAM_COMPRESS_NONE

            if compression == STREAM_COMPRESS_ZLIB:
                # Fast path: TIDX lives at the end of the raw file — readable without decompressing
                snaps, lcds = SegmentedTamStream._read_tidx_fast(f)
                info.snapshot_positions = snaps
                info.lcd_frame_index = lcds
                info.snapshot_count = len(snaps)
                info.lcd_frame_count = len(lcds)
                if snaps:
                    info.start_tick = snaps[0][0]
                    info.end_tick = snaps[-1][0]
                elif lcds:
                    info.start_tick = lcds[0][0]
                    info.end_tick = lcds[-1][0]
                # Rough decompressed-size estimate (actual set when fully loaded)
                info.decompressed_size = info.compressed_size * 4
                # annotations / buttons / tick_markers / lcd_change_ticks: populated on load
            else:
                # Uncompressed: use full TamStream scan
                seg = TamStream(path)
                info.version = seg.version
                info.snapshot_positions = list(seg._snapshot_positions)
                info.lcd_frame_index = list(seg._lcd_frame_index)
                info.snapshot_count = len(seg._snapshot_positions)
                info.lcd_frame_count = len(seg._lcd_frame_index)
                info.start_tick = seg._first_tick or 0
                info.end_tick = seg._last_tick or 0
                info.annotation_records = list(seg._annotation_records)
                info.button_records = list(seg._button_records)
                info.tick_marker_ticks = list(seg._tick_marker_ticks)
                info.lcd_change_ticks = list(seg._lcd_change_ticks)
                info.decompressed_size = info.compressed_size
                seg.close()

        return info

    def _raw_to_ext_ticks(self, seg, raw_ticks):
        """Convert a list of raw (monotone-within-segment) ticks to extended ticks.

        Uses seg.start_tick (already extended after Bug-1 fix) to derive the epoch
        base, then detects any intra-segment wrap via a large backward jump.
        """
        epoch_base = seg.start_tick - (seg.start_tick % (1 << 32))
        extra = 0
        prev_raw = None
        result = []
        for raw_tick in raw_ticks:
            if prev_raw is not None and raw_tick < prev_raw - (1 << 31):
                extra += (1 << 32)
            prev_raw = raw_tick
            result.append(epoch_base + extra + raw_tick)
        return result

    # ------------------------------------------------------------------
    # Segment load / unload
    # ------------------------------------------------------------------

    def load_segment(self, index: int, progress_callback=None):
        """Fully load a segment: open its TamStream, merge indices and metadata."""
        seg = self.segments[index]
        if seg.loaded:
            return
        seg.stream = TamStream(seg.filename, progress_callback)
        seg.loaded = True

        # Update decompressed size from actual BytesIO
        if hasattr(seg.stream._file, 'getbuffer'):
            seg.decompressed_size = len(seg.stream._file.getbuffer())

        # Use positions from the loaded TamStream (authoritative) — should match TIDX
        seg.snapshot_positions = list(seg.stream._snapshot_positions)
        seg.lcd_frame_index = list(seg.stream._lcd_frame_index)
        seg.snapshot_count = len(seg.snapshot_positions)
        seg.lcd_frame_count = len(seg.lcd_frame_index)

        # Populate metadata lists from the loaded stream — convert raw ticks to extended
        raw_anns  = list(seg.stream._annotation_records)   # [(raw_tick, text), ...]
        raw_btns  = list(seg.stream._button_records)        # [(raw_tick, bid, state), ...]
        raw_ticks = list(seg.stream._tick_marker_ticks)     # [raw_tick, ...]
        raw_lcdc  = list(seg.stream._lcd_change_ticks)      # [raw_tick, ...]

        ext_ticks = self._raw_to_ext_ticks(seg, raw_ticks)
        ext_lcdc  = self._raw_to_ext_ticks(seg, raw_lcdc)
        ext_anns  = [(et, txt) for et, (_, txt) in
                     zip(self._raw_to_ext_ticks(seg, [t for t, _ in raw_anns]), raw_anns)]
        ext_btns  = [(et, bid, s) for et, (_, bid, s) in
                     zip(self._raw_to_ext_ticks(seg, [t for t, _, _ in raw_btns]), raw_btns)]

        # Merge into global sorted lists (only records not already present)
        if ext_ticks and not seg.tick_marker_ticks:
            seg.tick_marker_ticks = ext_ticks
            for t in ext_ticks:
                bisect.insort(self._tick_marker_ticks, t)
        if ext_lcdc and not seg.lcd_change_ticks:
            seg.lcd_change_ticks = ext_lcdc
            for t in ext_lcdc:
                bisect.insort(self._lcd_change_ticks, t)
        if ext_anns and not seg.annotation_records:
            seg.annotation_records = ext_anns
            for item in ext_anns:
                bisect.insort(self._annotation_records, item)
        if ext_btns and not seg.button_records:
            seg.button_records = ext_btns
            for item in ext_btns:
                bisect.insort(self._button_records, item)

        # Insert into shared snapshot / LCD indices with extended ticks
        ext_snap_ticks = self._raw_to_ext_ticks(seg, [t for t, _ in seg.snapshot_positions])
        for ext_tick, (_, offset) in zip(ext_snap_ticks, seg.snapshot_positions):
            bisect.insort(self._snapshot_positions, (ext_tick, (index, offset)))
        ext_lcd_ticks = self._raw_to_ext_ticks(seg, [t for t, _ in seg.lcd_frame_index])
        for ext_tick, (_, offset) in zip(ext_lcd_ticks, seg.lcd_frame_index):
            bisect.insort(self._lcd_frame_index, (ext_tick, (index, offset)))

    def unload_segment(self, index: int):
        """Unload a segment, freeing its decompressed data; keep metadata."""
        seg = self.segments[index]
        if not seg.loaded:
            return

        # Remove from shared snapshot/LCD indices
        self._snapshot_positions = [(t, k) for t, k in self._snapshot_positions if k[0] != index]
        self._lcd_frame_index = [(t, k) for t, k in self._lcd_frame_index if k[0] != index]

        # Remove from merged metadata lists
        if seg.annotation_records:
            ann_set = {(t, tx) for t, tx in seg.annotation_records}
            self._annotation_records = [x for x in self._annotation_records if (x[0], x[1]) not in ann_set]
            seg.annotation_records = []
        if seg.button_records:
            btn_set = set(map(tuple, seg.button_records))
            self._button_records = [x for x in self._button_records if tuple(x) not in btn_set]
            seg.button_records = []
        if seg.tick_marker_ticks:
            tick_set = set(seg.tick_marker_ticks)
            self._tick_marker_ticks = [t for t in self._tick_marker_ticks if t not in tick_set]
            seg.tick_marker_ticks = []
        if seg.lcd_change_ticks:
            lc_set = set(seg.lcd_change_ticks)
            self._lcd_change_ticks = [t for t in self._lcd_change_ticks if t not in lc_set]
            seg.lcd_change_ticks = []

        if seg.stream:
            seg.stream.close()
            seg.stream = None
        seg.loaded = False

    def is_segment_loaded(self, index: int) -> bool:
        return self.segments[index].loaded

    @property
    def loaded_segment_count(self) -> int:
        return sum(1 for s in self.segments if s.loaded)

    @property
    def estimated_memory_bytes(self) -> int:
        return sum(s.decompressed_size for s in self.segments if s.loaded)

    def segment_for_tick(self, tick: int) -> Optional[int]:
        """Return the segment index whose range contains tick, or nearest.

        Extended ticks are monotonically increasing after Bug-1 fix, so a simple
        range check and absolute-distance fallback are sufficient.
        """
        if not self.segments:
            return None
        for i, seg in enumerate(self.segments):
            if seg.start_tick <= tick <= seg.end_tick:
                return i
        # Fallback: nearest segment midpoint by absolute distance
        best_idx, best_dist = 0, None
        for i, seg in enumerate(self.segments):
            mid = (seg.start_tick + seg.end_tick) // 2
            d = abs(tick - mid)
            if best_dist is None or d < best_dist:
                best_dist, best_idx = d, i
        return best_idx

    # ------------------------------------------------------------------
    # Interface expected by TamStream callers
    # ------------------------------------------------------------------

    @property
    def tick_range(self):
        if not self.segments:
            return (None, None)
        return (self.segments[0].start_tick, self.segments[-1].end_tick)

    @property
    def _first_tick(self):
        return self.segments[0].start_tick if self.segments else None

    @property
    def _last_tick(self):
        return self.segments[-1].end_tick if self.segments else None

    def read_snapshot_at(self, snap_key) -> bytearray:
        """Read 320 bytes of RAM from snap_key = (seg_idx, local_offset).
        Falls back to last_snapshot_ram metadata if segment is unloaded.
        """
        seg_idx, local_offset = snap_key
        seg = self.segments[seg_idx]
        if seg.loaded and seg.stream:
            return seg.stream.read_snapshot_at(local_offset)
        # Fallback: use metadata snapshot (last in this segment)
        if seg.last_snapshot_ram:
            return bytearray(seg.last_snapshot_ram)
        return bytearray(RAM_BYTES)

    def records(self):
        """Yield records from loaded segments in ascending tick order."""
        loaded = sorted(
            ((s.start_tick, i, s) for i, s in enumerate(self.segments) if s.loaded),
            key=lambda x: x[0],
        )
        for _, _, seg in loaded:
            yield from seg.stream.records()

    def state_at_tick(self, target_tick: int) -> bytes:
        """Reconstruct RAM at tick. Delegates to loaded segment, or uses metadata."""
        seg_idx = self.segment_for_tick(target_tick)
        if seg_idx is not None:
            seg = self.segments[seg_idx]
            if seg.loaded and seg.stream:
                return seg.stream.state_at_tick(target_tick)
            # Fallback: nearest loaded segment's last snapshot RAM
            if seg.last_snapshot_ram:
                return bytes(seg.last_snapshot_ram)
        return bytes(RAM_BYTES)

    def stats_at_tick(self, target_tick: int) -> dict:
        ram = self.state_at_tick(target_tick)
        try:
            import memory_config
            result = {}
            for name in memory_config.MAP:
                val = memory_config.get_value(ram, name)
                if val is not None:
                    result[name] = val
            return result
        except ImportError:
            return {"error": "memory_config.py not found"}

    def nearest_lcd_frame(self, target_tick: int, seg_idx: int = None):
        """Return (tick, frame_bytes) closest to target, or None if unloaded.

        target_tick is an extended (monotone) tick. If seg_idx is given,
        restricts the search to that segment. Otherwise performs a linear search
        over all loaded segments using absolute extended-tick distance.
        """
        raw_target = target_tick & 0xFFFFFFFF  # strip epoch for inner TamStream lookup

        if seg_idx is not None:
            seg = self.segments[seg_idx]
            if not seg.loaded or not seg.stream:
                return None
            return seg.stream.nearest_lcd_frame(raw_target)

        # Linear search over loaded segments using extended-tick distance
        best_dist, best_result = None, None
        for seg in self.segments:
            if not seg.loaded or not seg.stream:
                continue
            frame = seg.stream.nearest_lcd_frame(raw_target)
            if frame is None:
                continue
            # Convert raw frame tick back to extended for distance comparison
            seg_epoch = seg.start_tick - (seg.start_tick % (1 << 32))
            ext_frame_tick = seg_epoch + frame[0]
            d = abs(ext_frame_tick - target_tick)
            if best_dist is None or d < best_dist:
                best_dist, best_result = d, frame
        return best_result

    def read_lcd_frame_at(self, key):
        """Read LCD frame from key = (seg_idx, local_offset)."""
        if isinstance(key, tuple):
            seg_idx, local_offset = key
            seg = self.segments[seg_idx]
            if seg.loaded and seg.stream:
                return seg.stream.read_lcd_frame_at(local_offset)
        return None

    def next_lcd_change(self, current_tick: int):
        idx = bisect.bisect_right(self._lcd_change_ticks, current_tick)
        return self._lcd_change_ticks[idx] if idx < len(self._lcd_change_ticks) else None

    def prev_lcd_change(self, current_tick: int):
        idx = bisect.bisect_left(self._lcd_change_ticks, current_tick)
        return self._lcd_change_ticks[idx - 1] if idx > 0 else None

    def annotations(self):
        return list(self._annotation_records)

    def button_events(self):
        return list(self._button_records)

    def writes_in_range(self, start_tick, end_tick, addr=None, source=None):
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

    def lcd_frames(self):
        for rec_type, tick, data in self.records():
            if rec_type == REC_LCD_FRAME:
                yield (tick, data["display"])

    def close(self):
        for seg in self.segments:
            if seg.stream:
                seg.stream.close()
                seg.stream = None
                seg.loaded = False

    def __del__(self):
        self.close()

    def __enter__(self):
        return self

    def __exit__(self, *args):
        self.close()


def open_stream(path, progress_callback=None, bookmark_ticks=None, start_seg=None, end_seg=None):
    """Open a .tamstream file or a segment directory.

    Returns a TamStream for single files, SegmentedTamStream for directories.
    bookmark_ticks: optional list of tick values whose segments should be pre-loaded.
    """
    if os.path.isdir(path):
        return SegmentedTamStream(path, progress_callback=progress_callback,
                                  bookmark_ticks=bookmark_ticks,
                                  start_seg=start_seg, end_seg=end_seg)
    return TamStream(path, progress_callback=progress_callback)


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
        self._segment_write_ranges: dict = {}  # seg_idx -> (start, end) in _writes
        self._build_write_index(progress_callback)

    @staticmethod
    def _apply_write_to_ram(running_ram, addr, new_val):
        """Apply nibble write to running_ram, return (old_val, updated_ram)."""
        byte_idx = addr >> 1
        if byte_idx >= RAM_BYTES:
            return None, running_ram
        if (addr & 1) == 0:
            old_val = (running_ram[byte_idx] & 0xF0) >> 4
            running_ram[byte_idx] = (running_ram[byte_idx] & 0x0F) | (new_val << 4)
        else:
            old_val = running_ram[byte_idx] & 0x0F
            running_ram[byte_idx] = (running_ram[byte_idx] & 0xF0) | (new_val & 0x0F)
        return old_val, running_ram

    def _build_write_index(self, progress_callback=None):
        """Scan records and build indexed write list with old values.

        For SegmentedTamStream: only loaded segments are processed; also records
        which _writes indices belong to each segment in _segment_write_ranges.
        """
        if not self._stream._snapshot_positions:
            return

        snap_tick, snap_key = self._stream._snapshot_positions[0]
        running_ram = self._stream.read_snapshot_at(snap_key)

        writes = []
        self._segment_write_ranges = {}
        count = 0

        is_segmented = hasattr(self._stream, 'segments')
        if is_segmented:
            for seg in self._stream.segments:
                if not seg.loaded or not seg.stream:
                    continue
                seg_write_start = len(writes)
                epoch_base = seg.start_tick - (seg.start_tick % (1 << 32))
                extra = 0
                prev_raw = None
                for rec_type, tick, data in seg.stream.records():
                    # Convert raw tick to extended
                    if prev_raw is not None and tick < prev_raw - (1 << 31):
                        extra += (1 << 32)
                    prev_raw = tick
                    ext_tick = epoch_base + extra + tick
                    if rec_type in (REC_ROM_WRITE, REC_BABYSITTER_WRITE):
                        addr = data["addr"]
                        new_val = data["value"]
                        if addr < 640:
                            old_val, running_ram = self._apply_write_to_ram(running_ram, addr, new_val)
                            if old_val is not None:
                                source = 0 if rec_type == REC_ROM_WRITE else 1
                                func_id = data.get("func_id", 0)
                                writes.append((ext_tick, addr, new_val, old_val, source, func_id))
                    elif rec_type == REC_RAM_SNAPSHOT:
                        running_ram = bytearray(data["memory"])
                    count += 1
                    if progress_callback and count % 200000 == 0:
                        progress_callback(None, f"Building write index... {len(writes):,} writes")
                self._segment_write_ranges[seg.index] = (seg_write_start, len(writes))
        else:
            for rec_type, tick, data in self._stream.records():
                if rec_type in (REC_ROM_WRITE, REC_BABYSITTER_WRITE):
                    addr = data["addr"]
                    new_val = data["value"]
                    if addr < 640:
                        old_val, running_ram = self._apply_write_to_ram(running_ram, addr, new_val)
                        if old_val is not None:
                            source = 0 if rec_type == REC_ROM_WRITE else 1
                            func_id = data.get("func_id", 0)
                            writes.append((tick, addr, new_val, old_val, source, func_id))
                elif rec_type == REC_RAM_SNAPSHOT:
                    running_ram = bytearray(data["memory"])
                count += 1
                if progress_callback and count % 200000 == 0:
                    progress_callback(None, f"Building write index... {len(writes):,} writes")

        self._writes = writes
        self._write_ticks = [w[0] for w in writes]
        self._addr_write_indices: dict[int, list[int]] = defaultdict(list)
        for i, (tick, addr, new_val, old_val, source, func_id) in enumerate(writes):
            self._addr_write_indices[addr].append(i)
        if progress_callback:
            progress_callback(None, f"Write index complete: {len(writes):,} writes")

    def _rebuild_indices(self):
        """Rebuild _write_ticks and _addr_write_indices from _writes."""
        self._write_ticks = [w[0] for w in self._writes]
        self._addr_write_indices = defaultdict(list)
        for i, (tick, addr, *_rest) in enumerate(self._writes):
            self._addr_write_indices[addr].append(i)

    def add_segment_writes(self, segment_index: int, progress_callback=None):
        """Build and insert writes from a newly-loaded segment into the index."""
        stream = self._stream
        seg = stream.segments[segment_index]
        if not seg.loaded or not seg.stream:
            return
        if segment_index in self._segment_write_ranges:
            return  # already indexed

        # Find the nearest prior loaded snapshot to seed running_ram
        seg_start = seg.start_tick
        running_ram = bytearray(RAM_BYTES)
        best_snap_tick = -1
        for snap_tick, snap_key in self._stream._snapshot_positions:
            if snap_tick <= seg_start:
                best_snap_tick = snap_tick
                running_ram = self._stream.read_snapshot_at(snap_key)
            else:
                break

        # Apply existing loaded writes from best_snap_tick up to seg_start
        if best_snap_tick >= 0:
            start_idx = bisect.bisect_left(self._write_ticks, best_snap_tick)
            for i in range(start_idx, len(self._writes)):
                w_tick = self._writes[i][0]
                if w_tick >= seg_start:
                    break
                _, addr, new_val, *_ = self._writes[i]
                _, running_ram = self._apply_write_to_ram(running_ram, addr, new_val)

        # Process this segment's records — convert raw ticks to extended
        new_writes = []
        epoch_base = seg.start_tick - (seg.start_tick % (1 << 32))
        extra = 0
        prev_raw = None
        for rec_type, tick, data in seg.stream.records():
            if prev_raw is not None and tick < prev_raw - (1 << 31):
                extra += (1 << 32)
            prev_raw = tick
            ext_tick = epoch_base + extra + tick
            if rec_type in (REC_ROM_WRITE, REC_BABYSITTER_WRITE):
                addr = data["addr"]
                new_val = data["value"]
                if addr < 640:
                    old_val, running_ram = self._apply_write_to_ram(running_ram, addr, new_val)
                    if old_val is not None:
                        source = 0 if rec_type == REC_ROM_WRITE else 1
                        func_id = data.get("func_id", 0)
                        new_writes.append((ext_tick, addr, new_val, old_val, source, func_id))
            elif rec_type == REC_RAM_SNAPSHOT:
                running_ram = bytearray(data["memory"])

        if not new_writes:
            self._segment_write_ranges[segment_index] = (len(self._writes), len(self._writes))
            return

        # Find insertion point (new_writes[0][0] is the first tick of this segment)
        insert_pos = bisect.bisect_left(self._write_ticks, new_writes[0][0])
        self._writes = self._writes[:insert_pos] + new_writes + self._writes[insert_pos:]
        n = len(new_writes)

        # Shift any existing segment range entries that come after insert_pos
        for idx, (s, e) in list(self._segment_write_ranges.items()):
            if s >= insert_pos:
                self._segment_write_ranges[idx] = (s + n, e + n)
        self._segment_write_ranges[segment_index] = (insert_pos, insert_pos + n)

        # Adjust write cursor
        if self._write_cursor >= insert_pos:
            self._write_cursor += n

        self._rebuild_indices()

    def remove_segment_writes(self, segment_index: int):
        """Remove writes belonging to an unloaded segment from the index."""
        if segment_index not in self._segment_write_ranges:
            return
        start_idx, end_idx = self._segment_write_ranges[segment_index]
        n = end_idx - start_idx
        if n > 0:
            del self._writes[start_idx:end_idx]
        del self._segment_write_ranges[segment_index]

        # Adjust other segment ranges
        for idx, (s, e) in list(self._segment_write_ranges.items()):
            if s >= end_idx:
                self._segment_write_ranges[idx] = (s - n, e - n)

        # Adjust write cursor
        if self._write_cursor >= end_idx:
            self._write_cursor -= n
        elif self._write_cursor > start_idx:
            self._write_cursor = start_idx

        self._rebuild_indices()

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

    @property
    def current_segment_idx(self) -> Optional[int]:
        """Return the segment index at the current write-cursor position.

        Uses _segment_write_ranges (populated when the stream is segmented and
        CachedStateTracker was built from it).  Returns None for single-file
        streams or when the mapping hasn't been built yet.
        """
        if not self._segment_write_ranges:
            return None
        cursor = self._write_cursor
        for seg_idx, (start, end) in self._segment_write_ranges.items():
            if start <= cursor < end:
                return seg_idx
        # Cursor before first segment or after last — return boundary
        if cursor == 0 and self._segment_write_ranges:
            return min(self._segment_write_ranges.keys())
        if self._segment_write_ranges:
            return max(self._segment_write_ranges.keys())
        return None

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

        # Load snapshot RAM via abstraction (handles both TamStream and SegmentedTamStream)
        self._ram = self._stream.read_snapshot_at(best_snap[1])

        snap_tick = best_snap[0]
        # Find start position in writes list
        start_idx = bisect.bisect_left(self._write_ticks, snap_tick)

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

    def next_write_to_addrs(self, addrs):
        """Return tick of next write to any addr in the set, after current cursor."""
        if not addrs:
            return None
        best_tick = None
        for addr in addrs:
            indices = self._addr_write_indices.get(addr)
            if not indices:
                continue
            # Find first index > current cursor
            pos = bisect.bisect_right(indices, self._write_cursor - 1)
            # Skip entries at or before cursor
            while pos < len(indices) and indices[pos] < self._write_cursor:
                pos += 1
            if pos < len(indices):
                tick = self._writes[indices[pos]][0]
                if best_tick is None or tick < best_tick:
                    best_tick = tick
        return best_tick

    def prev_write_to_addrs(self, addrs):
        """Return tick of prev write to any addr in the set, before current cursor."""
        if not addrs:
            return None
        best_tick = None
        for addr in addrs:
            indices = self._addr_write_indices.get(addr)
            if not indices:
                continue
            # Find last index < current cursor
            pos = bisect.bisect_left(indices, self._write_cursor) - 1
            if pos >= 0:
                tick = self._writes[indices[pos]][0]
                if best_tick is None or tick > best_tick:
                    best_tick = tick
        return best_tick
