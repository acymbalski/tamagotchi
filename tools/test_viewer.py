#!/usr/bin/env python3
"""Tests for the stream viewer data layer and supporting modules."""

import sys
import os
import io
import struct
import tempfile
import json

import pytest

# Set up import paths
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from stream_reader import (
    TamStream, REC_RAM_SNAPSHOT, REC_ROM_WRITE, REC_BABYSITTER_WRITE,
    REC_LCD_FRAME, REC_ANNOTATION, REC_TICK_MARKER, REC_BUTTON_EVENT, RAM_BYTES,
)
from test_helpers import make_tamstream_bytes
import memory_config

# We need a QApplication for any PyQt6 widget tests
_app = None
def _ensure_qapp():
    global _app
    if _app is None:
        from PyQt6.QtWidgets import QApplication
        _app = QApplication.instance()
        if _app is None:
            _app = QApplication([])
    return _app

from stream_viewer import ADDR_COLOR_MAP

# Path to real capture file (tests skip if absent)
_STREAM_CANDIDATES = [
    os.path.join(os.path.dirname(__file__), "..", "captures", "streams", "stream_149663569.tamstream"),
    os.path.join(os.path.dirname(__file__), "..", "captures", "stream_149663569.tamstream"),
]
STREAM_FILE = None
for _p in _STREAM_CANDIDATES:
    if os.path.exists(_p):
        STREAM_FILE = _p
        break

has_real_capture = pytest.mark.skipif(STREAM_FILE is None, reason="No real .tamstream capture found")


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _write_tamstream_to_file(data_bytes, tmp_path, name="test.tamstream"):
    """Write tamstream bytes to a temp file and return the path."""
    fpath = os.path.join(str(tmp_path), name)
    with open(fpath, "wb") as f:
        f.write(data_bytes)
    return fpath


def _make_snapshot_memory(nibble_values=None):
    """Create a 320-byte RAM with specific nibble values set.

    nibble_values: {addr: value} dict where addr is nibble address (0-639).
    """
    ram = bytearray(RAM_BYTES)
    if nibble_values:
        for addr, val in nibble_values.items():
            byte_idx = addr >> 1
            if byte_idx < RAM_BYTES:
                if (addr & 1) == 0:
                    ram[byte_idx] = (ram[byte_idx] & 0x0F) | ((val & 0xF) << 4)
                else:
                    ram[byte_idx] = (ram[byte_idx] & 0xF0) | (val & 0xF)
    return bytes(ram)


# ===========================================================================
# TestMemoryConfig
# ===========================================================================

class TestMemoryConfig:
    """Validates memory_config.py decode functions."""

    def test_decode_nibble_even_address(self):
        """Even address (0x040) reads upper nibble of byte 0x20."""
        mem = bytearray(320)
        mem[0x20] = 0xA5  # upper=0xA, lower=0x5
        assert memory_config.decode_nibble(mem, 0x040) == 0xA

    def test_decode_nibble_odd_address(self):
        """Odd address (0x041) reads lower nibble of byte 0x20."""
        mem = bytearray(320)
        mem[0x20] = 0xA5
        assert memory_config.decode_nibble(mem, 0x041) == 0x5

    def test_level_scaling(self):
        """Level type: 0-3->0, 4-7->1, 8-11->2, 12-14->3, 15->4."""
        mem = bytearray(320)
        # hunger is at 0x040 (even nibble of byte 0x20)
        expected = {0: 0, 3: 0, 4: 1, 7: 1, 8: 2, 11: 2, 12: 3, 14: 3, 15: 4}
        for nibble_val, expected_level in expected.items():
            mem[0x20] = (nibble_val << 4) | (mem[0x20] & 0x0F)
            result = memory_config.get_value(mem, "hunger")
            assert result == expected_level, f"nibble={nibble_val}: expected {expected_level}, got {result}"

    def test_bcd_decode(self):
        """BCD: addr=ones, addr+1=tens. E.g. nibble 0x054=3, 0x055=2 -> 23."""
        mem = bytearray(320)
        # age at 0x054 (ones) and 0x055 (tens)
        # 0x054 is even nibble of byte 0x2A, 0x055 is odd nibble of byte 0x2A
        mem[0x2A] = 0x32  # upper=3 (ones), lower=2 (tens)
        result = memory_config.get_value(mem, "age")
        assert result == 23

    def test_stage_logic(self):
        """Stage logic: 0->Egg, 1->Baby, 2->Child, 4->Teen, 9->Adult."""
        mem = bytearray(320)
        # lifecycle at 0x05D = odd nibble of byte 0x2E
        cases = {0: "Egg", 1: "Baby", 2: "Child", 4: "Teen", 9: "Adult"}
        for nibble_val, expected_name in cases.items():
            mem[0x2E] = (mem[0x2E] & 0xF0) | nibble_val
            result = memory_config.get_value(mem, "lifecycle")
            assert result == expected_name, f"val={nibble_val}: expected {expected_name}, got {result}"

    def test_sleep_logic(self):
        """Sleep: values 8-15 -> True, 0-7 -> False."""
        mem = bytearray(320)
        # sleeping at 0x04A = even nibble of byte 0x25
        for val in range(16):
            mem[0x25] = (val << 4) | (mem[0x25] & 0x0F)
            result = memory_config.get_value(mem, "sleeping")
            expected = val >= 8
            assert result == expected, f"val={val}: expected {expected}, got {result}"

    def test_none_address_returns_none(self):
        """Fields with addr=None (undiscovered) return None."""
        mem = bytearray(320)
        assert memory_config.get_value(mem, "life_stage") is None
        assert memory_config.get_value(mem, "char_id") is None
        assert memory_config.get_value(mem, "care_mistakes") is None

    def test_bool_type(self):
        """Bool type: 0 -> False, nonzero -> True."""
        mem = bytearray(320)
        # attention at 0x02D = odd nibble of byte 0x16
        mem[0x16] = (mem[0x16] & 0xF0) | 0
        assert memory_config.get_value(mem, "attention") is False
        mem[0x16] = (mem[0x16] & 0xF0) | 1
        assert memory_config.get_value(mem, "attention") is True


# ===========================================================================
# TestTamStream (real capture)
# ===========================================================================

class TestTamStream:
    """Tests using the real 47MB capture file."""

    @has_real_capture
    def test_header_parse(self):
        """Header: magic=TAMS, version=1, ram_nibbles=640."""
        ts = TamStream(STREAM_FILE)
        assert ts.version == 1
        assert ts.ram_nibbles == 640
        ts.close()

    @has_real_capture
    def test_tick_range(self):
        """tick_range returns (first_tick, last_tick), both non-None."""
        ts = TamStream(STREAM_FILE)
        first, last = ts.tick_range
        assert first is not None
        assert last is not None
        assert last > first
        ts.close()

    @has_real_capture
    def test_state_at_tick_returns_320_bytes(self):
        """state_at_tick() returns exactly 320 bytes."""
        ts = TamStream(STREAM_FILE)
        first, _ = ts.tick_range
        state = ts.state_at_tick(first)
        assert len(state) == 320
        ts.close()

    @has_real_capture
    def test_state_at_first_snapshot_matches_snapshot(self):
        """RAM at snapshot tick must exactly match the snapshot data."""
        ts = TamStream(STREAM_FILE)
        # First snapshot
        snap_tick, snap_pos = ts._snapshot_positions[0]
        # Read snapshot memory directly
        ts._file.seek(snap_pos + 1 + 4)  # skip tag + tick
        snap_mem = ts._file.read(RAM_BYTES)
        # Reconstruct via state_at_tick
        reconstructed = ts.state_at_tick(snap_tick)
        assert reconstructed == snap_mem
        ts.close()

    @has_real_capture
    def test_stats_at_tick_has_known_fields(self):
        """stats_at_tick() includes hunger, happy, discipline, etc."""
        ts = TamStream(STREAM_FILE)
        first, _ = ts.tick_range
        stats = ts.stats_at_tick(first)
        for field in ["hunger", "happy", "discipline"]:
            assert field in stats, f"Missing field: {field}"
        ts.close()

    @has_real_capture
    def test_writes_in_range_filters_correctly(self):
        """writes_in_range with addr filter only returns that address."""
        ts = TamStream(STREAM_FILE)
        first, last = ts.tick_range
        # Check first 100k ticks for any writes to addr 0x040
        end = first + 100000
        writes = list(ts.writes_in_range(first, end, addr=0x040))
        for _, _, data in writes:
            assert data["addr"] == 0x040
        ts.close()

    @has_real_capture
    def test_records_generator_yields_all_types(self):
        """records() should yield at least ROM writes and tick markers."""
        ts = TamStream(STREAM_FILE)
        seen_types = set()
        for rec_type, tick, data in ts.records():
            seen_types.add(rec_type)
            if len(seen_types) >= 4:
                break
        assert REC_ROM_WRITE in seen_types or REC_BABYSITTER_WRITE in seen_types
        assert REC_TICK_MARKER in seen_types
        ts.close()


# ===========================================================================
# TestStreamSynthetic
# ===========================================================================

class TestStreamSynthetic:
    """Tests with synthetic in-memory .tamstream files."""

    def test_empty_stream(self, tmp_path):
        """Stream with only header + 1 snapshot, no writes."""
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": bytes(RAM_BYTES)},
        ])
        fpath = _write_tamstream_to_file(data, tmp_path)
        ts = TamStream(fpath)
        assert ts.tick_range == (1000, 1000)
        state = ts.state_at_tick(1000)
        assert state == bytes(RAM_BYTES)
        ts.close()

    def test_single_write_changes_state(self, tmp_path):
        """Write to addr 0x040 value 0xA, verify state_at_tick reflects it."""
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": bytes(RAM_BYTES)},
            {"type": REC_ROM_WRITE, "tick": 1001, "addr": 0x040, "value": 0xA},
        ])
        fpath = _write_tamstream_to_file(data, tmp_path)
        ts = TamStream(fpath)

        # Before write
        state = ts.state_at_tick(1000)
        assert memory_config.decode_nibble(state, 0x040) == 0

        # After write
        state = ts.state_at_tick(1001)
        assert memory_config.decode_nibble(state, 0x040) == 0xA
        ts.close()

    def test_multiple_writes_same_address(self, tmp_path):
        """Last write wins at a given tick."""
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": bytes(RAM_BYTES)},
            {"type": REC_ROM_WRITE, "tick": 1001, "addr": 0x040, "value": 0x3},
            {"type": REC_ROM_WRITE, "tick": 1001, "addr": 0x040, "value": 0x7},
            {"type": REC_ROM_WRITE, "tick": 1002, "addr": 0x040, "value": 0xF},
        ])
        fpath = _write_tamstream_to_file(data, tmp_path)
        ts = TamStream(fpath)

        state = ts.state_at_tick(1001)
        assert memory_config.decode_nibble(state, 0x040) == 0x7

        state = ts.state_at_tick(1002)
        assert memory_config.decode_nibble(state, 0x040) == 0xF
        ts.close()

    def test_state_reconstruction_across_snapshots(self, tmp_path):
        """Writes spanning two snapshots reconstruct correctly."""
        snap1_mem = _make_snapshot_memory({0x040: 0x1})
        snap2_mem = _make_snapshot_memory({0x040: 0x5, 0x041: 0x3})

        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": snap1_mem},
            {"type": REC_ROM_WRITE, "tick": 1500, "addr": 0x041, "value": 0x2},
            {"type": REC_RAM_SNAPSHOT, "tick": 2000, "memory": snap2_mem},
            {"type": REC_ROM_WRITE, "tick": 2500, "addr": 0x041, "value": 0x9},
        ])
        fpath = _write_tamstream_to_file(data, tmp_path)
        ts = TamStream(fpath)

        # At tick 1500: snap1 + write to 0x041
        state = ts.state_at_tick(1500)
        assert memory_config.decode_nibble(state, 0x040) == 0x1
        assert memory_config.decode_nibble(state, 0x041) == 0x2

        # At tick 2000: snap2 exactly
        state = ts.state_at_tick(2000)
        assert memory_config.decode_nibble(state, 0x040) == 0x5
        assert memory_config.decode_nibble(state, 0x041) == 0x3

        # At tick 2500: snap2 + write
        state = ts.state_at_tick(2500)
        assert memory_config.decode_nibble(state, 0x040) == 0x5
        assert memory_config.decode_nibble(state, 0x041) == 0x9
        ts.close()

    def test_tick_markers_and_buttons(self, tmp_path):
        """Tick markers and button events are parsed correctly."""
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": bytes(RAM_BYTES)},
            {"type": REC_TICK_MARKER, "tick": 1100},
            {"type": REC_BUTTON_EVENT, "tick": 1200, "button_id": 1, "state": 1},
            {"type": REC_TICK_MARKER, "tick": 1300},
        ])
        fpath = _write_tamstream_to_file(data, tmp_path)
        ts = TamStream(fpath)

        recs = list(ts.records())
        types = [r[0] for r in recs]
        assert REC_TICK_MARKER in types
        assert REC_BUTTON_EVENT in types

        # Check button event data
        btn_recs = [r for r in recs if r[0] == REC_BUTTON_EVENT]
        assert len(btn_recs) == 1
        assert btn_recs[0][2]["button_id"] == 1
        assert btn_recs[0][2]["state"] == 1
        ts.close()

    def test_annotation_records(self, tmp_path):
        """Annotation records are parsed with text."""
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": bytes(RAM_BYTES)},
            {"type": REC_ANNOTATION, "tick": 1100, "text": "Test note"},
        ])
        fpath = _write_tamstream_to_file(data, tmp_path)
        ts = TamStream(fpath)

        annotations = ts.annotations()
        assert len(annotations) == 1
        assert annotations[0] == (1100, "Test note")
        ts.close()

    def test_babysitter_write(self, tmp_path):
        """Babysitter writes include func_id and apply to RAM."""
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": bytes(RAM_BYTES)},
            {"type": REC_BABYSITTER_WRITE, "tick": 1001, "addr": 0x040, "value": 0xC, "func_id": 1},
        ])
        fpath = _write_tamstream_to_file(data, tmp_path)
        ts = TamStream(fpath)

        state = ts.state_at_tick(1001)
        assert memory_config.decode_nibble(state, 0x040) == 0xC

        # Check record data
        writes = list(ts.writes_in_range(1000, 1002))
        assert len(writes) == 1
        assert writes[0][2]["func_id"] == 1
        assert writes[0][2]["source"] == "babysitter"
        ts.close()

    def test_v2_lcd_frame_parsed(self, tmp_path):
        """V2 stream with 72-byte LCD frame is parsed correctly."""
        # Build a frame: 64 bytes matrix + 8 bytes icons
        matrix = bytearray(64)
        matrix[0] = 0x80  # top-left pixel on (row 0, col 0)
        matrix[4] = 0x01  # row 1, col 7 on
        icons = bytearray(8)
        icons[0] = 1  # FOOD icon on
        icons[3] = 1  # MED icon on
        lcd_data = bytes(matrix) + bytes(icons)

        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": bytes(RAM_BYTES)},
            {"type": REC_LCD_FRAME, "tick": 1100, "display": lcd_data},
        ], version=2)
        fpath = _write_tamstream_to_file(data, tmp_path)
        ts = TamStream(fpath)

        assert ts.version == 2
        assert ts.lcd_bytes == 72
        frame = ts.nearest_lcd_frame(1100)
        assert frame is not None
        tick, frame_data = frame
        assert tick == 1100
        assert len(frame_data) == 72
        assert frame_data[0] == 0x80  # matrix byte 0
        assert frame_data[64] == 1    # icon 0 (FOOD) on
        assert frame_data[67] == 1    # icon 3 (MED) on
        ts.close()

    def test_v1_lcd_frame_compat(self, tmp_path):
        """V1 stream with 50-byte LCD frame still parses."""
        lcd_data = bytes(50)
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": bytes(RAM_BYTES)},
            {"type": REC_LCD_FRAME, "tick": 1100, "display": lcd_data},
        ], version=1)
        fpath = _write_tamstream_to_file(data, tmp_path)
        ts = TamStream(fpath)

        assert ts.version == 1
        assert ts.lcd_bytes == 50
        frame = ts.nearest_lcd_frame(1100)
        assert frame is not None
        assert len(frame[1]) == 50
        ts.close()


# ===========================================================================
# TestAnnotationStore
# ===========================================================================

class TestAnnotationStore:
    """Tests for the AnnotationStore sidecar JSON system."""

    def test_add_and_retrieve(self, tmp_path):
        """Add annotation, retrieve it by tick."""
        from annotation_store import AnnotationStore
        store = AnnotationStore(str(tmp_path / "test.tamstream"))
        store.add(5000, "Test annotation", tags=["test"])
        results = store.get_at_tick(5000)
        assert len(results) == 1
        assert results[0]["text"] == "Test annotation"
        assert results[0]["tick"] == 5000
        assert "test" in results[0]["tags"]

    def test_remove_by_tick(self, tmp_path):
        """Remove all annotations at a tick."""
        from annotation_store import AnnotationStore
        store = AnnotationStore(str(tmp_path / "test.tamstream"))
        store.add(5000, "Note A")
        store.add(5000, "Note B")
        store.add(6000, "Note C")
        assert store.remove(5000) is True
        assert len(store.get_at_tick(5000)) == 0
        assert len(store.get_at_tick(6000)) == 1

    def test_remove_specific_text(self, tmp_path):
        """Remove only the annotation with matching text."""
        from annotation_store import AnnotationStore
        store = AnnotationStore(str(tmp_path / "test.tamstream"))
        store.add(5000, "Note A")
        store.add(5000, "Note B")
        assert store.remove(5000, "Note A") is True
        results = store.get_at_tick(5000)
        assert len(results) == 1
        assert results[0]["text"] == "Note B"

    def test_update_text(self, tmp_path):
        """Update annotation text, verify old text gone."""
        from annotation_store import AnnotationStore
        store = AnnotationStore(str(tmp_path / "test.tamstream"))
        store.add(5000, "Old text")
        assert store.update(5000, "Old text", "New text") is True
        results = store.get_at_tick(5000)
        assert len(results) == 1
        assert results[0]["text"] == "New text"

    def test_persistence(self, tmp_path):
        """Add annotations, create new AnnotationStore on same path, verify loaded."""
        from annotation_store import AnnotationStore
        path = str(tmp_path / "test.tamstream")
        store1 = AnnotationStore(path)
        store1.add(5000, "Persisted note")

        store2 = AnnotationStore(path)
        results = store2.get_at_tick(5000)
        assert len(results) == 1
        assert results[0]["text"] == "Persisted note"

    def test_sidecar_path_derivation(self):
        """foo.tamstream -> foo.tamstream.annotations.json"""
        from annotation_store import AnnotationStore
        store = AnnotationStore("/some/path/foo.tamstream")
        assert store.sidecar_path == "/some/path/foo.tamstream.annotations.json"

    def test_empty_store(self, tmp_path):
        """New store with no sidecar file returns empty lists."""
        from annotation_store import AnnotationStore
        store = AnnotationStore(str(tmp_path / "nonexistent.tamstream"))
        assert store.all() == []
        assert store.get_at_tick(5000) == []

    def test_range_query(self, tmp_path):
        """get_in_range returns only annotations within bounds."""
        from annotation_store import AnnotationStore
        store = AnnotationStore(str(tmp_path / "test.tamstream"))
        store.add(1000, "A")
        store.add(2000, "B")
        store.add(3000, "C")
        store.add(4000, "D")

        results = store.get_in_range(2000, 3000)
        assert len(results) == 2
        assert results[0]["text"] == "B"
        assert results[1]["text"] == "C"


# ===========================================================================
# TestCachedStateTracker (TICKET-22)
# ===========================================================================

class TestCachedStateTracker:
    """Tests for CachedStateTracker forward/backward stepping."""

    def _make_test_stream(self, tmp_path):
        """Build a small stream with known writes for testing."""
        snap_mem = bytes(RAM_BYTES)
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": snap_mem},
            {"type": REC_ROM_WRITE, "tick": 1001, "addr": 0x040, "value": 0x1},
            {"type": REC_ROM_WRITE, "tick": 1002, "addr": 0x041, "value": 0x2},
            {"type": REC_ROM_WRITE, "tick": 1003, "addr": 0x040, "value": 0x3},
            {"type": REC_ROM_WRITE, "tick": 1004, "addr": 0x042, "value": 0xA},
            {"type": REC_ROM_WRITE, "tick": 1005, "addr": 0x040, "value": 0xF},
            {"type": REC_TICK_MARKER, "tick": 1006},
            {"type": REC_ROM_WRITE, "tick": 1007, "addr": 0x043, "value": 0x5},
        ])
        fpath = _write_tamstream_to_file(data, tmp_path, "tracker_test.tamstream")
        return fpath

    def test_seek_matches_state_at_tick(self, tmp_path):
        """seek(tick) produces same RAM as TamStream.state_at_tick(tick)."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)

        for tick in [1000, 1001, 1003, 1005, 1007]:
            tracker.seek(tick)
            expected = ts.state_at_tick(tick)
            assert bytes(tracker.ram) == expected, f"Mismatch at tick {tick}"
        ts.close()

    def test_step_forward_one(self, tmp_path):
        """Step forward 1 write, verify exactly one nibble changed in diff."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)

        tracker.seek(1000)
        n = tracker.step_forward(1)
        assert n == 1
        assert len(tracker.last_diff) >= 1
        assert 0x040 in tracker.last_diff
        assert tracker.last_diff[0x040] == (0x0, 0x1)
        ts.close()

    def test_step_backward_reverts(self, tmp_path):
        """Step forward then backward returns to original state."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)

        tracker.seek(1003)
        state_before = bytes(tracker.ram)
        tracker.step_forward(1)
        assert bytes(tracker.ram) != state_before
        tracker.step_backward(1)
        assert bytes(tracker.ram) == state_before
        ts.close()

    def test_step_forward_10_then_back_10(self, tmp_path):
        """Multiple forward + same backward = original state."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)

        tracker.seek(1000)
        state_before = bytes(tracker.ram)
        n_fwd = tracker.step_forward(6)  # only 6 writes in stream
        n_bk = tracker.step_backward(n_fwd)
        assert n_bk == n_fwd
        assert bytes(tracker.ram) == state_before
        ts.close()

    def test_diff_tracks_changes(self, tmp_path):
        """last_diff contains correct old/new values."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)

        tracker.seek(1000)
        tracker.step_forward(1)  # addr=0x040, val=0x1
        assert tracker.last_diff[0x040] == (0x0, 0x1)

        tracker.step_forward(1)  # addr=0x041, val=0x2
        assert tracker.last_diff[0x041] == (0x0, 0x2)
        ts.close()

    def test_seek_then_step_matches_direct_seek(self, tmp_path):
        """seek(T1) then step to T2 == seek(T2) directly."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)

        # Direct seek to tick 1005
        tracker.seek(1005)
        direct_state = bytes(tracker.ram)

        # Seek to 1000 then step forward to 1005
        tracker.seek(1000)
        tracker.step_to_tick(1005)
        stepped_state = bytes(tracker.ram)

        assert stepped_state == direct_state
        ts.close()

    def test_step_at_end_returns_zero(self, tmp_path):
        """Stepping past end of stream returns 0 steps taken."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)

        tracker.seek(1007)
        # Step forward past end: should already be at last write
        # First exhaust remaining writes
        tracker.step_forward(100)
        n = tracker.step_forward(1)
        assert n == 0
        ts.close()

    def test_step_at_start_backward_returns_zero(self, tmp_path):
        """Stepping backward at stream start returns 0."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)

        tracker.seek(1000)
        n = tracker.step_backward(1)
        assert n == 0
        ts.close()


# ===========================================================================
# TestMemoryGridWidget (TICKET-23)
# ===========================================================================

class TestMemoryGridWidget:
    """Tests for hex grid field-color mapping and visibility."""

    def test_color_map_covers_all_known_addresses(self):
        """Every address in memory_config.MAP (with addr!=None) has a color."""
        for name, cfg in memory_config.MAP.items():
            addr = cfg.get("addr")
            if addr is None:
                continue
            assert addr in ADDR_COLOR_MAP, f"Address 0x{addr:03X} ({name}) has no color"

    def test_field_color_lookup(self):
        """Known addresses map to expected field names."""
        assert ADDR_COLOR_MAP[0x040][0] == "hunger"
        assert ADDR_COLOR_MAP[0x041][0] == "happy"
        assert ADDR_COLOR_MAP[0x043][0] == "discipline"
        assert ADDR_COLOR_MAP[0x02D][0] == "attention"

    def test_bcd_fields_color_both_nibbles(self):
        """Weight: both 0x046 and 0x047 get same color. Age: 0x054 and 0x055."""
        assert ADDR_COLOR_MAP[0x046][0] == "weight"
        assert ADDR_COLOR_MAP[0x047][0] == "weight"
        assert ADDR_COLOR_MAP[0x054][0] == "age"
        assert ADDR_COLOR_MAP[0x055][0] == "age"

    def test_default_visible_range(self):
        """Default shows 20 rows (fully expanded)."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        assert grid.visible_rows == 20

    def test_expand_adds_row(self):
        """After collapsing to compact then expanding, visible rows increases by 1."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        grid.show_default()  # go to compact (4 rows)
        grid.expand_one()
        assert grid.visible_rows == 5

    def test_show_all(self):
        """Show all displays 20 rows (32 cols * 20 = 640 nibbles)."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        grid.show_all()
        assert grid.visible_rows == 20


# ===========================================================================
# TestNavigation (TICKET-24)
# ===========================================================================

class TestNavigation:
    """Tests for tick navigation via CachedStateTracker."""

    def _make_test_stream(self, tmp_path):
        snap_mem = bytes(RAM_BYTES)
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": snap_mem},
            {"type": REC_ROM_WRITE, "tick": 1001, "addr": 0x040, "value": 0x1},
            {"type": REC_ROM_WRITE, "tick": 1002, "addr": 0x041, "value": 0x2},
            {"type": REC_ROM_WRITE, "tick": 1003, "addr": 0x040, "value": 0x3},
            {"type": REC_ROM_WRITE, "tick": 1004, "addr": 0x042, "value": 0xA},
            {"type": REC_ROM_WRITE, "tick": 1005, "addr": 0x040, "value": 0xF},
        ])
        return _write_tamstream_to_file(data, tmp_path)

    def test_step_forward_updates_tick(self, tmp_path):
        """After step_forward(1), current_tick advances."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1000)
        tracker.step_forward(1)
        assert tracker.current_tick == 1001
        ts.close()

    def test_step_backward_updates_tick(self, tmp_path):
        """After step_backward(1), current_tick decreases."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1003)
        prev_tick = tracker.current_tick
        tracker.step_backward(1)
        assert tracker.current_tick < prev_tick
        ts.close()

    def test_home_goes_to_start(self, tmp_path):
        """Seek to first tick gives initial state."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1005)
        tracker.seek(1000)
        assert tracker.current_tick == 1000
        assert bytes(tracker.ram) == ts.state_at_tick(1000)
        ts.close()

    def test_end_goes_to_end(self, tmp_path):
        """Seek to last tick gives final state."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1005)
        assert tracker.current_tick == 1005
        assert bytes(tracker.ram) == ts.state_at_tick(1005)
        ts.close()

    def test_step_forward_then_backward_same_state(self, tmp_path):
        """Step forward 1, backward 1 -> same RAM state."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1002)
        state_before = bytes(tracker.ram)
        tracker.step_forward(1)
        tracker.step_backward(1)
        assert bytes(tracker.ram) == state_before
        ts.close()


# ===========================================================================
# TestDiffHighlighting (TICKET-25)
# ===========================================================================

class TestDiffHighlighting:
    """Tests for diff tracking in CachedStateTracker."""

    def _make_test_stream(self, tmp_path):
        snap_mem = bytes(RAM_BYTES)
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": snap_mem},
            {"type": REC_ROM_WRITE, "tick": 1001, "addr": 0x040, "value": 0x3},
            {"type": REC_ROM_WRITE, "tick": 1002, "addr": 0x041, "value": 0x5},
            {"type": REC_ROM_WRITE, "tick": 1003, "addr": 0x040, "value": 0x7},
        ])
        return _write_tamstream_to_file(data, tmp_path)

    def test_diff_contains_changed_addresses(self, tmp_path):
        """After stepping, last_diff keys match addresses that actually changed."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1000)
        tracker.step_forward(1)
        assert 0x040 in tracker.last_diff
        ts.close()

    def test_diff_old_new_values_correct(self, tmp_path):
        """Diff (old, new) tuples match actual nibble values before/after."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1000)
        tracker.step_forward(1)
        assert tracker.last_diff[0x040] == (0x0, 0x3)
        tracker.step_forward(1)
        assert tracker.last_diff[0x041] == (0x0, 0x5)
        tracker.step_forward(1)
        assert tracker.last_diff[0x040] == (0x3, 0x7)
        ts.close()

    def test_no_diff_on_seek(self, tmp_path):
        """seek() clears last_diff."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1002)
        assert len(tracker.last_diff) == 0
        ts.close()

    def test_diff_summary_format(self, tmp_path):
        """Diff summary can be formatted from last_diff dict."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1000)
        tracker.step_forward(1)
        diff = tracker.last_diff
        parts = []
        for addr in sorted(diff.keys()):
            old_v, new_v = diff[addr]
            field_info = ADDR_COLOR_MAP.get(addr)
            if field_info:
                parts.append(f"0x{addr:03X}/{field_info[0]} ({old_v:X}\u2192{new_v:X})")
            else:
                parts.append(f"0x{addr:03X} ({old_v:X}\u2192{new_v:X})")
        summary = f"{len(diff)} nibbles changed: {', '.join(parts)}"
        assert "0x040/hunger" in summary
        assert "0\u21923" in summary
        ts.close()


# ===========================================================================
# TestTimeline (TICKET-27)
# ===========================================================================

class TestTimeline:
    """Tests for timeline tick-from-position calculation."""

    def test_tick_from_position(self):
        """Mouse x=0 -> min_tick, x=width -> max_tick."""
        _ensure_qapp()
        from stream_viewer import TimelineWidget
        tw = TimelineWidget()
        tw.set_range(1000, 2000)
        tw.resize(500, 40)
        assert tw.tick_from_x(0) == 1000
        assert tw.tick_from_x(500) == 2000
        assert tw.tick_from_x(250) == 1500

    def test_marker_positions(self):
        """Markers at specific ticks map to proportional x positions."""
        _ensure_qapp()
        from stream_viewer import TimelineWidget
        tw = TimelineWidget()
        tw.set_range(0, 1000)
        tw.resize(1000, 40)
        # A marker at tick 500 should be at x=500
        # (This is a layout calculation test, not a paint test)
        span = tw.max_tick - tw.min_tick
        x = int((500 - tw.min_tick) / span * tw.width())
        assert x == 500


# ===========================================================================
# TestHelpOverlay (TICKET-28)
# ===========================================================================

class TestHelpOverlay:
    """Tests for help overlay."""

    def test_help_overlay_toggle(self):
        """Toggle shows/hides overlay."""
        _ensure_qapp()
        from stream_viewer import HelpOverlay
        overlay = HelpOverlay()
        assert not overlay.isVisible()
        overlay.toggle()
        assert overlay.isVisible()
        overlay.toggle()
        assert not overlay.isVisible()


# ===========================================================================
# TestLcdPopupWidget (Feature 3)
# ===========================================================================

class TestLcdPopupWidget:
    """Tests for the LCD popup widget."""

    def test_update_frame_with_data(self):
        """Popup accepts frame data and updates label."""
        _ensure_qapp()
        from stream_viewer import LcdPopupWidget
        popup = LcdPopupWidget()
        frame = bytearray(72)
        frame[0] = 0x80  # a pixel
        popup.update_frame(5000, bytes(frame), min_tick=1000)
        assert "5,000" in popup._tick_label.text()

    def test_update_frame_with_none(self):
        """Popup handles None frame data gracefully."""
        _ensure_qapp()
        from stream_viewer import LcdPopupWidget
        popup = LcdPopupWidget()
        popup.update_frame(5000, None, min_tick=0)
        assert "No LCD data" in popup._tick_label.text()


# ===========================================================================
# TestBuildSavestateBytes (Feature 4)
# ===========================================================================

class TestBuildSavestateBytes:
    """Tests for savestate construction."""

    def test_savestate_size(self):
        """Savestate is exactly 385 bytes (1 + 64 + 320)."""
        from stream_viewer import StreamViewer
        ram = bytes(320)
        result = StreamViewer._build_savestate_bytes(ram, 100000)
        assert len(result) == 385

    def test_savestate_magic(self):
        """First byte is 0x12."""
        from stream_viewer import StreamViewer
        ram = bytes(320)
        result = StreamViewer._build_savestate_bytes(ram, 100000)
        assert result[0] == 0x12

    def test_savestate_tick_fields(self):
        """tick_counter, clk_timer, prog_timer all set to the given tick."""
        import struct
        from stream_viewer import StreamViewer
        ram = bytes(320)
        tick = 123456
        result = StreamViewer._build_savestate_bytes(ram, tick)
        # cpu_state starts at byte 1, tick_counter at offset 12
        assert struct.unpack_from("<I", result, 1 + 12)[0] == tick
        assert struct.unpack_from("<I", result, 1 + 16)[0] == tick
        assert struct.unpack_from("<I", result, 1 + 20)[0] == tick

    def test_savestate_ram_preserved(self):
        """RAM bytes are preserved in the savestate."""
        from stream_viewer import StreamViewer
        ram = bytearray(320)
        ram[0] = 0xAB
        ram[100] = 0xCD
        ram[319] = 0xEF
        result = StreamViewer._build_savestate_bytes(bytes(ram), 0)
        # RAM starts at byte 65 (1 + 64)
        assert result[65] == 0xAB
        assert result[165] == 0xCD
        assert result[384] == 0xEF


# ===========================================================================
# TestLcdChangeNavigation (Feature 5)
# ===========================================================================

class TestLcdChangeNavigation:
    """Tests for LCD screen change detection and navigation."""

    def _make_lcd_change_stream(self, tmp_path):
        """Build a v2 stream with multiple LCD frames, some identical, some different."""
        frame_a = bytearray(72)
        frame_a[0] = 0x80  # pixel on
        frame_b = bytearray(72)
        frame_b[0] = 0x40  # different pixel
        frame_c = bytearray(72)
        frame_c[0] = 0x40  # same as B

        records = [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": bytes(RAM_BYTES)},
            {"type": REC_LCD_FRAME, "tick": 1000, "display": bytes(frame_a)},
            {"type": REC_LCD_FRAME, "tick": 2000, "display": bytes(frame_b)},   # changed
            {"type": REC_LCD_FRAME, "tick": 3000, "display": bytes(frame_c)},   # same as B
            {"type": REC_LCD_FRAME, "tick": 4000, "display": bytes(frame_a)},   # changed back
        ]
        data = make_tamstream_bytes(1000, records, version=2)
        fpath = _write_tamstream_to_file(data, tmp_path, "lcd_change_test.tamstream")
        return TamStream(fpath)

    def test_lcd_change_ticks_built(self, tmp_path):
        """_lcd_change_ticks is populated with ticks where display changed."""
        ts = self._make_lcd_change_stream(tmp_path)
        # frame_a -> frame_b at 2000 (change), frame_b -> frame_c at 3000 (same), frame_c -> frame_a at 4000 (change)
        assert ts._lcd_change_ticks == [2000, 4000]
        ts.close()

    def test_next_lcd_change(self, tmp_path):
        """next_lcd_change returns the next change tick."""
        ts = self._make_lcd_change_stream(tmp_path)
        assert ts.next_lcd_change(1000) == 2000
        assert ts.next_lcd_change(2000) == 4000
        assert ts.next_lcd_change(2500) == 4000
        assert ts.next_lcd_change(4000) is None
        ts.close()

    def test_prev_lcd_change(self, tmp_path):
        """prev_lcd_change returns the previous change tick."""
        ts = self._make_lcd_change_stream(tmp_path)
        assert ts.prev_lcd_change(5000) == 4000
        assert ts.prev_lcd_change(4000) == 2000
        assert ts.prev_lcd_change(3000) == 2000
        assert ts.prev_lcd_change(2000) is None
        ts.close()

    def test_next_lcd_change_skips_identical(self, tmp_path):
        """Identical adjacent frames (B->C) do NOT produce a change tick."""
        ts = self._make_lcd_change_stream(tmp_path)
        # At tick 2500, next change should be 4000, not 3000
        assert ts.next_lcd_change(2500) == 4000
        ts.close()


# ===========================================================================
# TestComputeRamDiff (Feature 6)
# ===========================================================================

class TestComputeRamDiff:
    """Tests for cross-mark RAM diff computation."""

    def test_identical_rams(self):
        """Identical RAMs produce empty diff."""
        from stream_viewer import StreamViewer
        ram = bytes(320)
        assert StreamViewer._compute_ram_diff(ram, ram) == {}

    def test_single_nibble_diff(self):
        """Single nibble change detected correctly."""
        from stream_viewer import StreamViewer
        ram_a = bytearray(320)
        ram_b = bytearray(320)
        # Change upper nibble of byte 0x20 (addr 0x040)
        ram_b[0x20] = 0xA0
        diff = StreamViewer._compute_ram_diff(bytes(ram_a), bytes(ram_b))
        assert diff == {0x040: (0, 0xA)}

    def test_both_nibbles_in_byte(self):
        """Both nibbles in same byte can differ independently."""
        from stream_viewer import StreamViewer
        ram_a = bytearray(320)
        ram_b = bytearray(320)
        ram_a[0x20] = 0x35
        ram_b[0x20] = 0xA7
        diff = StreamViewer._compute_ram_diff(bytes(ram_a), bytes(ram_b))
        assert diff == {0x040: (3, 0xA), 0x041: (5, 7)}


# ===========================================================================
# TestTickMarking (Feature 6)
# ===========================================================================

class TestTickMarking:
    """Tests for bookmark toggling and cycling logic."""

    def test_mark_toggle_add_remove(self):
        """Adding then removing a mark works correctly."""
        import bisect
        marks = []
        tick = 5000

        # Add
        bisect.insort(marks, tick)
        assert marks == [5000]

        # Remove
        idx = bisect.bisect_left(marks, tick)
        if idx < len(marks) and marks[idx] == tick:
            marks.pop(idx)
        assert marks == []

    def test_mark_cycling_wraps(self):
        """Cycling past end wraps to beginning."""
        marks = [1000, 2000, 3000]
        cursor = 2  # at 3000
        cursor += 1
        if cursor >= len(marks):
            cursor = 0
        assert cursor == 0
        assert marks[cursor] == 1000

    def test_mark_cycling_wraps_backward(self):
        """Cycling before start wraps to end."""
        marks = [1000, 2000, 3000]
        cursor = 0  # at 1000
        cursor -= 1
        if cursor < 0:
            cursor = len(marks) - 1
        assert cursor == 2
        assert marks[cursor] == 3000


# ===========================================================================
# TestWriteTicksPrecomputed (Fix 3 — seek performance)
# ===========================================================================

class TestWriteTicksPrecomputed:
    """Tests that _write_ticks is pre-built and used by seek()."""

    def _make_test_stream(self, tmp_path):
        snap_mem = bytes(RAM_BYTES)
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": snap_mem},
            {"type": REC_ROM_WRITE, "tick": 1001, "addr": 0x040, "value": 0x1},
            {"type": REC_ROM_WRITE, "tick": 1002, "addr": 0x041, "value": 0x2},
            {"type": REC_ROM_WRITE, "tick": 1003, "addr": 0x040, "value": 0x3},
        ])
        return _write_tamstream_to_file(data, tmp_path)

    def test_write_ticks_prebuilt(self, tmp_path):
        """_write_ticks is a list matching write tick values."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        assert hasattr(tracker, '_write_ticks')
        assert tracker._write_ticks == [w[0] for w in tracker._writes]
        ts.close()

    def test_seek_uses_prebuilt_ticks(self, tmp_path):
        """seek() still produces correct results after prebuilt optimization."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        for tick in [1000, 1001, 1002, 1003]:
            tracker.seek(tick)
            expected = ts.state_at_tick(tick)
            assert bytes(tracker.ram) == expected, f"Mismatch at tick {tick}"
        ts.close()


# ===========================================================================
# TestAddrWriteIndex (Feature B — per-address write index)
# ===========================================================================

class TestAddrWriteIndex:
    """Tests for per-address write index and navigation."""

    def _make_test_stream(self, tmp_path):
        snap_mem = bytes(RAM_BYTES)
        data = make_tamstream_bytes(1000, [
            {"type": REC_RAM_SNAPSHOT, "tick": 1000, "memory": snap_mem},
            {"type": REC_ROM_WRITE, "tick": 1001, "addr": 0x040, "value": 0x1},
            {"type": REC_ROM_WRITE, "tick": 1002, "addr": 0x041, "value": 0x2},
            {"type": REC_ROM_WRITE, "tick": 1003, "addr": 0x040, "value": 0x3},
            {"type": REC_ROM_WRITE, "tick": 1004, "addr": 0x042, "value": 0xA},
            {"type": REC_ROM_WRITE, "tick": 1005, "addr": 0x040, "value": 0xF},
        ])
        return _write_tamstream_to_file(data, tmp_path)

    def test_addr_write_indices_built(self, tmp_path):
        """_addr_write_indices maps addresses to lists of write indices."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        assert 0x040 in tracker._addr_write_indices
        assert 0x041 in tracker._addr_write_indices
        assert 0x042 in tracker._addr_write_indices
        # 0x040 is written at indices 0, 2, 4
        assert len(tracker._addr_write_indices[0x040]) == 3
        # 0x041 is written once
        assert len(tracker._addr_write_indices[0x041]) == 1
        ts.close()

    def test_next_write_to_addrs_from_start(self, tmp_path):
        """From start, next write to {0x041} returns tick 1002."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1000)
        tick = tracker.next_write_to_addrs({0x041})
        assert tick == 1002
        ts.close()

    def test_next_write_to_addrs_multi(self, tmp_path):
        """From start, next write to {0x041, 0x042} returns earliest match."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1000)
        tick = tracker.next_write_to_addrs({0x041, 0x042})
        assert tick == 1002  # 0x041 at 1002 is before 0x042 at 1004
        ts.close()

    def test_prev_write_to_addrs(self, tmp_path):
        """From end, prev write to {0x042} returns tick 1004."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1005)
        tracker.step_forward(100)  # exhaust writes
        tick = tracker.prev_write_to_addrs({0x042})
        assert tick == 1004
        ts.close()

    def test_next_write_to_addrs_none_past_end(self, tmp_path):
        """No more writes to addr returns None."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1005)
        tracker.step_forward(100)
        tick = tracker.next_write_to_addrs({0x040})
        assert tick is None
        ts.close()

    def test_prev_write_to_addrs_none_at_start(self, tmp_path):
        """No prior writes to addr returns None."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1000)
        tick = tracker.prev_write_to_addrs({0x040})
        assert tick is None
        ts.close()

    def test_empty_addrs_returns_none(self, tmp_path):
        """Empty address set returns None."""
        from stream_reader import CachedStateTracker
        fpath = self._make_test_stream(tmp_path)
        ts = TamStream(fpath)
        tracker = CachedStateTracker(ts)
        tracker.seek(1000)
        assert tracker.next_write_to_addrs(set()) is None
        assert tracker.prev_write_to_addrs(set()) is None
        ts.close()


# ===========================================================================
# TestMemoryGridSelection (Feature A — address selection)
# ===========================================================================

class TestMemoryGridSelection:
    """Tests for hex grid address selection state."""

    def test_initial_selection_empty(self):
        """Grid starts with no selection."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        assert grid.selected_addresses() == set()

    def test_clear_selection(self):
        """clear_selection empties the set."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        grid._selected_addrs = {0x040, 0x041}
        grid.clear_selection()
        assert grid.selected_addresses() == set()

    def test_addr_range_single(self):
        """Range from addr to itself is just that addr."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        result = grid._addr_range(0x040, 0x040)
        assert result == {0x040}

    def test_addr_range_horizontal(self):
        """Range across same row."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        # Addrs 0x000..0x01F are row 0 (32 cols). 0x002 to 0x005 = 4 addrs.
        result = grid._addr_range(0x002, 0x005)
        assert result == {0x002, 0x003, 0x004, 0x005}

    def test_addr_range_rectangular(self):
        """Range spanning multiple rows forms a rectangle."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        # Row 0 col 0 = 0x000, Row 1 col 1 = 0x021
        result = grid._addr_range(0x000, 0x021)
        # Rectangle: rows 0-1, cols 0-1
        assert result == {0x000, 0x001, 0x020, 0x021}


# ===========================================================================
# TestBookmarkButtons (Feature C)
# ===========================================================================

class TestBookmarkButtons:
    """Tests for bookmark button existence in NavigationBar."""

    def test_nav_bar_has_bookmark_buttons(self):
        """NavigationBar has +Bk, <Bk, Bk> buttons."""
        _ensure_qapp()
        from stream_viewer import NavigationBar
        nav = NavigationBar()
        assert hasattr(nav, 'btn_add_bookmark')
        assert hasattr(nav, 'btn_prev_bookmark')
        assert hasattr(nav, 'btn_next_bookmark')
        assert nav.btn_add_bookmark.text() == "+Bk"
        assert nav.btn_prev_bookmark.text() == "<Bk"
        assert nav.btn_next_bookmark.text() == "Bk>"


# ===========================================================================
# TestBookmarkStore (persistent bookmarks)
# ===========================================================================

class TestBookmarkStore:
    """Tests for the BookmarkStore sidecar JSON system."""

    def test_add_and_list(self, tmp_path):
        """Add bookmarks, verify they come back sorted."""
        from bookmark_store import BookmarkStore
        store = BookmarkStore(str(tmp_path / "test.tamstream"))
        store.add(3000)
        store.add(1000)
        store.add(2000)
        assert store.ticks == [1000, 2000, 3000]

    def test_toggle(self, tmp_path):
        """Toggle adds, then removes."""
        from bookmark_store import BookmarkStore
        store = BookmarkStore(str(tmp_path / "test.tamstream"))
        assert store.toggle(5000) is True   # added
        assert store.ticks == [5000]
        assert store.toggle(5000) is False  # removed
        assert store.ticks == []

    def test_no_duplicate(self, tmp_path):
        """Adding same tick twice returns False."""
        from bookmark_store import BookmarkStore
        store = BookmarkStore(str(tmp_path / "test.tamstream"))
        assert store.add(5000) is True
        assert store.add(5000) is False
        assert store.ticks == [5000]

    def test_remove(self, tmp_path):
        """Remove existing returns True, non-existing returns False."""
        from bookmark_store import BookmarkStore
        store = BookmarkStore(str(tmp_path / "test.tamstream"))
        store.add(5000)
        assert store.remove(5000) is True
        assert store.remove(5000) is False

    def test_persistence(self, tmp_path):
        """Bookmarks survive reload from disk."""
        from bookmark_store import BookmarkStore
        path = str(tmp_path / "test.tamstream")
        store1 = BookmarkStore(path)
        store1.add(1000)
        store1.add(3000)
        store1.add(2000)

        store2 = BookmarkStore(path)
        assert store2.ticks == [1000, 2000, 3000]

    def test_sidecar_path(self):
        """Sidecar path derived correctly."""
        from bookmark_store import BookmarkStore
        store = BookmarkStore("/some/path/foo.tamstream")
        assert store.sidecar_path == "/some/path/foo.tamstream.bookmarks.json"

    def test_empty_store(self, tmp_path):
        """New store with no file returns empty list."""
        from bookmark_store import BookmarkStore
        store = BookmarkStore(str(tmp_path / "nonexistent.tamstream"))
        assert store.ticks == []


# ===========================================================================
# TestButtonTooltips
# ===========================================================================

class TestButtonTooltips:
    """Every nav bar button should have a non-empty tooltip."""

    def test_all_nav_buttons_have_tooltips(self):
        _ensure_qapp()
        from stream_viewer import NavigationBar
        nav = NavigationBar()
        buttons = [
            nav.btn_home, nav.btn_back_1s, nav.btn_back_10, nav.btn_back_1,
            nav.btn_fwd_1, nav.btn_fwd_10, nav.btn_fwd_1s, nav.btn_end,
            nav.btn_play, nav.btn_prev_lcd, nav.btn_next_lcd,
            nav.btn_prev_sel, nav.btn_next_sel,
            nav.btn_add_bookmark, nav.btn_prev_bookmark, nav.btn_next_bookmark,
        ]
        for btn in buttons:
            assert btn.toolTip(), f"Button '{btn.text()}' has no tooltip"

    def test_sel_buttons_exist(self):
        """<Sel and Sel> buttons exist in NavigationBar."""
        _ensure_qapp()
        from stream_viewer import NavigationBar
        nav = NavigationBar()
        assert hasattr(nav, 'btn_prev_sel')
        assert hasattr(nav, 'btn_next_sel')
        assert nav.btn_prev_sel.text() == "<Sel"
        assert nav.btn_next_sel.text() == "Sel>"
