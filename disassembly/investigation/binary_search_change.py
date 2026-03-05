import sys
import os
sys.path.append('tools')
from stream_reader import SegmentedTamStream

def find_change(stream_path, addr):
    stream = SegmentedTamStream(stream_path)
    start, end = stream.tick_range
    
    low = start
    high = end
    
    ram_start = stream.state_at_tick(start)
    v_start = (ram_start[addr >> 1] & 0x0F) if (addr & 1) else (ram_start[addr >> 1] >> 4)
    
    ram_end = stream.state_at_tick(end)
    v_end = (ram_end[addr >> 1] & 0x0F) if (addr & 1) else (ram_end[addr >> 1] >> 4)
    
    if v_start == v_end:
        print(f"No change in 0x{addr:03X} (value {v_start})")
        return

    print(f"Binary searching for change in 0x{addr:03X}...")
    
    while high - low > 1:
        mid = (low + high) // 2
        try:
            ram_mid = stream.state_at_tick(mid)
            v_mid = (ram_mid[addr >> 1] & 0x0F) if (addr & 1) else (ram_mid[addr >> 1] >> 4)
            
            if v_mid == v_start:
                low = mid
            else:
                high = mid
        except Exception:
            # handle gaps in stream
            low = mid
            
    print(f"Change detected at tick {high}")
    # Show memory around this tick
    ram_before = stream.state_at_tick(low)
    ram_after = stream.state_at_tick(high)
    v_before = (ram_before[addr >> 1] & 0x0F) if (addr & 1) else (ram_before[addr >> 1] >> 4)
    v_after = (ram_after[addr >> 1] & 0x0F) if (addr & 1) else (ram_after[addr >> 1] >> 4)
    print(f"Value: {v_before} -> {v_after}")
    
    # Check 0x2D (Attention)
    att_before = (ram_before[0x02D >> 1] >> 4) if (0x02D & 1) == 0 else (ram_before[0x02D >> 1] & 0x0F)
    att_after = (ram_after[0x02D >> 1] >> 4) if (0x02D & 1) == 0 else (ram_after[0x02D >> 1] & 0x0F)
    print(f"Attention: {att_before} -> {att_after}")
    
    # Check Hunger/Happy
    h_before = (ram_before[0x040 >> 1] >> 4) if (0x040 & 1) == 0 else (ram_before[0x040 >> 1] & 0x0F)
    h_after = (ram_after[0x040 >> 1] >> 4) if (0x040 & 1) == 0 else (ram_after[0x040 >> 1] & 0x0F)
    print(f"Hunger: {h_before} -> {h_after}")

if __name__ == "__main__":
    path = sys.argv[1]
    addr = int(sys.argv[2], 16)
    find_change(path, addr)
