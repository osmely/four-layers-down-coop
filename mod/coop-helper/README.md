# Mod: "Four Layers Down Co-op" (jugador principal + ayudante en el mismo teclado)

Nombre público (GameBanana): **Four Layers Down Co-op v1.0** = build v3 de este README. Dentro del juego la tarjeta sigue diciendo "Co-op Mode". Paquete público: `dist/FourLayersDownCoop-v1.0-xdelta.zip` (parche `.xdelta` para DeltaPatcher, hecho con `xdelta3 -e -9 -S none -s original/data.win build/data.win build/FourLayersDownCoop-v1.0.xdelta`). Con el data.win completo, solo para pruebas: `dist/FourLayersDownCoop-v1.0.zip` (carpeta `FourLayersDownCoop/` con data.win + LEEME.txt; SHA-256 del data.win `96e9eb57…1ac9`).

Para Five Nights at Frickbear's 3 **v2.1.5** (4LD). **Reemplaza** al mod `normal-mode-button`: los dos parten del `data.win` original, así que no se combinan.

> Primero se hizo una versión con mando, pero se descartó: el mando virtual "Touch" del usuario aparece en `joy.cpl` como "Controller (XBOX 360 For Windows)", pero el runner no lo detectó en ningún slot (0–15). Los detalles están en `INVESTIGACION_MODDING.md` §0.1.

## Qué hace
- La 4.ª tarjeta del selector de modos de Brave Tower pasa a ser **Co-op Mode**: icono de Solo Mode con una marca "2P", **siempre desbloqueada**.
  - Al hacer clic, toma el mismo camino que Solo Mode (`global.NuzlockeMode = 0` → `oEndless_DifficultyPicker`) y activa `global.ModHelperMode = true`. Las otras tarjetas lo ponen en `false`.
- En la **oficina** de una partida Endless, el ayudante usa las **flechas**:
  - ← = puerta izquierda (acción 8), → = puerta derecha (9), ↓ = máscara (7), ↑ = ventilador (11).
  - El modo es **exclusivo**: en estas cuatro acciones las teclas que el principal tenga configuradas no cuentan.
- **Cada jugador elige su guardia (v2):** en `oEndless_DifficultyPicker` el ayudante mueve un marco "2P" con las flechas (amarillo = válido; gris = bloqueado o el mismo que eligió el principal). "Confirm" exige los dos guardias. Vidas: `global.Lives = [ayudante, principal, principal]` (3 en total; empieza activo el principal). `global.ModCoopGuards = [principal, ayudante]`.
- **Cambio de guardia como en Party:** en `oEndless_AnimatronicPicker`, ←/→ rotan entre los guardias distintos de `global.Lives` con el mismo código que el clic de Party: pasiva, `set_guard_parameters()`, `pick_choices()`, Edwin y OMC. Solo cuenta la pasiva del guardia activo. A propósito, las pasivas no se combinan, porque hay combinaciones que se contradicen.
- **Curación de Dollie:** `coop_heal(full)` sustituye el código de curación en `oShopMenu_Create_0` y en `TextboxScripts` (DollieHeal/DollieFullHeal). La simple revive con 1 vida al guardia que falte o suma una al activo. La completa reconstruye `[ayudante, principal, principal]` y rota para dejar activo al actual. Fuera de Co-op hace lo mismo que el original.
- **v3 — pasivas del ayudante:** `guard_ability()` (en `EndlessGuardData`) devuelve `functional_guard_id(global.Guard) == x || coop_ability(x)`. `coop_ability()` cuenta la pasiva del **compañero** (`coop_partner()`: el guardia Co-op que no está activo y sigue en `global.Lives`), excepto las 4 de selección de animatrónicos (0 Jeremy, 2 Vanessa, 4 Michael, 5 Vannabelle), que siguen siendo solo del activo. Edwin (12) y OMC (20) no se cuentan doble al cambiar, porque `guard_ability` da lo mismo antes y después. Con The Boss (8) y Sally (19) juntos manda la 19, por el `else if` de `oCamera_Step_0`.
- **v3 — ayudante en la oficina:** en `oCamera_Draw_77`, el reflejo del monitor del guardia activo se desplaza 100 px a la izquierda. A la derecha se dibuja el compañero con `sNightGuardFacesSelection` (`import_sprites_solo(..., "selection.png", ...)`, frame `id*2`), espejado, a escala 0.85 y alineado abajo, con el mismo alfa del reflejo (0.25) y el mismo recorte al subir el monitor. Se borra en `oCamera_CleanUp_0`.
- **v3 — sin personajes repetidos:** el clic del principal ignora el guardia del ayudante, y el marco del ayudante se queda en gris (`HelperGuard = -1`) sobre el del principal. Las casillas muestran "1P" y "2P".
- **v3 — guardado:** `save_endless_data` guarda `_ModHelperMode` y `_ModCoopGuards`. `load_endless_data` los lee con `variable_struct_exists` (con las partidas viejas queda en `false`/`[]`), y `initialize_endless_data` los reinicia.
- El principal conserva el ratón y todas sus otras teclas, incluido Esc para pausar.
- Hay aviso con `error()` cuando se pulsa la máscara con el monitor arriba, o el monitor con la máscara puesta. En el juego original ambos casos fallan en silencio.

### Por qué flechas y no el teclado numérico
`oHappiestDayDrawer` (un jefe que aparece en la oficina) lee el teclado numérico 1–5 y las teclas 1–5. Las flechas solo se usan en el laberinto 3D y en `ShopPickerRoom`, que son otros rooms, así que no chocan con `room == Office`. Además, quedan lejos de WASD y cada jugador tiene su lado del teclado.

## Scripts modificados
| Script | Cambio |
|---|---|
| `gml_GlobalScript_ControlsScript` | `global.ModHelperMode`, `global.ModCoopGuards`, `coop_partner()` y `coop_heal()`; funciones `helper_active()`, `helper_key()` y `helper_input()`. `input_check`, `input_check_pressed` e `input_check_released` consultan primero las flechas si `helper_active()` |
| `gml_Object_oEndless_ModePicker_Create_0` | Título y descripción de Co-op Mode; las 4 tarjetas se desbloquean por defecto |
| `gml_Object_oEndless_ModePicker_Draw_0` | Cuadrícula de 2×2, dibujo de la tarjeta con "2P", clic como Solo más la bandera de ayudante |
| `gml_Object_oCamera_Step_0` | Dos ramas `else if` con `error()` para los bloqueos entre máscara y monitor |
| `gml_Object_oEndless_DifficultyPicker_Create_0` | Variables `HelperCursor`, `HelperGuard` y `HelperFocus` |
| `gml_Object_oEndless_DifficultyPicker_Draw_0` | Marco "2P" con flechas, desplazamiento automático, descripción del guardia del ayudante, Confirm condicionado, vidas en Co-op |
| `gml_Object_oEndless_AnimatronicPicker_Draw_0` | ←/→ cambian el guardia activo |
| `gml_Object_oShopMenu_Create_0` | Curación con `coop_heal()` |
| `gml_GlobalScript_EndlessGuardData` | `guard_ability()` + `coop_ability()` |
| `gml_GlobalScript_SaveData` | Guardar, cargar y reiniciar el estado Co-op |
| `gml_Object_oCamera_Draw_77` | Reflejo del principal desplazado + retrato del compañero a la derecha |
| `gml_Object_oCamera_CleanUp_0` | Borra el sprite del retrato |
| `gml_GlobalScript_TextboxScripts` | Curación de Dollie con `coop_heal()` (el script entero se recompila y al decompilarlo sale idéntico) |

`helper_active()` = `ModHelperMode && room == Office && global.Night == "Endless"`. Así no afecta a la historia, a Custom Night, a los menús ni a otros rooms donde se reusan los índices de acción.

## Compilar (desde la raíz del proyecto)
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

## Estado
- ✅ v3 compila (13 scripts). Al decompilar, 11 salen idénticos. En `ControlsScript` y `DifficultyPicker_Draw` solo cambian constantes que aparecen como números (`vk_*` → 37–40; `c_yellow`/`c_gray` → 65535/8421504). Una condición `a ? b : c && d` salía ambigua al decompilar, así que se reescribió con un `if`.
- SHA-256 de `build/data.win` (v3): `96e9eb577289de392e4660929d522a43b2d52535a917ed4a94d65be017111ac9`
- ❓ **v3 sin probar en el juego.** Paquete: `dist/Frickbears3-CoopTeclado-v3-v2.1.5.zip`. Versiones anteriores: v2 `dist/Frickbears3-CoopTeclado-v2-v2.1.5.zip` (`9b7dce9e…`) y v1 `dist/Frickbears3-CoopTeclado-v2.1.5.zip` (`3f758fb4…`).

## Limitaciones conocidas
- Las partidas Co-op guardadas con la v2 (sin los campos nuevos) se continúan como Solo normal.
- El ayudante solo se ve en el reflejo del monitor (el principal tampoco se ve en otro sitio) y no tiene versión "asustada", porque el sprite de selección no la trae.
- Fuera de la oficina, el ayudante solo tiene controles en el selector de guardia y en la pantalla de animatrónicos.
- Los textos de ayuda del juego siguen mostrando las teclas del principal.
- Con muchas teclas a la vez, algunos teclados pierden pulsaciones (*ghosting*). La solución es un segundo teclado USB para el ayudante, porque GameMaker lee todos los teclados como uno solo.
