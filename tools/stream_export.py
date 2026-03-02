#!/usr/bin/env python3
"""Export filtered data from .tamstream files in CSV or JSON format."""

import argparse
import csv
import json
import sys
import os

sys.path.insert(0, os.path.dirname(__file__))
from stream_reader import TamStream, REC_ROM_WRITE, REC_BABYSITTER_WRITE, BFID_NAMES


def parse_addresses(addr_str):
    """Parse comma-separated hex addresses like '0x040,0x041,0x049'."""
    if not addr_str:
        return None
    addrs = set()
    for a in addr_str.split(","):
        addrs.add(int(a.strip(), 0))
    return addrs


def parse_range(range_str):
    """Parse 'START:END' tick range."""
    if not range_str:
        return None, None
    parts = range_str.split(":")
    start = int(parts[0]) if parts[0] else 0
    end = int(parts[1]) if len(parts) > 1 and parts[1] else 0xFFFFFFFF
    return start, end


def main():
    parser = argparse.ArgumentParser(description="Export data from .tamstream files")
    parser.add_argument("tamstream_file", help="Path to .tamstream file")
    parser.add_argument("--addresses", help="Filter by nibble addresses (comma-separated hex, e.g. 0x040,0x041)")
    parser.add_argument("--range", help="Tick range START:END")
    parser.add_argument("--source", choices=["rom", "babysitter", "all"], default="all",
                        help="Filter by write source")
    parser.add_argument("--format", choices=["csv", "json"], default="csv",
                        help="Output format (default: csv)")
    parser.add_argument("--summary", action="store_true",
                        help="Print per-address write count histogram")
    parser.add_argument("--stats-at", type=int, metavar="TICK",
                        help="Print decoded stats at a specific tick")
    args = parser.parse_args()

    stream = TamStream(args.tamstream_file)

    # --stats-at mode
    if args.stats_at is not None:
        stats = stream.stats_at_tick(args.stats_at)
        print(f"Stats at tick {args.stats_at}:")
        for key, val in sorted(stats.items()):
            print(f"  {key}: {val}")
        return

    # Parse filters
    addrs = parse_addresses(args.addresses)
    start_tick, end_tick = parse_range(args.range)
    if start_tick is None:
        start_tick = 0
    if end_tick is None:
        end_tick = 0xFFFFFFFF

    source_filter = None if args.source == "all" else args.source

    # --summary mode
    if args.summary:
        addr_counts = {}  # addr -> {"rom": count, "babysitter": count}
        for rec_type, tick, data in stream.records():
            if tick < start_tick or tick > end_tick:
                continue
            if rec_type not in (REC_ROM_WRITE, REC_BABYSITTER_WRITE):
                continue
            addr = data["addr"]
            if addrs and addr not in addrs:
                continue
            src = "rom" if rec_type == REC_ROM_WRITE else "babysitter"
            if source_filter and src != source_filter:
                continue
            if addr not in addr_counts:
                addr_counts[addr] = {"rom": 0, "babysitter": 0}
            addr_counts[addr][src] += 1

        print(f"{'address':>8s}  {'rom_writes':>10s}  {'bsit_writes':>11s}  {'total':>8s}")
        for addr in sorted(addr_counts.keys()):
            c = addr_counts[addr]
            total = c["rom"] + c["babysitter"]
            print(f"  0x{addr:03X}  {c['rom']:>10,}  {c['babysitter']:>11,}  {total:>8,}")
        return

    # Normal export mode
    rows = []
    for rec_type, tick, data in stream.records():
        if tick < start_tick or tick > end_tick:
            continue
        if rec_type not in (REC_ROM_WRITE, REC_BABYSITTER_WRITE):
            continue
        addr = data["addr"]
        if addrs and addr not in addrs:
            continue
        src = data.get("source", "rom")
        if source_filter and src != source_filter:
            continue

        func_name = data.get("func_name", "")
        rows.append({
            "tick": tick,
            "source": src,
            "address": f"0x{addr:03X}",
            "value": data["value"],
            "func_id": func_name,
        })

    if args.format == "csv":
        writer = csv.DictWriter(sys.stdout, fieldnames=["tick", "source", "address", "value", "func_id"])
        writer.writeheader()
        writer.writerows(rows)
    else:
        print(json.dumps(rows, indent=2))


if __name__ == "__main__":
    main()
