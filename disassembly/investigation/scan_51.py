
import sys
import os
sys.path.append('tools')
from stream_reader import SegmentedTamStream

def scan_all(stream_path, addr):
    stream = SegmentedTamStream(stream_path)
    start, end = stream.tick_range
    
    # 5 minute steps
    step = 32768 * 60 * 5
    
    prev_val = -1
    for t in range(start, end, step):
        ram = stream.state_at_tick(t)
        val = (ram[addr >> 1] & 0x0F) if (addr & 1) else (ram[addr >> 1] >> 4)
        if val != prev_val:
            print(f"Tick {t:12}: 0x{addr:03X} = {val}")
            prev_val = val

if __name__ == "__main__":
    scan_all("captures/streams/stream_1577974440", 0x051)
