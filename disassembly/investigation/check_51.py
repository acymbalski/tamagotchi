import sys
import os
sys.path.append('tools')
from stream_reader import SegmentedTamStream

def check_51(stream_path):
    stream = SegmentedTamStream(stream_path)
    start, end = stream.tick_range
    print(f"Stream range: {start} to {end}")
    
    # Sample every minute
    step = 32768 * 60
    
    prev_51 = -1
    for t in range(start, end, step):
        ram = stream.state_at_tick(t)
        v51 = (ram[0x051 >> 1] & 0x0F) if (0x051 & 1) else (ram[0x051 >> 1] >> 4)
        if v51 != prev_51:
            print(f"Tick {t:12}: 0x051={v51}")
            prev_51 = v51

if __name__ == "__main__":
    path = sys.argv[1] if len(sys.argv) > 1 else "captures/streams/stream_4105942035"
    check_51(path)
