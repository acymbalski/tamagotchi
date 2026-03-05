import sys
import os
sys.path.append('tools')
from stream_reader import SegmentedTamStream

def find_events(stream_path):
    stream = SegmentedTamStream(stream_path)
    start, end = stream.tick_range
    
    # Sample every 1 minute (emu time) to be precise
    step = 32768 * 60
    
    prev_ram = None
    prev_att = 0
    for t in range(start, end, step):
        ram = stream.state_at_tick(t)
        att = (ram[0x02D >> 1] & 0x0F) if (0x02D & 1) else (ram[0x02D >> 1] >> 4)
        
        # Print if attention turned OFF
        if prev_att != 0 and att == 0:
             print(f"Attention cleared at {t}:")
             diffs = []
             for a in range(len(ram) * 2):
                 byte_idx = a >> 1
                 val = (ram[byte_idx] >> 4) if (a & 1) == 0 else (ram[byte_idx] & 0x0F)
                 old_val = (prev_ram[byte_idx] >> 4) if (a & 1) == 0 else (prev_ram[byte_idx] & 0x0F)
                 if val != old_val:
                     diffs.append((a, old_val, val))
             
             for a, old, new in diffs:
                 if a in range(0x060, 0x080): continue # Skip stack
                 print(f"  0x{a:03X}: 0x{old:X} -> 0x{new:X}")
             print("-" * 20)
             
        prev_att = att
        prev_ram = ram

if __name__ == "__main__":
    find_events("captures/streams/stream_1577974440")
