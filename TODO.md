- [x] Should not trigger babysitting if in egg state

- [x] Should auto-set time on reset (i.e. should transition from brand new egg -> alive without user input)
- [x] Update README
- [x] Add instructions for building PC sim
- [x] Add option for PC sim to reset sim

- [ ] Review eggInitiated flag (babysitter.cpp) when implementing tama death/restart. When the tama dies and a new egg starts, eggInitiated will be true from the previous life cycle and the new egg will never be auto-hatched. Need to detect the death-to-new-egg transition and call resetBabysitterState() at the right moment.
