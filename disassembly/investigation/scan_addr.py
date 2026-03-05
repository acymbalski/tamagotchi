
import sys
import os
sys.path.append('tools')
from stream_reader import SegmentedTamStream

def scan_all(stream_path, addr):
    stream = SegmentedTamStream(stream_path)
    start, end = stream.tick_range
    
    step = 32768 * 60 * 5
    
    prev_val = -1
    for t in range(start, end, step):
        ram = stream.state_at_tick(t)
        val = (ram[addr >> 1] & 0x0F) if (addr & 1) else (ram[addr >> 1] >> 4)
        if val != prev_val:
            print(f"Tick {t:12}: 0x{addr:03X} = {val}")
            prev_val = val

if __name__ == "__main__":
    addr = int(sys.argv[2], 16) if len(sys.argv) > 2 else 0x051
    path = sys.argv[1] if len(sys.argv) > 1 else "captures/streams/stream_1577974440"
    scan_all(path, addr)
