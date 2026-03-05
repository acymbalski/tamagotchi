
import sys
import os
sys.path.append('tools')
from stream_reader import TamStream, RAM_BYTES, SegmentedTamStream

def dump_at_ticks(stream, ticks):
    for t in ticks:
        ram = stream.state_at_tick(t)
        print(f"RAM at tick {t}:")
        for i in range(0x0D0, 0x100):
            byte_idx = i >> 1
            if (i & 1) == 0:
                val = (ram[byte_idx] >> 4) & 0x0F
            else:
                val = ram[byte_idx] & 0x0F
            print(f"{val:X}", end="")
            if (i + 1) % 16 == 0:
                print(f"  (0x{i-15:03X}-0x{i:03X})")
        print()

if __name__ == "__main__":
    if len(sys.argv) > 1:
        path = sys.argv[1]
    else:
        path = "captures/streams/stream_1577974440"
        
    if os.path.isdir(path):
        stream = SegmentedTamStream(path)
    else:
        stream = TamStream(path)
        
    start, end = stream.tick_range
    # Sample at 5 points
    ticks = [start + (end - start) * i // 4 for i in range(5)]
    dump_at_ticks(stream, ticks)
