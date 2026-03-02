"""Helpers for building synthetic .tamstream data for tests."""

import struct
import io

# Record type tags (mirrored from stream_reader.py)
REC_RAM_SNAPSHOT     = 0x01
REC_ROM_WRITE        = 0x02
REC_BABYSITTER_WRITE = 0x03
REC_LCD_FRAME        = 0x04
REC_ANNOTATION       = 0x05
REC_TICK_MARKER      = 0x06
REC_BUTTON_EVENT     = 0x07

RAM_BYTES = 320  # 640 nibbles packed into 320 bytes


def make_tamstream_bytes(start_tick, records, ram_nibbles=640):
    """Build a .tamstream file as bytes from a list of record dicts.

    Each record: {"type": REC_*, "tick": int, ...type-specific fields}
    Returns bytes suitable for BytesIO or writing to disk.

    Record-specific fields:
        REC_RAM_SNAPSHOT:     {"memory": bytes(320)}
        REC_ROM_WRITE:        {"addr": int, "value": int}
        REC_BABYSITTER_WRITE: {"addr": int, "value": int, "func_id": int}
        REC_LCD_FRAME:        {"display": bytes(50)}
        REC_ANNOTATION:       {"text": str}
        REC_TICK_MARKER:      {}
        REC_BUTTON_EVENT:     {"button_id": int, "state": int}
    """
    buf = io.BytesIO()

    # Header: "TAMS" + version(u16) + start_tick(u32) + ram_nibbles(u16) + padding(4)
    header = b"TAMS"
    header += struct.pack("<H", 1)  # version
    header += struct.pack("<I", start_tick)  # start_tick
    header += struct.pack("<H", ram_nibbles)  # ram_nibbles
    header += b"\x00" * 4  # padding to 16 bytes
    buf.write(header)

    for rec in records:
        rtype = rec["type"]
        tick = rec["tick"]

        if rtype == REC_RAM_SNAPSHOT:
            mem = rec.get("memory", bytes(RAM_BYTES))
            assert len(mem) == RAM_BYTES
            buf.write(struct.pack("B", rtype))
            buf.write(struct.pack("<I", tick))
            buf.write(mem)

        elif rtype == REC_ROM_WRITE:
            buf.write(struct.pack("B", rtype))
            buf.write(struct.pack("<I", tick))
            buf.write(struct.pack("<H", rec["addr"]))
            buf.write(struct.pack("B", rec["value"]))

        elif rtype == REC_BABYSITTER_WRITE:
            buf.write(struct.pack("B", rtype))
            buf.write(struct.pack("<I", tick))
            buf.write(struct.pack("<H", rec["addr"]))
            buf.write(struct.pack("B", rec["value"]))
            buf.write(struct.pack("B", rec.get("func_id", 0)))

        elif rtype == REC_LCD_FRAME:
            display = rec.get("display", bytes(50))
            assert len(display) == 50
            buf.write(struct.pack("B", rtype))
            buf.write(struct.pack("<I", tick))
            buf.write(display)

        elif rtype == REC_ANNOTATION:
            text = rec.get("text", "").encode("utf-8")
            buf.write(struct.pack("B", rtype))
            buf.write(struct.pack("<I", tick))
            buf.write(struct.pack("<H", len(text)))
            buf.write(text)

        elif rtype == REC_TICK_MARKER:
            buf.write(struct.pack("B", rtype))
            buf.write(struct.pack("<I", tick))

        elif rtype == REC_BUTTON_EVENT:
            buf.write(struct.pack("B", rtype))
            buf.write(struct.pack("<I", tick))
            buf.write(struct.pack("B", rec.get("button_id", 0)))
            buf.write(struct.pack("B", rec.get("state", 0)))

    return buf.getvalue()
