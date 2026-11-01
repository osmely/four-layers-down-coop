# Mod: "Normal Mode" button in Four Layers Down

For Five Nights at Frickbear's 3 **v2.1.5** (4LD).

## What it does
The **Brave Tower** (4LD) mode picker, which has *Solo Mode*, *Party Mode* and *Daily Challenge*, gets a **fourth button, "Normal Mode"**, with the Frickbear's 3 logo.
Clicking it goes straight to the base game's menu, already at **New Game → Normal Mode → guard select**, skipping the title intro and "Press space!".
From there the flow is the original game's: pick a guard, then a difficulty if it's a custom guard, and the night starts.

- The 4 cards go from a row of 3 to a **2×2 grid**.
- "Normal Mode" is always unlocked.
- Esc/back from guard select returns to the base game's title screen.
- ⚠️ Just like *New Game* in the original game, **starting a run replaces the story save in progress**.

## Modified scripts
| Script | Change |
|---|---|
| `gml_Object_oEndless_ModePicker_Create_0` | 4th title, description and `UnlockedArray` |
| `gml_Object_oEndless_ModePicker_Draw_0` | 2×2 grid; card 4 draws `sGameTitle` at 40 %; on click: `global.ModStartNormalMode = true` and `room_goto(TitleScreenMap)` |
| `gml_Object_oCameraTitleScreen_Create_0` | With the flag set, skips the intro (Frame 149, title already off screen, music starts) |
| `gml_Object_oTitleMenu_Create_0` | With the flag set in `TitleScreenMap`, opens `goto_menu("Normal Mode", 0)` instead of `"Title"` and clears the flag |

## Build (from the project root)
```bash
rm -f build/data.win
M=mod/normal-mode-button
tools/utmt-cli/UndertaleModCli replace original/data.win -o build/data.win \
  -c "gml_Object_oEndless_ModePicker_Create_0=$M/gml_Object_oEndless_ModePicker_Create_0.gml" \
  -c "gml_Object_oEndless_ModePicker_Draw_0=$M/gml_Object_oEndless_ModePicker_Draw_0.gml" \
  -c "gml_Object_oCameraTitleScreen_Create_0=$M/gml_Object_oCameraTitleScreen_Create_0.gml" \
  -c "gml_Object_oTitleMenu_Create_0=$M/gml_Object_oTitleMenu_Create_0.gml" </dev/null
```

## Install (on Windows)
1. Back up the original `data.win` in your game folder.
2. Replace it with `build/data.win`.
3. Open the game → Play Four Layers Down → Brave Tower → (New Run) → the mode picker shows 4 buttons.

## Status
- ✅ Compiles. Decompiling `build/data.win` gives back the 4 scripts identical to the sources.
- ✅ **Tested on Windows: it works** (October 31, 2026). Superseded by Co-op Mode.
