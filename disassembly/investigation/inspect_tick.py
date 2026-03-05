
import sys
import os
sys.path.append('tools')
from stream_reader import SegmentedTamStream

def inspect_tick(stream_path, tick):
    stream = SegmentedTamStream(stream_path)
    ram = stream.state_at_tick(tick)
    print(f"Memory at tick {tick}:")
    for a in range(0x000, 0x100):
        byte_idx = a >> 1
        val = (ram[byte_idx] >> 4) if (a & 1) == 0 else (ram[byte_idx] & 0x0F)
        print(f"{val:X}", end="")
        if (a+1) % 16 == 0:
            print(f"  (0x{a-15:03X}-0x{a:03X})")

if __name__ == "__main__":
    inspect_tick("captures/streams/stream_4105942035", 4929729715)
