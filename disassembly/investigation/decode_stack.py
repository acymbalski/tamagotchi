
import sys
import os
sys.path.append('tools')
from stream_reader import TamStream, SegmentedTamStream

def decode_stack(stream_path):
    if os.path.isdir(stream_path):
        stream = SegmentedTamStream(stream_path)
    else:
        stream = TamStream(stream_path)
        
    last_tick = stream.tick_range[1]
    ram = stream.state_at_tick(last_tick)
    
    print(f"Decoding stack at tick {last_tick}:")
    # Stack typically grows down from 0x0FF
    stack_data = []
    for i in range(0x0C0, 0x100):
        byte_idx = i >> 1
        val = (ram[byte_idx] >> 4) if (i & 1) == 0 else (ram[byte_idx] & 0x0F)
        stack_data.append(val)
        
    # Stack entries are (PCP, PCSH, PCSL) starting from the highest address
    # But wait, SET_M(sp-1, PCP), SET_M(sp-2, PCSH), SET_M(sp-3, PCSL)
    # If sp was 0, it wrote to 0xFF, 0xFE, 0xFD.
    # So entry 1 is at [0xFF, 0xFE, 0xFD].
    # Entry 2 is at [0xFC, 0xFB, 0xFA].
    
    entries = []
    for i in range(255, 0x0C0, -3):
        if i-2 < 0x0C0: break
        pcp = stack_data[i - 0x0C0]
        pcsh = stack_data[i - 1 - 0x0C0]
        pcsl = stack_data[i - 2 - 0x0C0]
        addr = (pcp << 8) | (pcsh << 4) | pcsl
        entries.append((i, addr))
        
    for sp, addr in entries:
        if addr == 0: continue # Likely empty
        print(f"  SP 0x{sp:02X}: Return to 0x{addr:03X}")

if __name__ == "__main__":
    decode_stack("captures/streams/stream_1577974440")
