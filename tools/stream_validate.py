#!/usr/bin/env python3
"""Validate and summarize a .tamstream binary file."""

import struct
import sys
import os

# Record type tags
REC_RAM_SNAPSHOT     = 0x01
REC_ROM_WRITE        = 0x02
REC_BABYSITTER_WRITE = 0x03
REC_LCD_FRAME        = 0x04
REC_ANNOTATION       = 0x05
REC_TICK_MARKER      = 0x06
REC_BUTTON_EVENT     = 0x07

RECORD_NAMES = {
    REC_RAM_SNAPSHOT:     "RAM Snapshots",
    REC_ROM_WRITE:        "ROM Writes",
    REC_BABYSITTER_WRITE: "Babysitter Writes",
    REC_LCD_FRAME:        "LCD Frames",
    REC_ANNOTATION:       "Annotations",
    REC_TICK_MARKER:      "Tick Markers",
    REC_BUTTON_EVENT:     "Button Events",
}

# Fixed record sizes (excluding tag byte already read)
FIXED_SIZES = {
    REC_RAM_SNAPSHOT:     4 + 320,   # tick + 320 bytes RAM
    REC_ROM_WRITE:        4 + 2 + 1, # tick + addr + value
    REC_BABYSITTER_WRITE: 4 + 2 + 1 + 1, # tick + addr + value + func_id
    REC_LCD_FRAME:        4 + 50,    # tick + 50 bytes LCD
    REC_TICK_MARKER:      4,         # tick only
    REC_BUTTON_EVENT:     4 + 1 + 1, # tick + button_id + state
}


def validate(filepath):
    filesize = os.path.getsize(filepath)
    with open(filepath, "rb") as f:
        # --- File header (16 bytes) ---
        header = f.read(16)
        if len(header) < 16:
            print(f"ERROR: File too small for header ({len(header)} bytes)")
            return False

        magic = header[0:4]
        if magic != b"TAMS":
            print(f"ERROR: Bad magic: {magic!r} (expected b'TAMS')")
            return False

        version = struct.unpack_from("<H", header, 4)[0]
        start_tick = struct.unpack_from("<I", header, 6)[0]
        ram_nibbles = struct.unpack_from("<H", header, 10)[0]

        if version != 1:
            print(f"WARNING: Unknown version {version} (expected 1)")

        if ram_nibbles != 0x280:
            print(f"WARNING: Unexpected RAM nibble count: 0x{ram_nibbles:X} (expected 0x280)")

        # --- Records ---
        counts = {t: 0 for t in RECORD_NAMES}
        first_tick = None
        last_tick = None
        total_records = 0
        errors = []

        while True:
            pos = f.tell()
            tag_byte = f.read(1)
            if len(tag_byte) == 0:
                break  # EOF

            tag = tag_byte[0]
            if tag not in RECORD_NAMES:
                errors.append(f"Unknown record type 0x{tag:02X} at offset {pos}")
                break  # Can't recover — unknown size

            if tag == REC_ANNOTATION:
                # Variable-length: tick(4) + len(2) + text(len)
                data = f.read(6)
                if len(data) < 6:
                    errors.append(f"Truncated annotation header at offset {pos}")
                    break
                tick = struct.unpack_from("<I", data, 0)[0]
                text_len = struct.unpack_from("<H", data, 4)[0]
                text_data = f.read(text_len)
                if len(text_data) < text_len:
                    errors.append(f"Truncated annotation text at offset {pos}")
                    break
            else:
                size = FIXED_SIZES[tag]
                data = f.read(size)
                if len(data) < size:
                    errors.append(f"Truncated {RECORD_NAMES[tag]} record at offset {pos} (got {len(data)}, expected {size})")
                    break
                tick = struct.unpack_from("<I", data, 0)[0]

            counts[tag] += 1
            total_records += 1

            if first_tick is None:
                first_tick = tick
            last_tick = tick

        # --- Summary ---
        print(f"File: {filepath}")
        print(f"Version: {version}")
        print(f"Start tick: {start_tick}")
        print(f"Records: {total_records:,}")
        for tag in sorted(RECORD_NAMES.keys()):
            print(f"  {RECORD_NAMES[tag]:20s} {counts[tag]:>10,}")

        if first_tick is not None and last_tick is not None:
            tick_span = last_tick - first_tick
            emu_seconds = tick_span / 32768.0
            print(f"Duration: {emu_seconds:.1f} emu-seconds (tick {first_tick} -> {last_tick})")

        print(f"File size: {filesize / (1024*1024):.2f} MB")

        if errors:
            print(f"\nERRORS ({len(errors)}):")
            for e in errors:
                print(f"  {e}")
            return False

        print("\nValidation: OK")
        return True


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <tamstream_file>")
        sys.exit(1)

    filepath = sys.argv[1]
    if not os.path.exists(filepath):
        print(f"ERROR: File not found: {filepath}")
        sys.exit(1)

    ok = validate(filepath)
    sys.exit(0 if ok else 1)
