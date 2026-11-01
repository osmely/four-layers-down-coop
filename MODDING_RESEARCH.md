# Research: modding Five Nights at Frickbear's 3

> Compiled October 30, 2026; last updated November 1, 2026.
> Status: **set up and modding.** UndertaleModTool CLI for Mac is installed, game 2.1.5 is downloaded, and dumping/reinserting code works. Builds happen on the Mac; testing happens on a separate Windows PC.

## 0. Folder contents

| Folder | Contents |
|---|---|
| `tools/utmt-cli/` | UndertaleModTool CLI 0.9.2.0 for Mac (arm64) |
| `downloads/` | Original zips: game 2.1.5 and the 3 templates (clean copy for reinstalling) |
| `game/` | Game 2.1.5 unpacked (Windows build: `Frickbears3.exe`, `data.win`, `audiogroup1-7.dat`, `texgroup_*` folders with `.yytex` files) |
| `original/data.win` | **Untouchable backup.** SHA-256 `c254b690b0e2ac7f…` |
| `dump/` | Extracted code and assets (`dump/CodeEntries/*.gml`) |
| `mod/` | Files we edited |
| `build/` | Modified `data.win` (generated) |
| `templates/` | Official templates: Luigi, Grike and office |

### `info` output for data.win 2.1.5
```
Project Name - "Frickbears3"   Is GMS2 - True   Is YYC - False   Bytecode version - 17
2189 Sounds, 1510 Sprites, 4652 Scripts, 593 Game Objects, 63 Rooms
6215 Code Entries, 34718 Strings, 476 Embedded Textures
```
**It is not compiled with YYC**, so the GML code can be decompiled and edited.

### Tested commands
```bash
# dump a script
tools/utmt-cli/UndertaleModCli dump original/data.win -o dump -c gml_GlobalScript_VoiceLineSubtitles
# reinsert it and write a new data.win (replace does NOT accept -f; delete build/data.win first if it exists)
tools/utmt-cli/UndertaleModCli replace original/data.win -o build/data.win -c "gml_X=mod/gml_X.gml"
```
The full round trip (dump and reinsert unchanged) worked on October 31, 2026, and `original/data.win` stayed intact.

More CLI tricks:
- `dump ... -c UMT_DUMP_ALL` dumps all code in ~1 s (3346 files in `dump/CodeEntries/`). `--sprites` exports every sprite as PNG (~30 s).
- For several scripts, **repeat `-c`** (`-c a -c b`). Space-separated doesn't work.
- `load <data.win> -l '<C#>'` runs C# against `Data`, useful to query sprite origins, room contents, etc. `$"..."` interpolation with LINQ (`.Select`) failed; `+` concatenation with `foreach` loops works. Use the fully qualified `UndertaleModLib.Util.TextureWorker`.

⚠️ Once the CLI hung for more than 5 minutes while compiling. With stdin closed (`</dev/null`) it finished in seconds. **Always run the CLI with `</dev/null`.**

## 0.1 Mods made
| Mod | Folder | Status |
|---|---|---|
| "Normal Mode" button in the Brave Tower (4LD) mode picker | `mod/normal-mode-button/` (see its README) | **Tested on Windows: works** (Oct 31, 2026). Package: `dist/Frickbears3-NormalModeButton-v2.1.5.zip`. **Replaced by Co-op Mode** at the user's request |
| **Co-op Mode**: Solo Run + a helper on the same keyboard (arrows: doors, mask, fan) | `mod/coop-helper/` (see its README) | Public name **"Four Layers Down Co-op"**, see below |

**Four Layers Down Co-op — version history**
- **v1.1 (current, Nov 1, 2026; published at https://gamebanana.com/mods/735142):** the helper's guard in the monitor uses its reflection sprite instead of the guard-select sprite; the night-rule conflict is fixed (the helper's The Boss/Sally/Mary rule overrides the main player's); docs and release text in English only. Release package: `dist/FourLayersDownCoop-v1.1-xdelta.zip` (`.xdelta` made with `xdelta3 -e -9 -S none`, plus README.txt). Full data.win for private testing: `dist/FourLayersDownCoop-v1.1.zip`. **Not tested on Windows yet.**
- **v1.0 = keyboard build v3 (Oct 31, 2026):** adds the partner's night and economy passives (the 4 roster passives stay active-guard only), the partner's portrait on the right of the monitor reflection, no duplicate guards, and Co-op saving in `endlessdata`. SHA-256 `96e9eb57…1ac9`. Compiled and verified by decompiling; never tested in game.
- **Keyboard v2:** each player picks a guard (the helper with the arrows), 3 lives in total (2 for the main player, 1 for the helper), ←/→ switch guards on the animatronic selection screen like Party (only the active guard's passive applies), Dollie healing adapted. `dist/Frickbears3-CoopTeclado-v2-v2.1.5.zip` (SHA-256 `9b7dce9e…57cb`).
- **Keyboard v1 (office only):** `dist/Frickbears3-CoopTeclado-v2.1.5.zip`.
- **Gamepad version (dropped):** v1 (`dist/Frickbears3-CoopHelper-v2.1.5.zip`) **failed to join**: the user pressed START on the virtual "Touch" controller and nothing happened. Diagnostic builds showed `gamepad_is_supported() = 1`, 12 slots reported, and **"No controller detected"** in slots 0–15, even though Windows lists the device in `joy.cpl` as "Controller (XBOX 360 For Windows)". The runner (`Frickbears3.exe`, GameMaker 2023.11) loads `xinput1_4.dll`/`xinput1_3.dll` and `dinput8.dll` and imports `XInputGetState`, i.e. standard XInput. Hypothesis: Touch injects input per game instead of creating a system controller. The user then asked for a keyboard helper instead.

## 0.2 Design notes: Co-op ("Helper") mode

### What the code says
- **The game has no gamepad support** (0 calls to `gamepad_*`), but the UTMT compiler accepts `gamepad_*` functions.
- **Centralized input:** `input_check`, `input_check_pressed` and `input_check_released` (in `gml_GlobalScript_ControlsScript`) map an *action* to a key or mouse button through `global.Settings[0][action]`. It's the ideal hook point, **without touching the animatronics**.
  - Action indices: 0 Confirm, 1 Back, 2–5 Up/Left/Down/Right, **6 Monitor, 7 Mask, 8 Left Door, 9 Right Door, 10 Flashlight, 11 Fan, 12 Turn Around**, 13–20 cameras, 21–24 systems, 25 Sprint, 26 Sneak.
  - ⚠️ The same indices mean other things outside the office: in the building viewer, 10 locks the cursor and 11 shows the guide; in the TrashStacker minigame, 12 does something else. **Helper input only applies with `room == Office`.**
- **The mouse is read directly** in 116 files (215 `mouse_check_button` uses: cameras, shop, minigames, clickable animatronics). So **the helper doesn't get a cursor**, only button actions.
- **Office rules** (`gml_Object_oCamera_Step_0`):
  - Doors (8, 9) and fan (11): **always** usable, even with the monitor up.
  - Mask (7): **blocked while the monitor is up** (`!(global.CamUp || HandheldUp)`). Fails silently.
  - Monitor (6): **blocked while the mask is on** (`!global.MaskDown`).
  - Flashlight (10): while held. With the monitor up it lights the camera **at the mouse position** (`oCameraUI_Other_11`), so it belongs to the main player.
  - Turn around (12): blocked with the monitor up. Changes the whole view.
  - Power: `Usage = CamUp + Doors[0] + Doors[1] + Flashlight + Fan`, shared.
- **Brave Tower lives:** `global.Lives` is a stack of guard IDs (Solo = 3 copies of the same; Party = several, and the last one is the one playing).

### Role split
| Function | Main player (keyboard + mouse) | Helper (arrows) |
|---|---|---|
| Monitor, cameras, systems, monitor shop | ✅ | — |
| Turn around | ✅ | — |
| Flashlight (office and cameras) | ✅ (aims with the mouse) | — |
| Office clicks (animatronics, honk, etc.) | ✅ | — |
| **Left / right door** | — | ✅ ← / → |
| **Mask** | — | ✅ ↓ |
| **Fan** | — | ✅ ↑ |
| Pause | ✅ Esc | — |
| Menus, shops, minigames, 3D salvages | ✅ | — |

### Conflicts and how they were handled
1. **Indices reused outside the office** → helper input only when `room == Office`, Endless, and Co-op is on.
2. **Mask blocked with the monitor up** (the helper presses and nothing happens) → keep the original rule (coordination is part of the game) but play the `error()` sound.
3. **Monitor blocked with the mask on** → same `error()` sound.
4. **Shared screen:** the mask darkens the view and mutes audio for both → unavoidable with one screen; part of the design.
5. **The main player's door/mask keys** (WASD by default) → **exclusive** mode: they don't control these actions while Co-op is on.
6. **Special mechanics reusing these actions** (`oBigTop` and `oFredbearAttack_Claw` use 8 and 9; laser doors and guard abilities that remove tools) → only the input source changes, so the original logic is untouched. Still **needs testing**.
7. **Save and continue:** stored with the Endless save (`_ModHelperMode`, `_ModCoopGuards`).
8. **Outside the office** (shop, minigames, 3D maze with mouse look in `oCamera3DMaze`) → the helper does nothing.

### Split screen (analysis of Oct 31, 2026) — ❌ REJECTED by the user
> Decision of Oct 31, 2026: **no split screen.** Multiplayer is only the shared-screen helper mode. The analysis stays here for reference.

**How the game draws the office** (`gml_Object_oCamera_Draw_0`):
- There is **one camera**. The office is **3D perspective** and the view turns with **mouse X** (`CamRotationH = (global.MouseX - room_width/2) / 3`).
- When the monitor is raised, **the same camera** switches to an orthographic view of the room area with the security cameras (960,180). **Each frame shows the office OR the cameras, never both.**
- Rooms have no *views* enabled. The UI is drawn full screen (640×360) in GUI events: **149 objects** have Draw GUI or Post-Draw events.
- **101 files read `global.CamUp`**: many animatronics behave differently depending on whether "the guard is watching the cameras".

**Meaningful split screen = main player in the office | helper on the cameras, at the same time.** Problems:
1. **Drawing two views per frame** means `view_camera[0]` and `[1]`, one viewport per half, choosing the view by `view_current`. Every Draw event runs once per view, so objects drawing by `CamUp` would need to check `view_current`. Doable, but touches many objects.
2. **The UI (149 objects) assumes full screen**: the camera map, monitor buttons, power and clock would need to move to the right half. Each half is 320 px wide, so the UI gets tiny or letterboxed (320×180 at 0.5 scale).
3. **`CamUp` loses its meaning**: today it means "the guard watches cameras instead of the office". With split screen it would mean "the helper has the monitor open", and the AI in 101 files would lose its balance (watching office and cameras at once makes the game much easier).
4. **Mask and monitor lock each other**: would the main player's mask close the helper's monitor?
5. **Controls**: the office view moves with the mouse and the cameras use clicks. The second player would need a **virtual cursor**.
6. **Performance**: 3D office plus cameras every frame is more load, though probably fine on PC.

**Conclusion:** technically possible, but a **much bigger** project (dozens to hundreds of files) that **changes the game's balance**.

### Entry button (request of Oct 31, 2026)
The user wanted the added button (4th mode-picker card) to **lead to multiplayer** and to **work like Solo Run**: one guard, 3 lives (`global.NuzlockeMode = 0`), the same rounds and shops, plus the helper in the office.
- Implementation: in `oEndless_ModePicker_Draw_0`, card 4 takes Solo Mode's branch (`NuzlockeMode = 0` → `oEndless_DifficultyPicker`) and sets `global.ModHelperMode = true`.
- **Decided:** it replaces the "Normal Mode" card.
- **Change of course (Oct 31, 2026):** the runner doesn't detect the virtual Touch controller, so the user asked for a **keyboard** helper that is comfortable for both players. Arrows were chosen over the numpad because `oHappiestDayDrawer` (an office boss) reads numpad 1–5 and keys 1–5. The arrows are only used in the 3D maze and in `ShopPickerRoom`, which are other rooms. All gamepad and diagnostic code was removed.
- **Guards in Co-op (Oct 31, 2026, decided with the user):** each player has a guard and the helper picks theirs with the arrows. Passives work **like Party**: the active guard is switched on the animatronic screen. When switching, `pick_choices()` regenerates the list with the new passive (Jeremy: cheap; Vanessa: expensive; Michael: base game; Vannabelle: update). This comes from `ability_check()` in `oEndless_AnimatronicPicker_Create_0`. Lives: 3 total, `[helper, main, main]`. Dollie's full heal in Solo does `array_create(3, global.Guard)` and would erase the other guard, so it was replaced by `coop_heal()`.
- **v3 (Oct 31, 2026, user request):** the non-roster passives also count for the partner. Done in `guard_ability()` → `coop_ability()`, with the partner alive, without touching the 82 call sites in 21 files. In game the guard is only visible in the **monitor reflection** (`oCamera_Draw_77`, `reflection.png`, 640×360, centered; per-guard sprites from `get_guard_reflection_sprite()`, 2 frames: normal and scared). The partner is drawn to the right with its own reflection sprite (since v1.1; v1.0 used `selection.png`/`sNightGuardFacesSelection`, 480×360, left-aligned, 2 frames per guard: color and silhouette).
  - Guard → passive map (= id): 0 Jeremy cheap, 1 Mike none, 2 Vanessa expensive, 3 Fritz challenge shops, 4 Michael base roster, 5 Vannabelle update roster, 6 Clark Fixy, 7 Fredsweeper Frank, 8 The Boss token goal, 9 Billy FredTV+, 10 Henry aggression ×2, 11 William Beartrap and death = run over, 12 Edwin, 13 Fiona, 14 Elizabeth Eleanor challenges, 15 Cassie power/mask, 16 Hudson power 1 bar, 17 Mary time, 18 Strings panic, 19 Sally minigame goal, 20 OMC.
  - Saving: extra keys `_ModHelperMode` and `_ModCoopGuards` in `endlessdata<version>.txt`; the original game ignores them.
- **Passive conflict found (Nov 1, 2026):** The Boss (8) / Sally (19) set `global.ProgressToMake` to a points goal in `oCamera_Create_0` (`(point_goal_base + point_goal_nightly × (round − 1)) × 3 / NightSpeedup`; The Boss 35/+5, Sally 50/+0, so 105 or 150 on round 1 instead of 360). Mary (17) sets `global.Progress = global.Timer` every frame in `oCamera_Step_0`, after the points code. In Co-op both could be on at once, so the timer filled the small points goal and 6 AM came far too early. **Fix (user's choice):** the helper's night rule wins and the main player's is turned off (`coop_overridden()` in `guard_ability()`), restored if the helper's guard is lost.

Useful code map (for future mods):
- Title menu (base and 4LD, also the pause menu): `oTitleMenu` (`goto_menu()` in Create, logic in Step: `new_game(difficulty)`)
- 4LD title: `o4LD_Title`, room `TitleScreen4LD`. Base title: `oCameraTitleScreen`, room `TitleScreenMap`
- Brave Tower: `oEndless_NewOrContinue` → `oEndless_ModePicker` → `oEndless_DifficultyPicker` → `oEndless_AnimatronicPicker` (room `EndlessSelection`)
- `title_screen()` returns `TitleScreen4LD` or `TitleScreenMap` depending on `global.FourLayersDownMode`

---

## 1. The game

| Field | Value |
|---|---|
| Name | Five Nights at Frickbear's 3 (FNaF 3 fangame) |
| Developer | SpookyRick (Game Jolt) |
| Distribution | Free on Game Jolt, **Windows** only |
| Engine | **GameMaker Studio** (VM build: the GML code is inside `data.win` and can be edited) |
| Current version | **2.1.5**, with the "Four Layers Down" (4LD) expansion. Confirmed on Game Jolt on October 31, 2026. |
| Game Jolt page | https://gamejolt.com/games/frickbears3/930477 |
| Old version | 1.1.4. Mods made for 1.1.4 don't always work on 2.0 |
| User data folder | `C:\Users\<user>\AppData\Local\Frickbears3\` |

There's no official guide for modding `data.win`; there are only **community tutorials on GameBanana**. But the developer **does publish official addon templates** on Game Jolt, each with a README.

### Game Jolt downloads (game 930477)
Listed via `https://gamejolt.com/site-api/web/discover/games/overview/930477`

| File | Size | What it is |
|---|---|---|
| `frickbears3-4ld-v2.1.5.zip` | 430.5 MB | **Full game + 4LD (current, Windows)** |
| `frickbears3-v1.1.4.zip` | 216.8 MB | Base version 1.1.4 archive |
| `luigi-basic-guard.zip` | 0.1 MB | **Official** basic guard template |
| `grike-advanced-guard-template.zip` | 3.3 MB | **Official** advanced guard template (includes 1.1.0 additions) |
| `basic-office.zip` | 0.8 MB | **Official** custom office template |

---

## 2. Where the community is

- **GameBanana, the main site:** https://gamebanana.com/games/24426 (7,000+ subscribers, 27 tutorials)
- **Fan site (unofficial):** https://frickbears3.org/mods/ and https://frickbears3.org/faq/
- **Wiki:** https://frick-fazbears.fandom.com/wiki/Five_Nights_At_Frickbear's_3_(Game)
- **Tip:** GameBanana pages load content with JavaScript. To read them without a browser, use the public API:
  - Tutorial: `https://gamebanana.com/apiv11/Tutorial/<id>/ProfilePage` (the `_sText` field has the text)
  - Mod: `https://gamebanana.com/apiv11/Mod/<id>/ProfilePage`
  - Tutorial list: `https://gamebanana.com/apiv11/Tutorial/Index?_nPage=1&_nPerpage=50&_aFilters%5BGeneric_Game%5D=24426`

---

## 3. Two ways to mod

### A) Addons, without touching code
The game loads custom content from `AppData\Local\Frickbears3\`:

- **Custom guards**, in `addons/`:
  - Each guard has a `properties.txt` (JSON) with height, salvage texts, ability, etc., plus images, sounds and dialogue.
  - Endless Mode ability: add `"ability": <n>,` below `"player_sneak_height"`. Only abilities built into the game can be used (0–17+). Some don't work in 2.0.2.
  - To install: unzip the addon into `addons/` and restart the game.
- **Office skins**, in `offices/<name>/`:
  - PNGs with fixed names: `wall_left.png`, `wall_front.png`, `wall_right.png`, `wall_back.png`, `outside_1.png`, `outside_2.png`
  - Optional: `door_left.png`, `door_right.png`, `fan_off.png`, `fan_on1.png`, `fan_on2.png`, `windowblinds_left.png`, `windowblinds_right.png`, `tv.png`, `tv_on.png`, `tv_animations/`, `hangingdecoration.png`
  - A 48x48 icon
  - A required `data.txt` (the game crashes without it):
    ```json
    {
        "Name": "Office Name",
        "FanPosition": [858, 210],
        "ClockPosition": [77, 163],
        "HonkHitboxPosition": [654, 300],
        "HonkHitboxRadius": 6,
        "ToyChica_CupcakePositions": [[10, 193], [93, 193], [723, 270], [1100, 183], [1402, 226]],
        "Dreadbear_BowlPositions": [[21, 189], [1412, 222]],
        "IncludeChallengeStickers": true
    }
    ```
- **Guard mods to use as examples:** Garfield (https://gamebanana.com/mods/706385, 4LD version, "includes every possible image, sound, property and dialogue") and Spooky (https://gamebanana.com/mods/663620)

### A.2) Official template docs (downloaded to `templates/`)
Source: the READMEs of the official Game Jolt templates, written by BubbledDEV. **Files in `SPOILERS/` were deliberately not read.**

- `templates/luigi-basic-guard/`: basic guard. The README lists the minimum files.
- `templates/grike-advanced-guard-template/`: advanced guard. `README.txt` is the full documentation and `README_ForParameters.txt` explains the 4LD abilities.
- `templates/basic-office/`: custom office. `readme.txt` explains the coordinates.

**Custom guard: the essentials**
- The folder name is the in-game name. Text in parentheses isn't shown: "Mike (Awesome Version)" shows as "Mike".
- Custom guard IDs start at **21**, in alphabetical order inside `addons/`.
- **Required (\*):** `extras_info.txt`, `opening_dialogue.txt`, `portrait.png` (any size), `icon.png` (48x48), `outside.png` (640x256), `silhouette.png` (96x128), `reflection.png` (1280x360, two halves: normal and in danger), `minigame.png` (64x16, 4 frames, **only the template's 4 colors**) and the talk sound.
  - ⚠️ Grike's README calls that sound `textsound.ogg`, but both templates ship `talksound.ogg`. **Use `talksound.ogg`.**
- **Optional:** `mask.png` (1280x480, two halves: normal and with "Cool Glasses"), `properties.txt`, `voicelines/`, `dialogue/`, `songs/`, `bar/give.txt` and `bar/receive.txt`.
- **Voice lines** (`voicelines/`): `voc_selection_01.ogg`, `voc_die_*`, `voc_gameover_*`, `voc_victory_*`, `voc_salvageopening_*`. Each has a `.txt` subtitle file in this format: `[["text", 0], ["text", 1]]`.
- **`properties.txt` (JSON):**
  - `player_height` (24–80, default 48) and `player_sneak_height` (8–24, default 16)
  - `theme_intro`, `theme_game_over`, `theme_victory`, `theme_victory_night5`, `theme_victory_night6`: `["file.ogg", volume]` from `songs/`
  - `music_player`: `[name, file, bpm, original name, source, [loop_start, loop_end]?]`
  - Loose dialogue: `maze_rules_poster`, `maze_newspaper_1/2/3`, `upgrade_cadet_story`, `helpy`, `psy_friend_fredbear_house`, `dreadbear` (arrays of `[text, speaker]`); `withered_bonnie` and `bb_quiz_answer` (strings)
  - `new_opening_dialogue: true`: uses `dialogue/cutscene_Opening.txt`
  - `ability` (integer) and `fld_parameters` (struct with animatronics, minigames, multipliers, starting power, etc.)
- **Dialogue** (`dialogue/cutscene_*.txt`): JSON `{"DIALOGUE": [["text","Speaker"], ...]}`
  - Commands: `["_skip"]`, `["_delay", frames]` (60 fps), `["_effect", start, end, "Shake"]`, `["_lock"]`, `["_buffer"]`, `["_func", [[...]]]`
  - Functions: `fadeOut`, `fadeIn`, `playSound`, `playMusic`, `fadeMusic`, `salvage`, `credits`
  - Missing dialogue falls back to a generic one. **Validate the JSON**: a format error crashes the game with "JSON parse error".
- **Cheat console** (useful for testing): `room EndlessShopOMC` goes straight to the boat ride; `tipsy <id> <id>` tests bar dialogue.

**Custom office: the essentials**
- Coordinates: left wall (0,0), center (512,0), right (1024,0), back (512,512). The back wall is shown **flipped** in game.
- `data.txt` also takes `Description` and `MinigamePalette` (RGB colors, lightest to darkest).
- `music/`: `night1–6.ogg` and `custom1–6.ogg` replace each night's music.
- `cameras/cam01–08.png`: camera views. To change the building, UTMT is recommended (textures prefixed `TitleTex`) along with the in-game building viewer (number keys switch cameras, TAB takes a capture).

### B) Editing `data.win`: the chosen route ✅
`data.win` holds all GML code, sprites, sounds and text. It's edited with **UndertaleModTool (UTMT)**.

Technical details from the tutorials:
- Subtitle text lives in `gml_GlobalScript_VoiceLineSubtitles`. Format with several lines per audio:
  ```gml
  case voc_RWQFSFASXC_YOUSUCK:
      return [["Y.", "O.", "U.", "S.", "U.", "C.", "K."], [0, 2, 4, 6, 8, 10, 12]];
  ```
  The second array gives the second at which each line changes.
- Parking lot dialogue is in `gml_GlobalScript_TextBoxScripts_ParkingLotScript`, via `add_page("text", "Name");`. Guard numbers: 0 Jeremy, 1 Mike, 2 Vanessa, 3 Fritz, 4+ custom guards.
- A new difficulty mode touches: `gml_GlobalScript_SaveData`, `gml_Object_oCameraCredits_Create_0`, `gml_Object_oExtras_Statistics_Create_0`, `gml_Object_oTitleMenu_Create_0`, `gml_Object_oTitleMenu_Draw_77`, `gml_Object_oTitleMenu_Step_0`. Difficulties are defined in `switch (global.Difficulty)` (0 Easy, 1 Normal, 2 Hard, 3 Lunatic).
- Office sprites can be found by filtering `sOffice*` (plus `sBrokenGlass`).
- **Sounds:** imported as `.ogg` with the original's name, using `ImportSingleSound.csx`. Import them one at a time; importing several at once creates a new audiogroup and can break the game.
- **YYTEX files** (portraits, death screens, title): replacing them directly gets reverted when the game restarts. The fix is to create a new Embedded Texture, Texture Page Item and Sprite, and change the code that draws them.
- **Saves:** the `savedata` file with the `.wario` extension is JSON-like text (`"_Guard":4.0`, `"_Salvages":[5.0,9.0,30]`). Upgrade IDs: https://pastebin.com/raw/hhYB8pxB
- **Distribution:** the norm is publishing an `.xdelta` patch (installed with DeltaPatcher) instead of the whole `data.win`.

---

## 4. GameBanana tutorials (all 27)

| ID | Title | Topic |
|---|---|---|
| 19849 | Very simple and basic modding guide | **Start here**: UTMT, sounds, text |
| 19608 | Texture Swapping Guide - Office | Export and replace sprites |
| 19899 | How to overwrite YYTEX files (Kinda) | Textures that resist replacing |
| 19662 | Basic Custom Gamemode Tutorial | New difficulty (code) |
| 19944 | How to change max AI Level | Game logic |
| 19900 | How to do weird things with camera | Camera |
| 19898 | Putting (Interactable) Objects in the office | Office objects |
| 20219 | Add New Sounds to a Audiogroup | Audio |
| 19694 | How to add Custom Voice lines for the Office | Audio |
| 19685 | How to add Custom Sprites to the Main Menu | Sprites |
| 19635 | How to add custom sprites to the Parking lot scene | Sprites |
| 19679 | How to add multiple guard reflections | Guards |
| 19612 | How to add multiple voiced characters for your mod | Voices |
| 19582 | Adding Dialog to custom characters | Dialogue (obsolete since 1.1.0) |
| 19579 | Evil Ending Newspaper Text Guide | Text |
| 20426 | Offices Skin Tutorial | Office addon |
| 20427 | Endless Mode Abilities to your Custom Guard | Guard addon |
| 20440 | I found where to put custom guards boatride dialog | Guard addon |
| 20423 | (4LD) Info on guard voicelines | Guard addon |
| 20006 | CANIMI Tutorial - Video | https://youtu.be/BiOodsnNVm8 |
| 19605 | Adding mods with a Data.win file | Installing mods |
| 19617 | How to install a DeltaPatcher mod | Installing xdelta patches |
| 19636 | Basic Save Editing | Saves |
| 20443 | Quick Guide on how to Modify your Records and More | Records |
| 20434 | How to unlock the two new bloodstone trophies | Gameplay |
| 19823 | what are some tips to beat night 2 | Gameplay |
| 19593 | Gallery ERROR Fix (1.0.2 or Earlier) | Old fix |

URL for each: `https://gamebanana.com/tuts/<ID>`

---

## 5. Working from the Mac

### Machine
- macOS 27.0.1, **Apple Silicon (arm64)**
- Installed: Homebrew, git, Python 3.14, xdelta3 3.2.2
- Not installed: .NET, Wine, CrossOver, a VM

### UndertaleModTool 0.9.2.0 (August 23, 2026)
- Releases: https://github.com/UnderminersTeam/UndertaleModTool/releases
- The GUI (the one the tutorials use) **is Windows only**.
- There is a **native command-line build for Mac**: `UTMT_CLI_v0.9.2.0-macOS.zip` (60.8 MB, arm64). There's also a 68.3 MB `-macOS-x86.zip`.
- Commands (from the source, `UndertaleModCli/Program.cs`):

| Command | Options | Purpose |
|---|---|---|
| `info <datafile>` | `-v` | GameMaker version and basic data |
| `dump <datafile>` | `-o dir`, `-c <scripts \| UMT_DUMP_ALL>`, `-s` strings, `-t` textures, `--sprites` | Extract content |
| `replace <datafile>` | `-o output`, `-c 'gml_X=./file.gml'`, `-t 'Texture 0=./img.png'` (or `UMT_REPLACE_ALL`) | Reinsert changes |
| `load <datafile>` | `-s a.csx b.csx`, `-l "C#"`, `-i` interactive, `-o`, `-f` | Run `.csx` scripts |
| `project build` | `-s source`, `-d destination` and `project.json` | 0.9 project system |
| `new` | `-o`, `-f` | Create an empty data file |

### Workflow
1. Download the Windows game zip from Game Jolt and unpack it (no need to run it).
2. Copy `data.win` to `original/data.win` and **never touch it**.
3. `dump` the code or assets to change into `dump/`.
4. Edit the `.gml` files in `mod/`.
5. `replace` to generate `build/data.win`.
6. Test on Windows.
7. Make the release patch: `xdelta3 -e -9 -S none -s original/data.win build/data.win mod.xdelta` (`-S none` keeps it compatible with DeltaPatcher).

### Testing needs Windows
- **CrossOver** (paid, 14-day trial): simplest for light GameMaker games. The UTMT GUI might also run there (unverified).
- **Parallels with Windows 11 ARM:** most reliable, but costs more.
- **UTM** (free): may be slow without graphics acceleration.
- **A Windows PC:** copy the modified `data.win` over. ← what we use.

### Mac limitations
- Fine for editing code and textures.
- Importing **new sounds or sprites** is harder: community `.csx` scripts (`ImportSingleSound.csx`, etc.) tend to open windows and would need adapting for the CLI.
- The tutorials assume the GUI, so their steps need translating into commands.
- **Reading the code spoils the endings.**

---

## 6. Precautions (from the fan site and tutorials)
- Install over a clean copy and check it launches before modding anything.
- Make a dated copy of the save folder before each change, stored off the game's drive.
- One mod at a time, and play a full night before adding another.
- If DeltaPatcher fails, either the game version is wrong or another mod is already installed. Reinstall clean.
- Download mods from their author's page, not reuploads.

---

## 7. Checklist
- [x] Download `UTMT_CLI_v0.9.2.0-macOS.zip` from the official GitHub (SHA-256 `03042fa7…5444ef`, matches GitHub). Unpacked to `tools/utmt-cli/`. Runs on arm64 without installing .NET (`tools/utmt-cli/UndertaleModCli --help`).
- [x] Create the folder layout (`tools/`, `original/`, `dump/`, `mod/`, `build/`)
- [x] Download `frickbears3-4ld-v2.1.5.zip` (430.5 MB) from Game Jolt and copy `data.win` to `original/`
- [x] Download the official templates (Luigi, Grike, office) to `templates/`
- [x] Run `info` to confirm the GameMaker version (GMS2, VM, bytecode 17)
- [x] Dump/reinsert round trip
- Game Jolt download URLs come from `POST https://gamejolt.com/site-api/web/discover/games/builds/get-download-url/<buildId>` (body `{}`). Build IDs: game 2.1.5 = `2063625`, Luigi = `1924814`, Grike = `2063550`, office = `2061941`
- [x] First mod (Normal Mode button) — works on Windows
- [x] Testing on a Windows PC
- [x] Install `xdelta` for the release patch (`brew install xdelta`, xdelta3 3.2.2)
