#!/usr/bin/env python3
"""Validate and summarize a .tamstream file or segment directory."""

import struct
import sys
import os
import io
import zlib
import glob

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

STREAM_COMPRESS_NONE = 0x00
STREAM_COMPRESS_ZLIB = 0x01

LCD_BYTES_V1 = 50
LCD_BYTES_V2 = 72  # v2+: matrix_buffer (64) + icon_buffer (8)


def validate(filepath):
    filesize = os.path.getsize(filepath)
    with open(filepath, "rb") as raw:
        # --- File header (16 bytes) ---
        header = raw.read(16)
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
        compression = header[12] if version >= 3 else STREAM_COMPRESS_NONE

        if version not in (1, 2, 3):
            print(f"WARNING: Unknown version {version} (expected 1, 2, or 3)")

        if ram_nibbles != 0x280:
            print(f"WARNING: Unexpected RAM nibble count: 0x{ram_nibbles:X} (expected 0x280)")

        # LCD frame size is version-dependent
        lcd_bytes = LCD_BYTES_V2 if version >= 2 else LCD_BYTES_V1

        # Fixed record sizes (excluding tag byte already read)
        fixed_sizes = {
            REC_RAM_SNAPSHOT:     4 + 320,
            REC_ROM_WRITE:        4 + 2 + 1,
            REC_BABYSITTER_WRITE: 4 + 2 + 1 + 1,
            REC_LCD_FRAME:        4 + lcd_bytes,
            REC_TICK_MARKER:      4,
            REC_BUTTON_EVENT:     4 + 1 + 1,
        }

        # Decompress if needed
        if compression == STREAM_COMPRESS_ZLIB:
            try:
                compressed_data = raw.read()
                # Find TIDX index at end of raw file (last 8 bytes = index_start offset)
                # Strip the TIDX section before decompressing
                # Actually the compressed data comes first, then TIDX uncompressed.
                # We need to find where the compressed stream ends.
                # Strategy: try to decompress the full remaining data (TIDX is appended after).
                # zlib raw inflate will stop at end of deflate stream and ignore trailing bytes.
                f = io.BytesIO(zlib.decompress(compressed_data, -15))
            except Exception as e:
                print(f"ERROR: Decompression failed: {e}")
                return False
        else:
            f = io.BytesIO(raw.read())

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
                size = fixed_sizes[tag]
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
        print(f"Version: {version}  Compression: {'zlib' if compression else 'none'}")
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


def validate_directory(dirpath):
    """Validate all segments in a directory."""
    seg_files = sorted(glob.glob(os.path.join(dirpath, "seg_*.tamstream")))
    if not seg_files:
        print(f"ERROR: No seg_*.tamstream files found in: {dirpath}")
        return False

    print(f"Directory: {dirpath}")
    print(f"Segments: {len(seg_files)}")
    print()

    all_ok = True
    for seg_path in seg_files:
        ok = validate(seg_path)
        if not ok:
            all_ok = False
        print()

    if all_ok:
        print(f"All {len(seg_files)} segments OK")
    else:
        print(f"ERRORS in one or more segments")
    return all_ok


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <tamstream_file_or_directory>")
        sys.exit(1)

    path = sys.argv[1]
    if not os.path.exists(path):
        print(f"ERROR: Path not found: {path}")
        sys.exit(1)

    if os.path.isdir(path):
        ok = validate_directory(path)
    else:
        ok = validate(path)
    sys.exit(0 if ok else 1)
