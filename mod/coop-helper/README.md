# Mod: "Four Layers Down Co-op" (main player + helper on one keyboard)

Public name (GameBanana): **Four Layers Down Co-op v1.2**, published at https://gamebanana.com/mods/735142. In game the card still says "Co-op Mode". Release package: `dist/FourLayersDownCoop-v1.2-xdelta.zip` (`.xdelta` patch for DeltaPatcher, made with `xdelta3 -e -9 -S none -s original/data.win build/data.win build/FourLayersDownCoop-v1.2.xdelta`).

For Five Nights at Frickbear's 3 **v2.1.5** (4LD). It **replaces** the `normal-mode-button` mod: both start from the original `data.win`, so they can't be combined.

> A gamepad version came first but was dropped: the user's virtual "Touch" controller shows up in `joy.cpl` as "Controller (XBOX 360 For Windows)", but the runner didn't detect it in any slot (0–15). Details in `MODDING_RESEARCH.md` §0.1.

## What it does
- The 4th card of the Brave Tower mode picker becomes **Co-op Mode**: the Solo Mode icon with a "2P" badge, **always unlocked**.
  - Clicking it takes the same path as Solo Mode (`global.NuzlockeMode = 0` → `oEndless_DifficultyPicker`) and sets `global.ModHelperMode = true`. The other cards set it to `false`.
- In the **office** during an Endless run, the helper uses the **arrow keys**:
  - ← = left door (action 8), → = right door (9), ↓ = mask (7), ↑ = fan (11).
  - The mode is **exclusive**: for these four actions, the main player's bound keys don't count.
- **Each player picks a guard (v2):** in `oEndless_DifficultyPicker` the helper moves a "2P" frame with the arrows (yellow = valid; gray = locked or the main player's guard). "Confirm" needs both guards. Lives: `global.Lives = [helper, main, main]` (3 total; the main player's guard starts active). `global.ModCoopGuards = [main, helper]`.
- **Party-style guard switching:** in `oEndless_AnimatronicPicker`, ←/→ cycle through the distinct guards in `global.Lives` using the same code as Party's click: passive, `set_guard_parameters()`, `pick_choices()`, Edwin and OMC.
- **Dollie healing:** `coop_heal(full)` replaces the healing code in `oShopMenu_Create_0` and in `TextboxScripts` (DollieHeal/DollieFullHeal). A simple heal revives the missing guard with 1 life or adds one to the active guard. A full heal rebuilds `[helper, main, main]` and rotates it so the current guard stays active. Outside Co-op it behaves like the original.
- **v3 — helper passives:** `guard_ability()` (in `EndlessGuardData`) returns `functional_guard_id(global.Guard) == x || coop_ability(x)`. `coop_ability()` counts the **partner's** passive (`coop_partner()`: the Co-op guard that isn't active and is still in `global.Lives`), except the 4 animatronic-roster passives (0 Jeremy, 2 Vanessa, 4 Michael, 5 Vannabelle), which stay active-guard only. Edwin (12) and OMC (20) aren't counted twice when switching, because `guard_ability` returns the same before and after. The Boss (8), Mary (17) and Sally (19) are handled by the night-rule override below.
- **Night-rule conflict (fixed in v1.1):** The Boss (8) and Sally (19) replace the 6 AM goal with a points goal (`ProgressToMake` ≈ 105–150 instead of 360), while Mary (17) drives `global.Progress` from the timer every frame. Shared through `coop_ability()`, the timer filled the small points goal and 6 AM came in a minute or two. Now `guard_ability()` first asks `coop_overridden()`: when both Co-op guards have a night rule (`coop_night_rule()`: 8, 17, 19) and they differ, the **main player's** rule returns false and the **helper's** wins, whichever guard is active. If the helper's guard is no longer in `global.Lives`, the main player's rule comes back.
- **Helper in the office (v3, fixed in v1.1):** in `oCamera_Draw_77`, the active guard's monitor reflection is shifted 100 px left, and the partner's own **reflection sprite** (`import_sprites_solo(partner, "reflection.png", get_guard_reflection_sprite(partner), 2)`, frame `id*2 + scared`) is drawn 100 px right, with the same alpha (0.25) and the same clipping as the monitor rises. v1.0 wrongly used the guard-select sprite. It is freed in `oCamera_CleanUp_0`.
- **Helper monitor (v1.2):** when the main player is turned around (`global.TurnedAround`) or on the cameras (`global.CamUp`), the helper can't see the doors, so `oCamera_Draw_77` slides up a 200×102 panel in the bottom-right corner (above the bottom HUD, which is drawn later by `oCamera_UIStuff`). It has a blue frame and shows the left wall (left door + vent) and the right wall (right door + vent) side by side, 96×96 each. The animation is `HelperMonitorAnim += (target - HelperMonitorAnim) / 5`, like `CamAnimation`, and the panel starts `PanelH + 24` px below its resting place.
  - The walls are **redrawn in 2D**, not copied from `global.SurfaceL/R`: those surfaces are drawn upside down for the 3D cube, under a projection that can't be checked on the Mac. `coop_draw_wall()` (in `ControlsScript`) repeats what `surfaceHandling()` does, but upright: the `Background` layer, then `oWall.List_BehindWall`, the wall sprite, `oWall.List_OnWall` and `oWall.List_InFrontOfWall`, keeping every instance whose bbox touches the wall's room region (left 576,448; right 1600,448; 512×512). Doors, animatronics in doorways and vents are `oOfficeSprite`/`oDoor` instances on those layers, so they show up. Challenge stickers are skipped.
  - Each wall goes into a 192×192 surface (`HelperMonitorSurface`, scale 0.375, cleared to black so door and vent openings aren't transparent), drawn at 0.5 with texture filtering for a smoother downscale. The surface is freed in `oCamera_CleanUp_0`.
  - It's always fully lit (the office darkness is the `sFlashlight` overlay, which is drawn before the panel).
- **v3 — no duplicate guards:** the main player's click ignores the helper's guard, and the helper's frame turns gray (`HelperGuard = -1`) over the main player's. The tiles show "1P" and "2P".
- **v3 — saving:** `save_endless_data` stores `_ModHelperMode` and `_ModCoopGuards`. `load_endless_data` reads them with `variable_struct_exists` (old saves get `false`/`[]`), and `initialize_endless_data` resets them.
- The main player keeps the mouse and all other keys, including Esc to pause.
- An `error()` sound plays when the mask is pressed with the monitor up, or the monitor with the mask on. In the original game both fail silently.

### Why arrows and not the numpad
`oHappiestDayDrawer` (a boss that appears in the office) reads numpad 1–5 and keys 1–5. The arrows are only used in the 3D maze and in `ShopPickerRoom`, which are other rooms, so they don't clash with `room == Office`. They're also far from WASD, giving each player their own side of the keyboard.

## Modified scripts
| Script | Change |
|---|---|
| `gml_GlobalScript_ControlsScript` | `global.ModHelperMode`, `global.ModCoopGuards`, `coop_partner()` and `coop_heal()`; `helper_active()`, `helper_key()` and `helper_input()`; `coop_wall_layer()` and `coop_draw_wall()` for the helper monitor. `input_check`, `input_check_pressed` and `input_check_released` check the arrows first when `helper_active()` |
| `gml_Object_oEndless_ModePicker_Create_0` | Co-op Mode title and description; all 4 cards unlocked by default |
| `gml_Object_oEndless_ModePicker_Draw_0` | 2×2 grid, "2P" card, click behaves like Solo plus the helper flag |
| `gml_Object_oCamera_Step_0` | Two `else if` branches with `error()` for the mask/monitor locks |
| `gml_Object_oEndless_DifficultyPicker_Create_0` | `HelperCursor`, `HelperGuard` and `HelperFocus` variables |
| `gml_Object_oEndless_DifficultyPicker_Draw_0` | "2P" frame on the arrows, auto-scroll, helper guard description, Confirm gating, Co-op lives |
| `gml_Object_oEndless_AnimatronicPicker_Draw_0` | ←/→ switch the active guard |
| `gml_Object_oShopMenu_Create_0` | Healing via `coop_heal()` |
| `gml_GlobalScript_EndlessGuardData` | `guard_ability()`, `coop_ability()`, `coop_night_rule()` and `coop_overridden()` |
| `gml_GlobalScript_SaveData` | Save, load and reset the Co-op state |
| `gml_Object_oCamera_Draw_77` | Main reflection shifted + partner reflection on the right; helper monitor |
| `gml_Object_oCamera_CleanUp_0` | Frees the partner reflection sprite and the helper monitor surface |
| `gml_GlobalScript_TextboxScripts` | Dollie healing via `coop_heal()` (the whole script is recompiled and decompiles back identical) |

`helper_active()` = `ModHelperMode && room == Office && global.Night == "Endless"`. This keeps it out of the story, Custom Night, menus and other rooms that reuse the action indices.

## Build (from the project root)
```bash
rm -f build/data.win
M=mod/coop-helper
tools/utmt-cli/UndertaleModCli replace original/data.win -o build/data.win \
  -c "gml_GlobalScript_ControlsScript=$M/gml_GlobalScript_ControlsScript.gml" \
  -c "gml_Object_oEndless_ModePicker_Create_0=$M/gml_Object_oEndless_ModePicker_Create_0.gml" \
  -c "gml_Object_oEndless_ModePicker_Draw_0=$M/gml_Object_oEndless_ModePicker_Draw_0.gml" \
  -c "gml_Object_oCamera_Step_0=$M/gml_Object_oCamera_Step_0.gml" \
  -c "gml_Object_oEndless_DifficultyPicker_Create_0=$M/gml_Object_oEndless_DifficultyPicker_Create_0.gml" \
  -c "gml_Object_oEndless_DifficultyPicker_Draw_0=$M/gml_Object_oEndless_DifficultyPicker_Draw_0.gml" \
  -c "gml_Object_oEndless_AnimatronicPicker_Draw_0=$M/gml_Object_oEndless_AnimatronicPicker_Draw_0.gml" \
  -c "gml_Object_oShopMenu_Create_0=$M/gml_Object_oShopMenu_Create_0.gml" \
  -c "gml_GlobalScript_TextboxScripts=$M/gml_GlobalScript_TextboxScripts.gml" \
  -c "gml_GlobalScript_EndlessGuardData=$M/gml_GlobalScript_EndlessGuardData.gml" \
  -c "gml_GlobalScript_SaveData=$M/gml_GlobalScript_SaveData.gml" \
  -c "gml_Object_oCamera_Draw_77=$M/gml_Object_oCamera_Draw_77.gml" \
  -c "gml_Object_oCamera_CleanUp_0=$M/gml_Object_oCamera_CleanUp_0.gml" </dev/null
```

## Status
- ✅ v1.2 compiles (13 scripts). The v1.2 changes (`Draw_77`, `CleanUp_0`, the two wall functions) decompile back identical. Decompiled, 11 come back identical. In `ControlsScript` and `DifficultyPicker_Draw` only constants differ, because they decompile as numbers (`vk_*` → 37–40; `c_yellow`/`c_gray` → 65535/8421504). A condition `a ? b : c && d` decompiled ambiguously, so it was rewritten as an `if`.
- SHA-256 of `build/data.win` (v1.2): `25ecd6cc316e34ea957084a3d08746c038ef119139e9e45e0877a6a7e8b1df50` (v1.1: `f0e3f37f…a1b`)
- ❓ **Not tested in game yet** (neither v1.1 nor v1.2). v1.0 (`96e9eb57…1ac9`) lacked the reflection fix and the night-rule override.

## Known issues and limitations
- Co-op runs saved with v2 (without the new fields) continue as a normal Solo run.
- The helper is only visible in the monitor reflection (the main player isn't shown anywhere else either).
- Outside the office, the helper only has controls on the guard select and animatronic selection screens.
- The game's key hints still show the main player's keys.
- With many keys held at once, some keyboards drop key presses (*ghosting*). A second USB keyboard for the helper fixes it, because GameMaker reads every keyboard as one.
