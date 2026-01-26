# Last Man Standing

*Last Man Standing* is a bite-sized roguelike arena fighter where players draft a randomly generated fighter, train stats in short “weeks,” pick sponsor gifts, and survive escalating fights across a run.

**Status:** In progress

## Links
- **Demo Video:** *(link)*
- **Live link:** *(link)*

---

## Overview

### What the player does
- Start a run and choose **1 of 3 randomly generated fighters** (each with different starting stats).
- Go through a loop:
  1. **Training Grounds** (spend limited training action points to increase stats)
  2. **Sponsor Gift** (choose 1 of 3 items that modifies your run)
  3. **Fight** (RNG-based combat resolution)
  4. **Win → upgrade pace increases / continue** or **Lose → run ends**
- The goal is to **survive as long as possible** and create interesting runs through different stat builds + item choices.

### What problem it solves (design-wise)
- Delivers a full “game loop” that’s fun in short sessions: quick decisions, fast feedback, and replayability through RNG.

### What makes it technically interesting
- It’s a **state-driven game**: your run is basically a structured state machine (selection → training → gift → combat → results).
- Combines **Flame worlds** (game scene) with **Flutter overlays** (menus/UI), while keeping everything consistent via centralized state.
- Includes **local persistence** so a run can be continued and a run history can be tracked.

---

## Key Features

- **Run-based fighter drafting**
  - Generates 3 fighters with randomized stats each run.
  - Forces interesting choices (balanced vs glass cannon vs tanky), which improves replay value.

- **Training system with limited actions**
  - Each “week” you get a limited number of training actions.
  - You choose which stats to invest in (HP / Strength / Attack / Defense).
  - Training actions increase as you win, so progression feels tangible without becoming infinite.

- **Sponsor gift selection**
  - Before entering the arena, you choose 1 of 3 gifts (weapons/armor-style items).
  - This acts like a “build modifier,” pushing you toward different strategies.

- **Arena combat loop (with escalating difficulty)**
  - Opponents are generated/scaled to get harder across rounds.
  - Combat uses a probability-based hit check (accuracy vs defense), then a damage roll (strength-based) for quick resolution.

- **Save/Continue + Run History**
  - If you stop mid-run, you can continue later.
  - Completed runs are recorded into a history list (useful for replay motivation and future analytics).

---

## Tech Stack

Flutter • Dart • Flame • Riverpod • flame_riverpod • SharedPreferences • JSON serialization • Flame RouterComponent

---

## My Contributions

This was a **solo project**, so I owned the full lifecycle:

- **Game design + scope control**
  - Defined the core loop (draft → train → gift → fight) and the rule set for progression.
  - Kept the scope realistic while still shipping a playable loop.

- **Gameplay systems implementation**
  - Fighter generation + stat model
  - Training actions + stat upgrades
  - Sponsor gifts/items that affect a run
  - Enemy generation/scaling
  - RNG combat resolution (hit check + damage calculation)

- **Architecture + state management**
  - Built a centralized `GameState` flow so UI and gameplay stayed consistent.
  - Wired Flame + Flutter overlays so UI updates reflect the same source of truth.

- **Persistence**
  - Implemented save/load for the active run and storage for run history.
  - Designed serialization so the game can rehydrate state cleanly after relaunch.

- **UI/UX implementation**
  - Created the menus and overlays (fighter selection, training, item selection, combat UI).
  - Focused on keeping the UI readable and decision-driven (players should always know what to do next).

- **Debugging + iteration**
  - Identified bugs (overlay sync, continue logic, health/UI updates, persistence edge cases) and iterated on fixes as systems expanded.

---

## Architecture Notes

### How state flows
- A single `GameState` represents the run: selected fighter, stats, week/training actions, items, current enemy, fight status, history.
- UI overlays read state and dispatch actions (train, select item, start fight, etc.).
- This prevents “two sources of truth” (which is the #1 cause of weird UI/game mismatches).

### How data is stored / loaded
- The active run is serialized to JSON and stored locally (SharedPreferences).
- On app start:
  - If a save exists → load it into `GameState` and show the Continue path.
  - If not → start fresh.
- Run history is appended at run end (loss / completion condition).

### How UI is structured
- **Flame:** worlds/scenes and any in-world visuals.
- **Flutter overlays:** menus and interaction-heavy screens (selection screens, training UI, combat UI).
- **Routing:** Flame RouterComponent or equivalent to transition between major states/screens.

---

## Challenges & Fixes

- **Challenge:** Flutter overlays + Flame world transitions can desync (UI shows old state, or state changes don’t reflect immediately).  
  **Change:** Centralized all game decisions through `GameState` actions; overlays became “thin” views.  
  **Result:** UI became more predictable and easier to debug.

- **Challenge:** Save/Continue edge cases (continuing into the wrong screen, combat state persisting incorrectly).  
  **Change:** Treated resume as a deterministic “restore state → route based on state” step (instead of ad-hoc navigation).  
  **Result:** Resuming a run became consistent and testable.

- **Challenge:** Combat UI correctness (health display not updating, overlay not resetting between fights).  
  **Change:** Ensured combat results update `GameState` first, then overlays react to the new state and rebuild.  
  **Result:** Fewer “visual lies” where the UI didn’t match the real run state.

---

## What I Learned

- How to design and implement a complete **state machine game loop** that stays stable as features are added.
- How to combine **Flame gameplay** with **Flutter UI overlays** without splitting state ownership.
- How to implement **save/load** in a way that avoids fragile “resume hacks.”
- How to debug games by separating:
  - “Is the state correct?”
  - “Is the UI reflecting the state?”
- How to keep scope under control while still building something that feels like a real product.

---

## Roadmap

- **Next feature:** Fight Results screen (clean win/loss summary, damage recap, rewards preview, continue button).
- **Next improvement:** Balance pass (enemy scaling, training pacing, item impact so builds feel distinct).
- **Stretch goal:** Animation/audio polish (training transitions, hit feedback, SFX) + automated tests for core combat/stat logic.

