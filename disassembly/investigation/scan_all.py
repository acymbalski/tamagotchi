
import sys
import os
sys.path.append('tools')
from stream_reader import SegmentedTamStream

def scan_all_streams(base_dir, addr):
    for entry in os.listdir(base_dir):
        path = os.path.join(base_dir, entry)
        if os.path.isdir(path) and entry.startswith("stream_"):
            try:
                stream = SegmentedTamStream(path)
                start, end = stream.tick_range
                # check last state
                ram = stream.state_at_tick(end)
                val = (ram[addr >> 1] & 0x0F) if (addr & 1) else (ram[addr >> 1] >> 4)
                if val != 0:
                    print(f"Stream {entry}: 0x{addr:03X} = {val}")
            except Exception:
                pass

if __name__ == "__main__":
    scan_all_streams("captures/streams", 0x042)
    print("Done 0x42")
    scan_all_streams("captures/streams", 0x051)
    print("Done 0x051")
