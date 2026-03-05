
import sys
import os
sys.path.append('tools')
from stream_reader import TamStream, SegmentedTamStream

def dump_range(stream_path, start, end):
    if os.path.isdir(stream_path):
        stream = SegmentedTamStream(stream_path)
    else:
        stream = TamStream(stream_path)
    
    start_tick, end_tick = stream.tick_range
    # Look at 5 points
    for i in range(5):
        t = start_tick + (end_tick - start_tick) * i // 4
        ram = stream.state_at_tick(t)
        print(f"Tick {t}:")
        for addr in range(start, end + 1):
            byte_idx = addr >> 1
            val = (ram[byte_idx] >> 4) if (addr & 1) == 0 else (ram[byte_idx] & 0x0F)
            print(f"  0x{addr:03X}: 0x{val:X}")
        print("-" * 10)

if __name__ == "__main__":
    dump_range("captures/streams/stream_1577974440", 0x028, 0x030)
