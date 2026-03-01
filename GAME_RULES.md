# P1 Tamagotchi — Game Rules Reference

Distilled from `info.txt`. Use this when writing babysitter logic, RE analysis strategy,
or implementing forced evolution.

---

## Lifecycle Stages & Timing

| Stage      | Character(s)          | Duration       | Sleep          | Evolves at |
|------------|-----------------------|----------------|----------------|------------|
| Egg        | —                     | 5 min          | —              | 5 min      |
| Baby       | Babytchi              | 65 min         | 5-min nap only | 65 min     |
| Child      | Marutchi              | 48 hr          | 8pm – 9am      | Age 3      |
| Teen       | Tamatchi / Kuchitamatchi | 72 / 48 hr  | 9pm – 9am      | Age 6      |
| Adult      | 6 characters          | varies         | ~10pm – 9am    | —          |
| Special    | Bill / Oyajitchi      | 15–16 days     | 10pm – 9am     | 4 days as Maskutchi |

**Age = 1 year per wakeup cycle** (increments when the tama wakes up, not on a real-time clock).

---

## Mistake Definitions

**Care mistake**: hunger OR happy meter hits 0 AND is not responded to within **15 minutes**.
Attention icon turns off → 1 care mistake logged.

**Discipline mistake**: tama makes an attention call while BOTH meters are non-empty (a "false
call") AND is not disciplined within **15 minutes**.

Key: the 15-minute window is the same for both. The babysitter must respond to all attention
calls within 15 emulated minutes.

**Mistakes are cumulative across child + teen** when determining adult evolution. A discipline
miss on Marutchi carries forward to the teen-→-adult calculation.

---

## Evolution Decision Tree

### Child → Teen (at age 3, based on child-stage care only)

| Care mistakes | Disc mistakes | Teen result        |
|---------------|---------------|--------------------|
| 0 – 2         | 0 – 2         | Tamatchi (type 1)  |
| 0 – 2         | 3+            | Tamatchi (type 2)  |
| 3+            | 0 – 2         | Kuchitamatchi (type 1) |
| 3+            | 3+            | Kuchitamatchi (type 2) |

### Teen → Adult (at age 6, CUMULATIVE child + teen mistakes)

| Adult          | Conditions                                                                 |
|----------------|----------------------------------------------------------------------------|
| Mametchi       | Tamatchi T1 · 0–2 care · **0** disc                                       |
| Ginjirotchi    | Tamatchi T1 · 0–2 care · **1** disc                                       |
| Maskutchi      | Tamatchi T1: 0–2 care, 2+ disc  /  Tamatchi T2: 0–3 care, 2+ disc        |
| Kuchipatchi    | 3+ care · (Tamatchi T1 or Kuchitamatchi T1) · 0–1 disc                   |
| Nyorotchi      | T1: 3+ care & 2–3 disc / T2: 4+ care & 3–7 disc / KT1: 3+ care & 2 disc / KT2: 3+ care & 3–5 disc |
| Tarakotchi     | T1: 3+ care & 4+ disc / T2: 4+ care & 8+ disc / KT1: 3+ care & 3+ disc / KT2: 3+ care & 6+ disc  |
| Bill/Oyajitchi | Maskutchi (from Tamatchi T2) → after 4 days, regardless of care          |

**Target for perfect babysitter**: Tamatchi T1, 0 care, 0 disc → **Mametchi**.

---

## Discipline Mechanics

- Each successful discipline adds **25%** to the meter.
- Marutchi (starting at 0%): makes exactly **4 discipline calls** to fill the meter.
- A teen starting at 50%: makes exactly **2 discipline calls**.
- Discipline calls only fire when both meters are **not empty** — if either is empty, it is a
  care call, not a discipline call.
- If the tama evolves within 15 min of a discipline call, the call can still be answered.
- Disciplining when the tama is NOT misbehaving: no effect.

---

## Feeding Rules

| Action | Hunger | Happy | Weight | Notes |
|--------|--------|-------|--------|-------|
| Meal   | +1 heart | — | +1 | Good care; fills hunger |
| Snack  | — | +1 heart | +2 | Bad practice; too many → sick → death |
| Game   | — | +1 heart (if ≥3/5 won) | –1 | Best way to raise happy |

**Proactive babysitter should always prefer meals + games over snacks.**
Snacks should be avoided entirely or used only as an emergency happy fix.

---

## Poop Schedule

- **Baby**: poos at ~15 min and ~40–45 min after hatch (before evolving).
- **Child+**: first poo 5 min after stage start, then **every 3 hours**.
- Multiple simultaneous poops dramatically increase illness chance.
- Tama does NOT raise the attention icon for poop — babysitter must poll `MEM_LOC_POOP`.

---

## Lights

- Tama sleeps on a schedule (see stage table above).
- Not turning off lights when tama falls asleep = **care mistake** (attention icon appears,
  15-minute window applies).
- Turning lights off while awake: no health impact, but blinds the screen.
- Turning lights on while asleep: wakes tama (don't do this).

---

## Hunger/Happy Decay Rate

- Rate increases with age.
- **Original P1 cap**: 1 hunger heart lost every 6 min, 1 happy heart every 7 min.
- **2017 rerelease cap**: ~1 of each every 16 min.

---

## Attention Icon

Lights up for:
- Hunger = 0
- Happy = 0
- Fell asleep (needs lights off)
- Discipline call (false call when meters are non-empty)

Does **NOT** light up for: poop, sickness.

---

## Death

- **Old age**: each adult has a fixed max lifespan (Mametchi: 15–16 days; Tarakotchi: 3–4 days).
- **Neglect**: repeated ignored care/discipline calls.
- **Illness**: from poo left too long, too many snacks, or old age.
- Pre-death: tama gets sick. Sick tama refuses to eat or play.
- After death: A+C simultaneously starts a new egg.
- Egg-laying animation before death = tama was well-cared-for as an adult (cosmetic only).
