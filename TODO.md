- [x] Should not trigger babysitting if in egg state

- [x] Should auto-set time on reset (i.e. should transition from brand new egg -> alive without user input)

- [x] Update README

- [x] Add instructions for building PC sim

- [x] Add option for PC sim to reset sim

- [ ] Review eggInitiated flag (babysitter.cpp) when implementing tama death/restart. When the tama dies and a new egg starts, eggInitiated will be true from the previous life cycle and the new egg will never be auto-hatched. Need to detect the death-to-new-egg transition and call resetBabysitterState() at the right moment.

- [ ] Defensive test cases (likely requires more robust state/screen detection as well as a collection of saved RAM states)

- [ ] Add additional care states - possibly a percentage of care and an additional 'let die' flag. At low percentages, care is less good - snacks are picked, discipline is slow, etc. At 100%, care is perfect. Still may need to have reactive/proactive options. Poor care may fail the game

- [ ] Add bounds for wavering care. i.e. low bound 20% high bound 50% means the care percentage fluctuates (slowly) from 20 to 50 randomly along some curve, randomly. So there is an option to let the tama have some degree of randomness - some good, some bad, etc.

- [ ] Add random left/right for game

- [ ] If manual control is taken, ensure we know "where" we are before we start launching more commands
