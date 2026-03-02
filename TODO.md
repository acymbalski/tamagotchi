- [x] Should not trigger babysitting if in egg state

- [x] Should auto-set time on reset (i.e. should transition from brand new egg -> alive without user input)

- [x] Update README

- [x] Add instructions for building PC sim

- [x] Add option for PC sim to reset sim

- [ ] Review eggInitiated flag (babysitter.cpp) when implementing tama death/restart. When the tama dies and a new egg starts, eggInitiated will be true from the previous life cycle and the new egg will never be auto-hatched. Need to detect the death-to-new-egg transition and call resetBabysitterState() at the right moment. **NOTE (confirmed via captures):** The ROM transitions directly from lifecycle=9 (Adult) to lifecycle=1 (Baby) — it does NOT pass through lifecycle=0 (Egg). So `isTamaEgg()` never fires on death. Detection must look for the Adult→Baby lifecycle jump instead.

- [ ] Defensive test cases (likely requires more robust state/screen detection as well as a collection of saved RAM states)

- [ ] Add additional care states - possibly a percentage of care and an additional 'let die' flag. At low percentages, care is less good - snacks are picked, discipline is slow, etc. At 100%, care is perfect. Still may need to have reactive/proactive options. Poor care may fail the game

- [ ] Add bounds for wavering care. i.e. low bound 20% high bound 50% means the care percentage fluctuates (slowly) from 20 to 50 randomly along some curve, randomly. So there is an option to let the tama have some degree of randomness - some good, some bad, etc.

- [ ] Add random left/right for game

- [ ] If manual control is taken, ensure we know "where" we are before we start launching more commands

- [ ] Food menu selection (Meal/Snack) persists. We will need a way to detect that cursor location

- [ ] Allow a "fake" babysitter that will just literally set hunger/poop/happy values so we won't die and can sim forever

- [x] Investigator - Moving forward, then back (no changes/commit) will save an annotation with a mod on "Screen" and "Stage" (as Main/Unknown)

- [ ] In some cases, when falling asleep and Attention is requested (or something?), Discipline will cycle from 0-3 (or maybe 4?) and back again

---

## Babysitter Gaps (from game rules — see GAME_RULES.md)

- [ ] **Implement disciplineTama()** — currently a stub. Must select the Discipline icon and
      confirm. Only call it when the attention flag is set AND both hunger AND happy are
      non-zero (otherwise it is a care call, not a discipline call). See GAME_RULES.md for
      the 25%-per-call mechanic and per-stage call limits.

- [ ] **Distinguish care call vs. discipline call** — when the attention icon lights up,
      babysitterLoop() must check whether hunger/happy are empty (→ feed/play) or full
      (→ discipline). Currently PROACTIVE mode only feeds/plays and never disciplines,
      meaning every discipline call is a missed discipline mistake.

- [ ] **Light management** — toggleLights() exists but is never called. When isTamaSleeping()
      becomes true, lights must be turned OFF within the 15-minute window or it counts as a
      care mistake. When the tama wakes, lights should be turned back ON so the screen is
      visible. Add sleep-state tracking (prev vs. current) to detect the transition.

- [ ] **Death detection** — isTamaDead() is a stub returning false. Find the death RAM address
      (likely a flag near 0x05D) via the investigation toolchain, then implement it. Used by
      the eggInitiated reset fix above, and needed for the babysitter to stop acting after death.

- [ ] **Post-death restart handling** — once death is detected, call resetBabysitterState() so
      the next egg auto-hatches. The A+C button combo starts a new egg on the real device; on
      the emulator this may need to be a direct memory reset instead.

- [ ] **Baby poop vigilance** — baby poos at ~15 min and ~40–45 min after hatching (before
      any 3-hour cycle exists). Babysitter should poll more aggressively during the first 65
      minutes, or at least guarantee a poop-check pass around those timestamps.

- [ ] **Prefer game over snacks for happiness** — PROACTIVE mode currently feeds snacks to
      raise happiness (feedTamaSnack). Per game rules, snacks add +2 weight and risk illness;
      game adds +1 happy AND reduces weight by 1. Babysitter should prefer playTamaGame()
      for happy, use snacks only if game is unavailable (e.g. tama is sleeping or sick).

- [ ] **Track / expose care and discipline mistake counts** — once MEM_LOC_CARE_MISTAKES and
      the discipline-mistake address are found via analyzer.py, log them in babysitterLoop()
      and expose them in the PC sim stats panel. This lets us verify the babysitter is
      achieving 0 mistakes (→ Mametchi path).

- [ ] **Verify 15-minute response window is always met** — RESPONSIVENESS is currently set so
      checks happen roughly every ~1 emulated minute, which should be well within the 15-min
      window. Confirm this math holds at all speed ratios (turbo mode especially) and that
      babysitterLoop() is not skipped during animations or button simulation sequences.

---

## Reverse Engineering TODOs (from game rules)

- [ ] **Find care_mistakes address** — see GAME_RULES.md: a mistake is logged when hunger OR
      happy = 0 and goes unattended for 15 min. Delta analysis: capture before/after a
      deliberate neglect event. (MEM_LOC_CARE_MISTAKES is currently 0x3FF sentinel.)

- [ ] **Find discipline_mistakes address** — separate counter from care mistakes. Increments
      when a discipline call (attention=1, both meters non-empty) times out. Run a divergent
      discipline run and use analyzer.py delta analysis.

- [ ] **Find life_stage address** — need egg_init + teen + adult captures to break the
      current false correlation with the age address. See REVERSE_ENGINEERING_GUIDE.md.

- [ ] **Find char_id address** — needs two runs diverging at the teen stage (one good care
      → Tamatchi, one bad care → Kuchitamatchi) annotated in TIL, then
      python analyzer.py --field char_id.

- [ ] **Validate age address (0x054)** — game rules confirm: age increments on wakeup (one
      year per day). Cross-check that captured age values align with wakeup events, not
      real-time elapsed. The current 100% confidence is strong but based on a limited dataset.

- [ ] **Sickness is a 4-address system** — Confirmed via delta analysis (see INVESTIGATION_SICKNESS.md):
      - `0x049` = derived visible sick flag (ROM re-asserts this from `0x06D`)
      - `0x06D` = authoritative sick register (lower nibble of byte 0x036); root of Force mode oscillation
      - `0x048` = illness level counter (0xF=max sick, decreases with medicine, ~5 at cure)
      - `0x0F3` = death timer (counts up naturally, medicine resets it, 0=cured)
      To fix Force mode oscillation: clear all four. DO NOT write `0x06C` (upper nibble of byte 0x036) —
      it is not a stable data register and corrupts the ROM when written. Fix blocked on death-rebirth
      freeze (tama must survive long enough to observe steady-state behaviour). Display raw values
      of all four in the PC sim stats panel. NOTE: This is not proven.

- [ ] **Develop Memory Editor** — Add a tool or feature to poke values directly into RAM
      while the sim is running. (Target: poke `0x050` to verify character ID overrides).
