
import sys
import os
sys.path.append('tools')
from stream_reader import SegmentedTamStream

def find_events(stream_path):
    stream = SegmentedTamStream(stream_path)
    start, end = stream.tick_range
    
    step = 32768 * 60 # 1 minute
    
    prev_ram = None
    prev_att = 0
    for t in range(start, end, step):
        ram = stream.state_at_tick(t)
        att = (ram[0x02D >> 1] & 0x0F) if (0x02D & 1) else (ram[0x02D >> 1] >> 4)
        
        if prev_att != 0 and att == 0:
             print(f"Attention cleared at {t}:")
             # Print 0x50, 0x51, 0x52
             for a in range(0x050, 0x053):
                 byte_idx = a >> 1
                 val = (ram[byte_idx] >> 4) if (a & 1) == 0 else (ram[byte_idx] & 0x0F)
                 old_val = (prev_ram[byte_idx] >> 4) if (a & 1) == 0 else (prev_ram[byte_idx] & 0x0F)
                 print(f"  0x{a:03X}: 0x{old_val:X} -> 0x{val:X}")
             print("-" * 20)
             
        prev_att = att
        prev_ram = ram

if __name__ == "__main__":
    find_events("captures/streams/stream_1577974440")
