# Mod: botón "Normal Mode" en Four Layers Down

Para Five Nights at Frickbear's 3 **v2.1.5** (4LD).

## Qué hace
En la pantalla de selección de modo de **Brave Tower** (4LD), que trae *Solo Mode*, *Party Mode* y *Daily Challenge*, se añade un **cuarto botón, "Normal Mode"**, con el logo de Frickbear's 3.
Al pulsarlo se va directo al menú del juego base, ya en **New Game → Normal Mode → selección de guardia**, sin la intro del título ni el "Press space!".
Desde ahí el flujo es el del juego original: eliges guardia, luego dificultad si es un guardia personalizado, y empieza la partida.

- Las 4 tarjetas pasan de una fila de 3 a una **cuadrícula de 2×2**.
- "Normal Mode" siempre está desbloqueado.
- Si te arrepientes, Esc/atrás desde la selección de guardia vuelve al título del juego base.
- ⚠️ Igual que *New Game* en el juego original, **empezar una partida reemplaza la partida de la historia en curso**.

## Scripts modificados
| Script | Cambio |
|---|---|
| `gml_Object_oEndless_ModePicker_Create_0` | 4.º título, descripción y `UnlockedArray` |
| `gml_Object_oEndless_ModePicker_Draw_0` | Cuadrícula de 2×2; la tarjeta 4 dibuja `sGameTitle` al 40 %; al hacer clic: `global.ModStartNormalMode = true` y `room_goto(TitleScreenMap)` |
| `gml_Object_oCameraTitleScreen_Create_0` | Con la bandera activa, se salta la intro (Frame 149, título ya fuera de pantalla, arranca la música) |
| `gml_Object_oTitleMenu_Create_0` | Con la bandera activa en `TitleScreenMap`, abre `goto_menu("Normal Mode", 0)` en vez de `"Title"` y apaga la bandera |

## Compilar (desde la raíz del proyecto)
```bash
rm -f build/data.win
M=mod/normal-mode-button
tools/utmt-cli/UndertaleModCli replace original/data.win -o build/data.win \
  -c "gml_Object_oEndless_ModePicker_Create_0=$M/gml_Object_oEndless_ModePicker_Create_0.gml" \
  -c "gml_Object_oEndless_ModePicker_Draw_0=$M/gml_Object_oEndless_ModePicker_Draw_0.gml" \
  -c "gml_Object_oCameraTitleScreen_Create_0=$M/gml_Object_oCameraTitleScreen_Create_0.gml" \
  -c "gml_Object_oTitleMenu_Create_0=$M/gml_Object_oTitleMenu_Create_0.gml"
```

## Instalar (en Windows)
1. Haz una copia del `data.win` original de tu carpeta del juego.
2. Reemplázalo por `build/data.win`.
3. Abre el juego → Play Four Layers Down → Brave Tower → (New Run) → aparece la pantalla de modos con 4 botones.

## Estado
- ✅ Compila. Al decompilar el `build/data.win`, los 4 scripts salen idénticos a los fuentes.
- ❓ **Sin probar dentro del juego** (hace falta Windows). Hay que revisar: que la cuadrícula se vea bien y no tape la descripción de abajo, que el logo se vea bien al 40 %, y que el salto al menú de guardias funcione.
