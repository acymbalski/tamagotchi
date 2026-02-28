import json
import os
import memory_config

# Configuration
CAPTURES_DIR = "captures"
ANNOTATIONS_FILE = "annotations.json"
MEMORY_SIZE_BYTES = 0x140
NIBBLES_TOTAL = MEMORY_SIZE_BYTES * 2

class MemoryAnalyzer:
    def __init__(self):
        self.annotations = {}
        self.load_data()
        
        # Pull beliefs directly from the shared source of truth
        self.current_beliefs = memory_config.MAP

    def load_data(self):
        if os.path.exists(ANNOTATIONS_FILE):
            with open(ANNOTATIONS_FILE, 'r') as f:
                self.annotations = json.load(f)

    def get_ram(self, snap_name):
        path = os.path.join(CAPTURES_DIR, f"{snap_name}.bin")
        if not os.path.exists(path):
            return None
        with open(path, 'rb') as f:
            content = f.read()
            # RAM is the last 0x140 bytes
            raw_bytes = content[-MEMORY_SIZE_BYTES:]
            return raw_bytes # Return raw bytes, memory_config will handle nibbles

    def check_belief(self, attribute, truth_val, ram_bytes):
        # Use centralized decoding logic
        actual = memory_config.get_value(ram_bytes, attribute)
        
        # Handle time string comparison if needed
        if attribute == "time":
            # truth_val is "H:MM:SS AM/PM"
            return actual == truth_val, actual

        return actual == truth_val, actual

    def find_candidates(self, truth_val, ram_bytes):
        """Find every possible address/encoding that matches the truth."""
        candidates = []
        
        # 1. Single Nibble
        for i in range(NIBBLES_TOTAL):
            if memory_config.decode_nibble(ram_bytes, i) == truth_val:
                candidates.append((i, "nibble"))
        
        # 2. BCD (2 nibbles)
        if isinstance(truth_val, int) and 0 <= truth_val <= 99:
            for i in range(NIBBLES_TOTAL - 1):
                ones = memory_config.decode_nibble(ram_bytes, i)
                tens = memory_config.decode_nibble(ram_bytes, i+1)
                if (tens * 10 + ones) == truth_val:
                    candidates.append((i, "bcd"))
        
        # 3. Raw Byte (2 nibbles)
        if isinstance(truth_val, int) and 0 <= truth_val <= 255:
            for i in range(NIBBLES_TOTAL - 1):
                hi = memory_config.decode_nibble(ram_bytes, i)
                lo = memory_config.decode_nibble(ram_bytes, i+1)
                if ((hi << 4) | lo) == truth_val:
                    candidates.append((i, "byte"))
        
        # 4. Boolean
        if isinstance(truth_val, bool):
            for i in range(NIBBLES_TOTAL):
                val = memory_config.decode_nibble(ram_bytes, i)
                matches = (val != 0) if truth_val else (val == 0)
                if matches:
                    candidates.append((i, "bool"))
        
        return set(candidates)

    def run_analysis(self):
        print("=== Tamagotchi Memory Analysis Report ===\n")
        
        valid_snaps = {k: v for k, v in self.annotations.items() if v.get("truth")}
        
        if not valid_snaps:
            print("No annotated snapshots found. Go label some data in TIL!")
            return

        print(f"Analyzing {len(valid_snaps)} annotated snapshots...")

        attribute_candidates = {}
        belief_stats = {k: {"match": 0, "mismatch": 0} for k in self.current_beliefs}

        for name, data in valid_snaps.items():
            ram_bytes = self.get_ram(name)
            if not ram_bytes: continue
            
            truth = data["truth"]
            
            for attr, val in truth.items():
                # 1. Verify current beliefs
                if attr in self.current_beliefs:
                    is_correct, actual = self.check_belief(attr, val, ram_bytes)
                    if is_correct:
                        belief_stats[attr]["match"] += 1
                    else:
                        belief_stats[attr]["mismatch"] += 1
                
                # 2. Discovery: Update candidates
                current_snap_candidates = self.find_candidates(val, ram_bytes)
                
                if attr not in attribute_candidates:
                    attribute_candidates[attr] = current_snap_candidates
                else:
                    attribute_candidates[attr] &= current_snap_candidates

        print("\n--- Belief Verification ---")
        for attr, stats in belief_stats.items():
            total = stats["match"] + stats["mismatch"]
            if total == 0: continue
            accuracy = (stats["match"] / total) * 100
            status = "STRENGTHENED" if accuracy == 100 else "!! DOUBTED !!"
            print(f"[{status}] {attr:12}: {accuracy:3.0f}% accuracy ({stats['match']}/{total})")

        print("\n--- Discovery (Consistent Candidates) ---")
        for attr, candidates in attribute_candidates.items():
            print(f"{attr:12}: Found {len(candidates)} consistent candidates.")
            # Sort by address and print top 5
            sorted_cands = sorted(list(candidates))[:5]
            cand_str = ", ".join([f"0x{addr:03X} ({ctype})" for addr, ctype in sorted_cands])
            print(f"              Top picks: {cand_str}")
            if len(candidates) > 5:
                print(f"              ... and {len(candidates)-5} more.")

        print("\nAnalysis Complete.")

if __name__ == "__main__":
    analyzer = MemoryAnalyzer()
    analyzer.run_analysis()
