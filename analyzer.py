import json
import os
import argparse
from collections import Counter
import memory_config

# Maps the annotated stage string → numeric fields used for memory discovery.
# life_stage: the broad lifecycle position (0=egg_new through 7=dead).
#   Egg (New) and Egg (Init) are kept distinct so analysis can determine whether
#   the ROM encodes them as the same nibble value or different ones.
# char_id: which character within that stage (0-indexed per stage).
#   Single-variant stages all get char_id=0.
#   These are analysis labels, NOT assumed ROM values.
STAGE_MAP = {
    "Egg (New)":                  {"life_stage": 0, "char_id": 0},
    "Egg (Init)":                 {"life_stage": 1, "char_id": 0},
    "Babitchi (Baby)":            {"life_stage": 2, "char_id": 0},
    "Marutchi (Child)":           {"life_stage": 3, "char_id": 0},
    "Tamatchi (Teen)":            {"life_stage": 4, "char_id": 0},
    "KuchiTamatchi (Teen)":       {"life_stage": 4, "char_id": 1},
    "Mametchi (Adult)":           {"life_stage": 5, "char_id": 0},
    "Ginjirotchi (Adult)":        {"life_stage": 5, "char_id": 1},
    "Maskutchi (Adult)":          {"life_stage": 5, "char_id": 2},
    "Kuchipatchi (Adult)":        {"life_stage": 5, "char_id": 3},
    "Nyorotchi (Adult)":          {"life_stage": 5, "char_id": 4},
    "Tarakotchi (Adult)":         {"life_stage": 5, "char_id": 5},
    "Oyajitchi (Senior)":         {"life_stage": 6, "char_id": 0},
    "Bill [Gaijintchi] (Senior)": {"life_stage": 6, "char_id": 1},
    "Bill [Ketotchi] (Senior)":   {"life_stage": 6, "char_id": 2},
    "Bill [Unknown] (Senior)":    {"life_stage": 6, "char_id": 3},
    "Angel (Dead)":               {"life_stage": 7, "char_id": 0},
}

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
        # Silently expand each annotated "stage" string into numeric fields.
        # Done in-memory only; annotations.json is never modified.
        for data in self.annotations.values():
            truth = data.get("truth", {})
            if "stage" in truth and truth["stage"] in STAGE_MAP:
                decomp = STAGE_MAP[truth["stage"]]
                truth["life_stage"] = decomp["life_stage"]
                truth["char_id"]    = decomp["char_id"]

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
        # Only track beliefs for fields with a known (non-None) address
        belief_stats = {k: {"match": 0, "mismatch": 0}
                        for k, v in self.current_beliefs.items()
                        if v.get("addr") is not None}

        for name, data in valid_snaps.items():
            ram_bytes = self.get_ram(name)
            if not ram_bytes: continue

            truth = data["truth"]

            for attr, val in truth.items():
                # 1. Verify current beliefs (skip entries with addr=None)
                if (attr in self.current_beliefs
                        and self.current_beliefs[attr].get("addr") is not None):
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

        print("\n--- Time/Sleep Consistency Checks ---")
        _SLEEP_WINDOWS_ANALYSIS = {
            3: (20, 9),   # Child: 8pm – 9am
            4: (21, 9),   # Teen: 9pm – 9am
            5: (22, 9),   # Adult: 10pm – 9am
            6: (22, 9),   # Senior: 10pm – 9am
        }
        inconsistent_count = 0
        for name, data in valid_snaps.items():
            truth = data.get("truth", {})
            life_stage = truth.get("life_stage")
            if life_stage not in _SLEEP_WINDOWS_ANALYSIS:
                continue
            if "sleeping" not in truth or "time" not in truth:
                continue
            try:
                parts_t = truth["time"].split(" ")
                h12 = int(parts_t[0].split(":")[0])
                ampm = parts_t[1]
                h24 = (0 if h12 == 12 else h12) if ampm == "AM" else (12 if h12 == 12 else h12 + 12)
            except Exception:
                continue
            ss, we = _SLEEP_WINDOWS_ANALYSIS[life_stage]
            in_win = (h24 >= ss or h24 < we)
            if truth["sleeping"] != in_win:
                stage_name = truth.get("stage", f"life_stage={life_stage}")
                action = "sleeping" if truth["sleeping"] else "awake"
                print(f"  [WARN] {name}: {stage_name} is {action} at {truth['time']} "
                      f"(expected {'asleep' if in_win else 'awake'})")
                inconsistent_count += 1
        if inconsistent_count == 0:
            print("  All annotated time+sleep+stage combinations are consistent.")

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

    # =========================================================================
    # Field-by-Field Analysis Engine (Section 6 of REVERSE_ENGINEERING_GUIDE.md)
    # =========================================================================

    def invariant_addresses(self):
        """Return set of nibble addresses whose value never changes across all annotated captures."""
        value_sets = {}
        for name, data in self.annotations.items():
            if not data.get("truth"):
                continue
            ram = self.get_ram(name)
            if not ram:
                continue
            for addr in range(NIBBLES_TOTAL):
                val = memory_config.decode_nibble(ram, addr)
                if addr not in value_sets:
                    value_sets[addr] = set()
                value_sets[addr].add(val)
        return {addr for addr, vals in value_sets.items() if len(vals) == 1}

    def group_by_value(self, attr):
        """Returns { value -> [(snap_name, ram_bytes), ...] } for all snaps annotated with attr."""
        groups = {}
        for name, data in self.annotations.items():
            truth = data.get("truth", {})
            if attr not in truth:
                continue
            val = truth[attr]
            ram = self.get_ram(name)
            if ram is None:
                continue
            if val not in groups:
                groups[val] = []
            groups[val].append((name, ram))
        return groups

    def within_group_stacking(self, captures, invariants):
        """
        For a set of captures sharing the same truth value, find internally-consistent addresses.

        Returns four dicts:
          single_consistent  -- { addr -> nibble_value }  all captures agree
          pair_consistent    -- { (addr, type) -> decoded_value }  all captures agree
          single_near_misses -- { addr -> (nibble_value, [outlier_snap_names]) }  all-but-one agree
          pair_near_misses   -- { (addr, type) -> (decoded_value, [outlier_snap_names]) }
        """
        if not captures:
            return {}, {}, {}, {}

        # --- Single nibble ---
        addr_snaps = {}  # addr -> [(snap_name, nibble_val)]
        for snap_name, ram in captures:
            for addr in range(NIBBLES_TOTAL):
                if addr in invariants:
                    continue
                nval = memory_config.decode_nibble(ram, addr)
                if addr not in addr_snaps:
                    addr_snaps[addr] = []
                addr_snaps[addr].append((snap_name, nval))

        single_consistent = {}
        single_near_misses = {}
        for addr, snap_vals in addr_snaps.items():
            n = len(snap_vals)
            vals = [v for _, v in snap_vals]
            val_set = set(vals)

            if len(val_set) == 1:
                single_consistent[addr] = vals[0]
            elif n >= 3:
                counts = Counter(vals)
                most_common = counts.most_common()
                majority_val, majority_count = most_common[0]
                minority_val, minority_count = most_common[-1]
                if minority_count == 1 and majority_count == n - 1:
                    outlier_snaps = [s for s, v in snap_vals if v == minority_val]
                    single_near_misses[addr] = (majority_val, outlier_snaps)

        # --- Pairs (BCD and byte) ---
        pair_snaps = {}  # (addr, type) -> [(snap_name, decoded_val)]
        for snap_name, ram in captures:
            for addr in range(NIBBLES_TOTAL - 1):
                n1 = memory_config.decode_nibble(ram, addr)      # ones / hi
                n2 = memory_config.decode_nibble(ram, addr + 1)  # tens / lo

                bcd_val = n2 * 10 + n1   # ones at addr, tens at addr+1
                bkey = (addr, "bcd")
                if bkey not in pair_snaps:
                    pair_snaps[bkey] = []
                pair_snaps[bkey].append((snap_name, bcd_val))

                byte_val = (n1 << 4) | n2  # hi at addr, lo at addr+1
                bykey = (addr, "byte")
                if bykey not in pair_snaps:
                    pair_snaps[bykey] = []
                pair_snaps[bykey].append((snap_name, byte_val))

        pair_consistent = {}
        pair_near_misses = {}
        for key, snap_vals in pair_snaps.items():
            n = len(snap_vals)
            vals = [v for _, v in snap_vals]
            val_set = set(vals)

            if len(val_set) == 1:
                pair_consistent[key] = vals[0]
            elif n >= 3:
                counts = Counter(vals)
                most_common = counts.most_common()
                majority_val, majority_count = most_common[0]
                minority_val, minority_count = most_common[-1]
                if minority_count == 1 and majority_count == n - 1:
                    outlier_snaps = [s for s, v in snap_vals if v == minority_val]
                    pair_near_misses[key] = (majority_val, outlier_snaps)

        return single_consistent, pair_consistent, single_near_misses, pair_near_misses

    def _rank_correlation(self, truth_vals, nibble_vals):
        """Spearman rank correlation between two parallel lists of numeric values."""
        n = len(truth_vals)
        if n < 2:
            return 0.0

        def rank_list(vals):
            sorted_idx = sorted(range(n), key=lambda i: vals[i])
            ranks = [0.0] * n
            i = 0
            while i < n:
                j = i + 1
                while j < n and vals[sorted_idx[j]] == vals[sorted_idx[i]]:
                    j += 1
                avg = (i + j - 1) / 2.0
                for k in range(i, j):
                    ranks[sorted_idx[k]] = avg
                i = j
            return ranks

        tr = rank_list(truth_vals)
        nr = rank_list(nibble_vals)
        mean_t = sum(tr) / n
        mean_n = sum(nr) / n
        num = sum((tr[i] - mean_t) * (nr[i] - mean_n) for i in range(n))
        den_t = sum((tr[i] - mean_t) ** 2 for i in range(n)) ** 0.5
        den_n = sum((nr[i] - mean_n) ** 2 for i in range(n)) ** 0.5
        if den_t == 0 or den_n == 0:
            return 0.0
        return num / (den_t * den_n)

    def cross_validate(self, group_consistent_single, group_consistent_pair,
                       group_near_single, group_near_pair, group_sizes, attr):
        """
        Cross-validate candidates across all truth-value groups.

        Inputs (all keyed by truth value):
          group_consistent_single -- { tv -> { addr -> nibble_val } }
          group_consistent_pair   -- { tv -> { (addr,type) -> decoded_val } }
          group_near_single       -- { tv -> { addr -> (nibble_val, [outliers]) } }
          group_near_pair         -- { tv -> { (addr,type) -> (decoded_val, [outliers]) } }
          group_sizes             -- { tv -> n_captures }

        Returns list of result dicts sorted by confidence desc then |correlation| desc:
          { addr, type, value_map, confidence, correlation, outlier_info, near_miss }
        """
        # Only groups with >=2 captures contribute to confidence
        valid_groups = {v for v, n in group_sizes.items() if n >= 2}
        # All groups with any annotation data
        all_truth_vals = set(group_consistent_single) | set(group_near_single)

        if len(all_truth_vals) < 2:
            return []  # Need >=2 distinct values for cross-group contrast

        results = []

        # --- Single nibble candidates ---
        candidate_addrs = set()
        for gsc in group_consistent_single.values():
            candidate_addrs |= set(gsc)
        for gns in group_near_single.values():
            candidate_addrs |= set(gns)

        for addr in candidate_addrs:
            value_map = {}        # truth_val -> nibble_val
            consistent_count = 0
            near_miss_count = 0
            outlier_info = []

            for truth_val in valid_groups:
                gsc = group_consistent_single.get(truth_val, {})
                gns = group_near_single.get(truth_val, {})
                if addr in gsc:
                    value_map[truth_val] = gsc[addr]
                    consistent_count += 1
                elif addr in gns:
                    nibble_val, outliers = gns[addr]
                    value_map[truth_val] = nibble_val
                    near_miss_count += 1
                    outlier_info.extend(outliers)

            # Enrich value_map with single-capture groups (no confidence credit)
            for truth_val in all_truth_vals - valid_groups:
                gsc = group_consistent_single.get(truth_val, {})
                if addr in gsc:
                    value_map[truth_val] = gsc[addr]

            if not valid_groups:
                continue
            confidence = (consistent_count + near_miss_count) / len(valid_groups)
            if confidence < 0.8:
                continue

            # Contrast: nibble values must differ across groups
            if len(set(value_map.values())) <= 1:
                continue  # Spurious invariant

            numeric_pairs = [(tv, nv) for tv, nv in value_map.items()
                             if isinstance(tv, (int, float))]
            correlation = 0.0
            if len(numeric_pairs) >= 3:
                correlation = self._rank_correlation(
                    [t for t, _ in numeric_pairs],
                    [n for _, n in numeric_pairs]
                )

            results.append({
                "addr": addr,
                "type": "nibble",
                "value_map": value_map,
                "confidence": confidence,
                "correlation": correlation,
                "outlier_info": sorted(set(outlier_info)),
                "near_miss": near_miss_count > 0,
            })

        # --- Pair candidates (BCD and byte) ---
        candidate_pairs = set()
        for gpc in group_consistent_pair.values():
            candidate_pairs |= set(gpc)
        for gnp in group_near_pair.values():
            candidate_pairs |= set(gnp)

        for pair_key in candidate_pairs:
            value_map = {}
            consistent_count = 0
            near_miss_count = 0
            outlier_info = []

            for truth_val in valid_groups:
                gpc = group_consistent_pair.get(truth_val, {})
                gnp = group_near_pair.get(truth_val, {})
                if pair_key in gpc:
                    value_map[truth_val] = gpc[pair_key]
                    consistent_count += 1
                elif pair_key in gnp:
                    decoded_val, outliers = gnp[pair_key]
                    value_map[truth_val] = decoded_val
                    near_miss_count += 1
                    outlier_info.extend(outliers)

            for truth_val in all_truth_vals - valid_groups:
                gpc = group_consistent_pair.get(truth_val, {})
                if pair_key in gpc:
                    value_map[truth_val] = gpc[pair_key]

            if not valid_groups:
                continue
            confidence = (consistent_count + near_miss_count) / len(valid_groups)
            if confidence < 0.8:
                continue

            if len(set(value_map.values())) <= 1:
                continue  # Spurious invariant (decoded value same across all groups)

            addr, ptype = pair_key
            numeric_pairs_data = [(tv, dv) for tv, dv in value_map.items()
                                   if isinstance(tv, (int, float))]
            correlation = 0.0
            if len(numeric_pairs_data) >= 3:
                correlation = self._rank_correlation(
                    [t for t, _ in numeric_pairs_data],
                    [d for _, d in numeric_pairs_data]
                )

            results.append({
                "addr": addr,
                "type": ptype,
                "value_map": value_map,
                "confidence": confidence,
                "correlation": correlation,
                "outlier_info": sorted(set(outlier_info)),
                "near_miss": near_miss_count > 0,
            })

        results.sort(key=lambda r: (-r["confidence"], -abs(r["correlation"]), r["addr"]))
        return results

    def run_field_analysis(self, target_attr=None):
        print("=== Field-by-Field Analysis ===\n")

        if not self.annotations:
            print("No annotated snapshots found. Go label some data in TIL!")
            return

        print("Computing invariant addresses...")
        invariants = self.invariant_addresses()
        print(f"Found {len(invariants)} invariant (never-changing) addresses -- excluded from search.\n")

        all_attrs = set()
        for data in self.annotations.values():
            all_attrs.update(data.get("truth", {}).keys())

        if not all_attrs:
            print("No truth annotations found in any snapshot.")
            return

        if target_attr is not None:
            if target_attr not in all_attrs:
                print(f"No annotations found for '{target_attr}'.")
                print(f"Available fields: {sorted(all_attrs)}")
                return
            attrs_to_analyze = [target_attr]
        else:
            attrs_to_analyze = sorted(all_attrs)

        for attr in attrs_to_analyze:
            self._analyze_field(attr, invariants)

        print("Field analysis complete.")

    def _analyze_field(self, attr, invariants):
        print(f"{'=' * 60}")
        print(f"Field: {attr}")
        print(f"{'=' * 60}")

        groups = self.group_by_value(attr)
        if not groups:
            print("  No annotated captures found.\n")
            return

        try:
            sorted_keys = sorted(groups.keys())
        except TypeError:
            sorted_keys = sorted(groups.keys(), key=str)

        group_sizes = {val: len(caps) for val, caps in groups.items()}
        valid_groups = {v for v, n in group_sizes.items() if n >= 2}

        print("  Value distribution:")
        for val in sorted_keys:
            n = group_sizes[val]
            flag = "  (! <2 captures, excluded from confidence)" if n < 2 else ""
            print(f"    {str(val):>14} -> {n} capture(s){flag}")
        total = sum(group_sizes.values())
        print(f"  Total: {total} captures across {len(groups)} distinct values.\n")

        if len(groups) < 2:
            print("  Need >=2 distinct values for cross-group contrast -- skipping.\n")
            return

        # Within-group stacking
        group_consistent_single = {}
        group_consistent_pair   = {}
        group_near_single       = {}
        group_near_pair         = {}

        for val, captures in groups.items():
            sc, pc, sns, pns = self.within_group_stacking(captures, invariants)
            group_consistent_single[val] = sc
            group_consistent_pair[val]   = pc
            group_near_single[val]       = sns
            group_near_pair[val]         = pns

        print("  Within-group stacking results:")
        for val in sorted_keys:
            sc  = group_consistent_single[val]
            pc  = group_consistent_pair[val]
            sns = group_near_single[val]
            pns = group_near_pair[val]
            vflag = "" if group_sizes[val] >= 2 else " [single-capture]"
            print(f"    {str(val):>6}{vflag}: "
                  f"{len(sc):4d} single-consistent, "
                  f"{len(pc):4d} pair-consistent, "
                  f"{len(sns):3d} single-near-miss, "
                  f"{len(pns):3d} pair-near-miss")
        print()

        # Cross-validate
        results = self.cross_validate(
            group_consistent_single, group_consistent_pair,
            group_near_single, group_near_pair,
            group_sizes, attr
        )

        if not results:
            print("  No candidates survived cross-validation.\n")
        else:
            strong   = [r for r in results if r["confidence"] >= 1.0 and not r["near_miss"]]
            plausible = [r for r in results if not (r["confidence"] >= 1.0 and not r["near_miss"])]

            def fmt_val_map(vm):
                try:
                    items = sorted(vm.items())
                except TypeError:
                    items = sorted(vm.items(), key=lambda x: str(x[0]))
                return "  ".join(f"{tv}->{nv}" for tv, nv in items)

            def fmt_addr(r):
                return f"0x{r['addr']:03X} ({r['type']})"

            if strong:
                print(f"  STRONG candidates ({len(strong)}) -- 100% consistent, values differ:")
                for r in strong[:15]:
                    corr = f"  r={r['correlation']:+.2f}" if abs(r["correlation"]) > 0.01 else ""
                    print(f"    {fmt_addr(r):22}  {fmt_val_map(r['value_map'])}{corr}")

            if plausible:
                print(f"  PLAUSIBLE candidates ({len(plausible)}) -- >=80% consistent:")
                for r in plausible[:8]:
                    corr = f"  r={r['correlation']:+.2f}" if abs(r["correlation"]) > 0.01 else ""
                    pct = f"{r['confidence'] * 100:.0f}%"
                    outliers = (f"  [suspected annotation errors: {', '.join(r['outlier_info'])}]"
                                if r["outlier_info"] else "")
                    print(f"    {fmt_addr(r):22}  {pct}  {fmt_val_map(r['value_map'])}{corr}{outliers}")
            print()

        # Cross-reference against known beliefs
        if attr in self.current_beliefs:
            belief = self.current_beliefs[attr]
            known_addr = belief["addr"]
            known_type = belief["type"]
            if known_addr is None:
                print(f"  Address not yet discovered — run divergent-care captures then re-analyze.")
            else:
                found = next((r for r in results if r["addr"] == known_addr), None)
                if found:
                    pct = f"{found['confidence'] * 100:.0f}%"
                    label = ("CONFIRMED (strong)"
                             if found["confidence"] >= 1.0 and not found["near_miss"]
                             else f"PLAUSIBLE ({pct})")
                    print(f"  Known 0x{known_addr:03X} ({known_type}): {label}")
                    try:
                        vm_items = sorted(found["value_map"].items())
                    except TypeError:
                        vm_items = sorted(found["value_map"].items(), key=lambda x: str(x[0]))
                    vm_str = "  ".join(f"{tv}->{nv}" for tv, nv in vm_items)
                    print(f"  Value map: {vm_str}")
                else:
                    print(f"  Known 0x{known_addr:03X} ({known_type}): NOT in candidates")
                    print(f"  (excluded as invariant, or insufficient cross-group data)")
            print()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Tamagotchi Memory Analyzer")
    parser.add_argument(
        "--field", metavar="ATTR",
        help="Run focused field-by-field analysis for a specific attribute (e.g. hunger, stage)."
             " Omit to run the original global analysis."
    )
    args = parser.parse_args()

    analyzer = MemoryAnalyzer()
    if args.field:
        analyzer.run_field_analysis(target_attr=args.field)
    else:
        analyzer.run_analysis()
