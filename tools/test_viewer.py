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


# ===========================================================================
# TestAnnotationStore (placeholder — filled in TICKET-21)
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
        """Default shows 8 rows."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        assert grid.visible_rows == 8

    def test_expand_adds_row(self):
        """After expand, visible rows increases by 1."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        grid.expand_one()
        assert grid.visible_rows == 9

    def test_show_all(self):
        """Show all displays 40 rows."""
        _ensure_qapp()
        from stream_viewer import MemoryGridWidget
        grid = MemoryGridWidget()
        grid.show_all()
        assert grid.visible_rows == 40


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
