import os
import struct
import glob

dirpath = r"C:/projects/tamagotchi/captures/streams/stream_1577974440"
seg_files = sorted(glob.glob(os.path.join(dirpath, "seg_*.tamstream")))

print(f"Total segments found by glob: {len(seg_files)}")

for i, path in enumerate(seg_files):
    with open(path, 'rb') as f:
        header = f.read(16)
        version = struct.unpack_from("<H", header, 4)[0]
        start_tick = struct.unpack_from("<I", header, 6)[0]
        compression = header[12] if version >= 3 else 0
        
        # Check TIDX at the end
        f.seek(-8, 2)
        idx_start = struct.unpack("<Q", f.read(8))[0]
        f.seek(idx_start)
        magic = f.read(4)
        if magic == b"TIDX":
            count = struct.unpack("<I", f.read(4))[0]
            if count > 0:
                # Read first and last entry
                first_entry = f.read(13)
                f.seek(idx_start + 8 + (count-1)*13)
                last_entry = f.read(13)
                t0 = struct.unpack_from("<I", first_entry, 0)[0]
                t1 = struct.unpack_from("<I", last_entry, 0)[0]
            else:
                t0, t1 = "N/A", "N/A"
        else:
            t0, t1 = "No TIDX", "No TIDX"
            
        if i < 5 or i > len(seg_files) - 5 or i in [20, 21, 22]:
            print(f"Seg {i:03d}: Version={version}, Compression={compression}, HeaderStart={start_tick}, TIDX_Ticks={t0}-{t1}")
