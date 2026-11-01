# Four Layers Down Co-op

Local co-op mod for **Five Nights at Frickbear's 3 + Four Layers Down v2.1.5** (Windows, GameMaker) by SpookyRick: a main player and a helper share one keyboard in Brave Tower.

Brave Tower gets a new **"Co-op Mode"** card:

- Each player picks their own guard (no duplicates), with 3 shared lives.
- The helper uses the arrow keys for the doors (← →), the mask (↓) and the fan (↑).
- The active guard is switched on the animatronic selection screen, like Party Mode. Jeremy, Vanessa, Michael and Vannabelle's roster passives only apply to the active guard; the other passives apply to both.
- The helper's guard shows up in the monitor reflection, to the right of the main player.
- Co-op runs are saved and can be continued.

## Download and install
The release package is [`dist/FourLayersDownCoop-v1.1-xdelta.zip`](dist/FourLayersDownCoop-v1.1-xdelta.zip): an `.xdelta` patch for DeltaPatcher plus a README.txt with install steps. It applies to the original v2.1.5 `data.win`, whose SHA-256 is `c254b690b0e2ac7f52914fecc24d4753106a3daf893b11252c3c43ec5ae0df5b`.

## Layout
| Path | Contents |
|---|---|
| `mod/coop-helper/` | The mod's GML scripts and its technical [README](mod/coop-helper/README.md) |
| `mod/normal-mode-button/` | First test mod: a "Normal Mode" button in Brave Tower |
| `build/FourLayersDownCoop-v1.1.xdelta` | The v1.1 patch |
| `MODDING_RESEARCH.md` | Research notes, tools, workflow and design decisions |

The game, the decompiled code, full `data.win` files and the tools are **not** in this repository (see `.gitignore`).

## Building
You need the [UndertaleModTool CLI](https://github.com/UnderminersTeam/UndertaleModTool) (in `tools/utmt-cli/`), the original `data.win` in `original/`, and `xdelta3`. The build command is in [mod/coop-helper/README.md](mod/coop-helper/README.md). To create the patch:

```bash
xdelta3 -e -9 -S none -s original/data.win build/data.win build/FourLayersDownCoop-v1.1.xdelta
```

## Credits
Five Nights at Frickbear's 3 belongs to SpookyRick. This is an unofficial fan mod.
