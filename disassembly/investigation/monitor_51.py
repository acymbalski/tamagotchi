
import sys
import os
sys.path.append('tools')
from stream_reader import SegmentedTamStream

def monitor_51_52(stream_path):
    stream = SegmentedTamStream(stream_path)
    start, end = stream.tick_range
    
    # High resolution scan
    step = 32768 # 1 second
    
    prev_51 = -1
    prev_52 = -1
    for t in range(start, end, step):
        ram = stream.state_at_tick(t)
        v51 = (ram[0x051 >> 1] & 0x0F) if (0x051 & 1) else (ram[0x051 >> 1] >> 4)
        v52 = (ram[0x052 >> 1] & 0x0F) if (0x052 & 1) else (ram[0x052 >> 1] >> 4)
        
        if v51 != prev_51 or v52 != prev_52:
            print(f"Tick {t:12}: 0x051={v51:X}, 0x052={v52:X}")
            prev_51 = v51
            prev_52 = v52

if __name__ == "__main__":
    monitor_51_52("captures/streams/stream_1577974440")
