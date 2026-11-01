# Investigación: cómo hacer mods para Five Nights at Frickbear's 3

> Recopilado el 30 de octubre de 2026 y actualizado el 31 de octubre de 2026.
> Estado: **todo listo para empezar a modificar.** UndertaleModTool para Mac está instalado, el juego 2.1.5 está descargado y la prueba de extraer y volver a meter código funciona. Falta elegir el primer mod y cómo probar en Windows (ver sección 7).

## 0. Qué hay en la carpeta

| Carpeta | Contenido |
|---|---|
| `tools/utmt-cli/` | UndertaleModTool CLI 0.9.2.0 para Mac (arm64) |
| `downloads/` | Zips originales: el juego 2.1.5 y las 3 plantillas (copia limpia para reinstalar) |
| `game/` | Juego 2.1.5 descomprimido (versión de Windows: `Frickbears3.exe`, `data.win`, `audiogroup1-7.dat`, carpetas `texgroup_*` con los `.yytex`) |
| `original/data.win` | **Copia de seguridad intocable.** SHA-256 `c254b690b0e2ac7f…` |
| `dump/` | Código y recursos extraídos (`dump/CodeEntries/*.gml`) |
| `mod/` | Archivos editados por nosotros |
| `build/` | `data.win` modificado (generado) |
| `templates/` | Plantillas oficiales: Luigi, Grike y oficina |

### Resultado de `info` sobre el data.win 2.1.5
```
Project Name - "Frickbears3"   Is GMS2 - True   Is YYC - False   Bytecode version - 17
2189 Sounds, 1510 Sprites, 4652 Scripts, 593 Game Objects, 63 Rooms
6215 Code Entries, 34718 Strings, 476 Embedded Textures
```
**No está compilado a YYC**, así que el código GML se puede decompilar y editar.

### Comandos probados
```bash
# extraer un script
tools/utmt-cli/UndertaleModCli dump original/data.win -o dump -c gml_GlobalScript_VoiceLineSubtitles
# volver a meterlo y generar un data.win nuevo (replace NO acepta -f; si build/data.win ya existe, hay que borrarlo antes)
tools/utmt-cli/UndertaleModCli replace original/data.win -o build/data.win -c "gml_X=mod/gml_X.gml"
```
La prueba completa (extraer y volver a meter sin cambios) funcionó el 31 de octubre de 2026, y `original/data.win` quedó intacto. **Todavía no se ha probado un build dentro del juego** (hace falta Windows).

Más trucos de la línea de comandos:
- `dump ... -c UMT_DUMP_ALL` extrae todo el código en ~1 s (3346 archivos en `dump/CodeEntries/`). `--sprites` exporta todos los sprites a PNG (~30 s).
- Para varios scripts hay que **repetir `-c`** (`-c a -c b`). Separados por espacio no funciona.
- `load <data.win> -l '<C#>'` ejecuta C# sobre `Data`, sirve para consultar origen de sprites, contenido de rooms, etc. Un intento con interpolación `$"..."` y LINQ (`.Select`) falló; con concatenación `+` y bucles `foreach` funciona.

⚠️ Una vez la CLI se quedó colgada más de 5 minutos al compilar. Con la entrada cerrada (`</dev/null`) terminó en segundos. **Ejecutar siempre la CLI con `</dev/null`.**

## 0.1 Mods hechos
| Mod | Carpeta | Estado |
|---|---|---|
| Botón "Normal Mode" en el selector de modos de Brave Tower (4LD) | `mod/normal-mode-button/` (ver su README) | **Probado en Windows: funciona** (31 oct 2026). Paquete: `dist/Frickbears3-NormalModeButton-v2.1.5.zip`. **Sustituido por Co-op Mode** a petición del usuario |
| **Co-op Mode**: Solo Run + ayudante en el mismo teclado (flechas: puertas, máscara, ventilador) | `mod/coop-helper/` (ver su README) | **Nombre público: "Four Layers Down Co-op" v1.0** (para GameBanana. **Paquete para publicar: `dist/FourLayersDownCoop-v1.0-xdelta.zip`**, que trae el parche `FourLayersDownCoop-v1.0.xdelta` de 643 KB, hecho con `xdelta3 -e -9 -S none`, con README.txt en inglés y LEEME.txt en español; se probó aplicándolo y da el SHA de la v3. Paquete con el data.win completo, solo para pruebas propias: `dist/FourLayersDownCoop-v1.0.zip`. Mismo data.win que la v3; en el juego la tarjeta sigue diciendo "Co-op Mode"). **Versión actual, teclado v3** (`dist/Frickbears3-CoopTeclado-v3-v2.1.5.zip`, SHA-256 `96e9eb57…1ac9`): añade a la v2 las pasivas de noche y de economía del compañero (las 4 de selección siguen siendo solo del activo), el retrato del compañero a la derecha en el reflejo del monitor, el bloqueo de personaje repetido y el guardado del Co-op en `endlessdata`. Compila y se verificó al decompilar; **falta probarla en Windows**. — *v2* (`dist/Frickbears3-CoopTeclado-v2-v2.1.5.zip`, SHA-256 `9b7dce9e…57cb`): cada jugador elige guardia (el ayudante con las flechas), 3 vidas en total (2 del principal y 1 del ayudante), cambio de guardia con ←/→ en la pantalla de animatrónicos como en Party (solo cuenta la pasiva del activo) y curación de Dollie adaptada. En la oficina: ← y → puertas, ↓ máscara, ↑ ventilador. Compila y se verificó al decompilar; **falta probarla en Windows**. v1 de teclado (solo oficina): `dist/Frickbears3-CoopTeclado-v2.1.5.zip`. *Historial de la versión con mando, descartada:* v1 (`dist/Frickbears3-CoopHelper-v2.1.5.zip`): **falla al unirse**, el usuario pulsa START con el mando virtual "Touch" y no pasa nada. v1-diagnóstico (`dist/Frickbears3-CoopHelper-v2.1.5-diagnostico.zip`): se une con cualquier botón y muestra arriba "CONTROLLER CHECK" (slots, mandos detectados con `gamepad_get_description`, botones y ejes, botones pulsados). Resultado del diagnóstico: **"No controller detected by the game"** con Touch, aunque Touch emula un mando de Xbox. El juego usa el **runtime GameMaker 2023.11** (XInput en los slots 0–3 y DirectInput en 4–11), que detecta mandos Xbox reales o virtuales a nivel de sistema (ViGEm). Hipótesis: Touch no crea un mando de sistema, sino que lo inyecta por juego (como Steam Input u otras herramientas que meten su propio `xinput.dll`). El usuario confirmó que **Windows sí lo ve en `joy.cpl`**. Diagnóstico v2 (`dist/Frickbears3-CoopHelper-v2.1.5-diagnostico-v2.zip`): revisa los slots 0–15 a la fuerza (antes solo hasta `gamepad_get_device_count()`) y muestra `gamepad_is_supported()`. En joy.cpl aparece como **"Controller (XBOX 360 For Windows)"**, es decir, un mando XInput de sistema que debería caer en los slots 0–3. Resultado del v2: **`supported: 1`, `slots reported: 12`, "No controller detected"** en los slots 0–15. Es decir, el soporte de mandos del runner está activo, pero `gamepad_is_connected` es false en todos. El runner (`Frickbears3.exe`, GM 2023.11) carga `xinput1_4.dll`/`xinput1_3.dll` y `dinput8.dll`, importa `XInputGetState` y `XInputEnable`, y trae la base de mapeos SDL (incluido "Steam Virtual Gamepad"). O sea, es el XInput estándar que usan otros juegos. Siguientes pruebas pedidas: (1) abrir Touch y conectar ANTES de abrir el juego; (2) probar con un mando USB o Xbox real para saber si el juego ve algún mando en esa PC. Si nada funciona, plan B: ayudante por teclas propias. Plan B: un ayudante por teclado con teclas propias |

## 0.2 Investigación: modo "Ayudante" (cooperativo local, jugador principal + ayudante con mando)
Estado: **solo análisis, nada implementado.**

### Lo que dice el código
- **El juego no tiene soporte de mando** (0 llamadas a `gamepad_*`). Pero **el compilador de UTMT sí acepta `gamepad_*`**: se probó compilar `gamepad_is_connected`, `gamepad_axis_value`, `gamepad_button_check_pressed` y `gamepad_set_axis_deadzone`, y al decompilar salen intactas. Falta probarlo en el juego.
- **Entrada centralizada:** `input_check`, `input_check_pressed` e `input_check_released` (en `gml_GlobalScript_ControlsScript`) traducen una *acción* a tecla o botón del ratón con `global.Settings[0][acción]`. Es el punto ideal para conectar el mando **sin tocar los animatrónicos**.
  - Índices de acción: 0 Confirm, 1 Back, 2–5 Up/Left/Down/Right, **6 Monitor, 7 Mask, 8 Left Door, 9 Right Door, 10 Flashlight, 11 Fan, 12 Turn Around**, 13–20 cámaras, 21–24 sistemas, 25 Sprint, 26 Sneak.
  - ⚠️ Los mismos índices se reusan con otro significado fuera de la oficina: en el visor del edificio, 10 bloquea el cursor y 11 muestra la guía; en el minijuego TrashStacker, 12 hace otra cosa. **El reenvío al mando debe aplicarse solo con `room == Office`.**
- **El ratón se usa directo** en 116 archivos (215 usos de `mouse_check_button`, cámaras, tienda, minijuegos, animatrónicos que se clican). Por eso **el ayudante no debe usar cursor**: solo acciones con botón.
- **Reglas de la oficina** (`gml_Object_oCamera_Step_0`):
  - Puertas (8, 9) y ventilador (11): se pueden usar **siempre**, incluso con el monitor arriba.
  - Máscara (7): **bloqueada si el monitor está arriba** (`!(global.CamUp || HandheldUp)`). Falla en silencio, sin sonido.
  - Monitor (6): **bloqueado si la máscara está puesta** (`!global.MaskDown`).
  - Linterna (10): mientras se mantiene pulsada. Con el monitor arriba ilumina la cámara **en la posición del ratón** (`oCameraUI_Other_11`), así que depende del jugador principal.
  - Girarse (12): bloqueado con el monitor arriba. Cambia toda la vista.
  - Energía: `Usage = CamUp + Doors[0] + Doors[1] + Flashlight + Fan`, compartida.
- **Vidas en Brave Tower:** `global.Lives` es una pila de IDs de guardia (Solo = 3 copias del mismo; Party = varios, y el último es el que juega). El modo Ayudante **no las toca**: es un solo guardia y una sola partida.

### Reparto de roles propuesto
| Función | Principal (teclado + ratón) | Ayudante (mando) |
|---|---|---|
| Monitor, cámaras, sistemas, tienda del monitor | ✅ | — |
| Girarse | ✅ | — |
| Linterna (oficina y cámaras) | ✅ (apunta con el ratón) | opcional |
| Clics en la oficina (animatrónicos, honk, etc.) | ✅ | — |
| **Puerta izquierda / derecha** | — | ✅ LB / RB |
| **Máscara** | — | ✅ A (o Y) |
| **Ventilador** | — | ✅ B |
| Pausa | ✅ Esc | ✅ Start |
| Menús, tiendas, minijuegos, salvamentos 3D | ✅ | — (el ayudante descansa) |

### Contradicciones y cómo resolverlas
1. **No hay soporte de mando** → añadir lectura de mando en el *wrapper* de `input_check*`, con el mando del ayudante detectado al unirse (primer slot XInput conectado).
2. **Índices reutilizados fuera de la oficina** → reenviar al mando solo si `room == Office` y el modo Ayudante está activo.
3. **Máscara bloqueada con el monitor arriba** (el ayudante pulsa y no pasa nada) → por defecto respetar la regla original (coordinarse es parte del juego), pero dar **aviso**: vibración del mando y sonido `error()`. Opción "prioridad de máscara": si el ayudante la pide, se baja el monitor del principal.
4. **Monitor bloqueado con la máscara puesta** → el principal ya ve la máscara en pantalla. Añadir un indicador pequeño "MÁSCARA (ayudante)" y el sonido de error.
5. **Pantalla compartida**: la máscara oscurece la vista y apaga el audio para los dos → es inevitable con una sola pantalla. Es parte del diseño. Una pantalla dividida no es viable (rooms sin *views*, un solo `oCamera`, todo es estado global).
6. **Teclas del principal para puertas y máscara** (W/A/S/D por defecto) → modo **exclusivo**: el teclado no las controla mientras haya ayudante. Modo **compartido** opcional, en el que ambos pueden.
7. **Linterna en cámaras apunta con el ratón** → dejarla con el principal. Si el ayudante la tuviera, el principal apuntaría y el ayudante encendería, lo que es incómodo.
8. **El mando se desconecta a mitad de la noche** → volver automáticamente al teclado (modo solo), pausar y mostrar un aviso.
9. **Mecánicas especiales que reusan estas acciones** (`oBigTop` y `oFredbearAttack_Claw` usan 8 y 9; las puertas láser y las habilidades de guardia que quitan herramientas) → como solo se cambia de dónde viene la entrada, la lógica original sigue igual. Aun así, **hay que probarlas**.
10. **Guardar y continuar**: el modo Ayudante debe guardarse con la partida de Endless (añadir un campo en `save_endless_data` y `load_endless_data`), o tratarlo como un ajuste que se elige al continuar.
11. **Récords, trofeos y Daily Challenge**: decidir si las partidas con ayudante cuentan. Recomendado: que cuenten igual, o marcarlas.
12. **Fuera de la oficina** (tienda, minijuegos, laberinto 3D con vista de ratón en `oCamera3DMaze`) → el ayudante no hace nada. Una ampliación posible es que pause o confirme diálogos.

### Cómo se activaría
- En la pantalla de modos de Brave Tower: "Pulsa START en el mando para unirte como ayudante" → aparece el icono "Ayudante conectado". Funciona con Solo Mode y con Party Mode.
- Durante la noche: los botones del ayudante llegan directo a las acciones 7, 8, 9 y 11 a través de `input_check*`.

### ¿Pantalla dividida? (análisis del 31 oct 2026) — ❌ DESCARTADA por el usuario
> Decisión del 31 oct 2026: **no se hará pantalla dividida.** El multijugador será solo el modo Ayudante en pantalla compartida. El análisis queda abajo como referencia.
**Cómo dibuja hoy el juego la oficina** (`gml_Object_oCamera_Draw_0`):
- Hay **una sola cámara**. La oficina es **3D en perspectiva** y la vista gira siguiendo **la X del ratón** (`CamRotationH = (global.MouseX - room_width/2) / 3`).
- Al subir el monitor, **esa misma cámara** cambia a una vista ortográfica de la zona del room donde están las cámaras de seguridad (960,180). **Cada frame se ve la oficina O las cámaras, nunca las dos cosas.**
- Las rooms no tienen *views* activadas. La interfaz se dibuja a pantalla completa (640×360) en eventos de GUI: **149 objetos** tienen eventos Draw GUI o Post-Draw.
- **101 archivos leen `global.CamUp`**: muchos animatrónicos se comportan distinto según si "el guardia está mirando las cámaras".

**Pantalla dividida con sentido = principal en la oficina | ayudante en las cámaras, al mismo tiempo.** Contradicciones:
1. **Dibujar dos vistas por frame**: activar `view_camera[0]` y `[1]` con un viewport por mitad y elegir la vista según `view_current`. Todos los eventos Draw se ejecutan una vez por vista, así que los objetos que dibujan según `CamUp` tendrían que mirar `view_current`. → Viable, pero toca muchos objetos.
2. **La interfaz (149 objetos) asume pantalla completa**: el mapa de cámaras, los botones del monitor, la energía y la hora tendrían que reubicarse en la mitad derecha. Cada mitad mide 320 px de ancho: la interfaz queda diminuta o con barras negras (320×180 a escala 0,5).
3. **`CamUp` pierde su sentido**: hoy significa "el guardia mira cámaras y no la oficina". Con pantalla dividida pasaría a ser "el ayudante tiene el monitor abierto", y la IA de 101 archivos dejaría de estar equilibrada (ver oficina y cámaras a la vez facilita mucho el juego). Habría que redefinirlo y ajustar animatrónicos uno por uno.
4. **Máscara y monitor se bloquean entre sí**: habría que decidir si la máscara del principal cierra el monitor del ayudante.
5. **Controles**: la vista de la oficina se mueve con el ratón y las cámaras se manejan con clics (botones de cámara, ventilación, tienda, minijuegos). El que lleve el mando necesita un **cursor virtual con el stick** en su mitad.
6. **Rendimiento**: la oficina 3D más las cámaras cada frame es más carga, aunque probablemente asumible en PC.

**Conclusión:** es técnicamente posible, pero es un proyecto **mucho más grande** (decenas o cientos de archivos) y **cambia el equilibrio del juego**. Recomendación: primero el modo Ayudante **sin** pantalla dividida (pocos archivos y el juego intacto) y, si gusta, una "Fase 2 experimental" de pantalla dividida limitada a oficina más cámaras.

### Botón de entrada (petición del 31 oct 2026)
El usuario quiere que el botón añadido (la 4.ª tarjeta del selector de modos) **lleve al multijugador** y que este **funcione igual que Solo Run**: un guardia, 3 vidas (`global.NuzlockeMode = 0`), las mismas rondas y tiendas, más el ayudante en la oficina.
- Implementación: en `oEndless_ModePicker_Draw_0`, la tarjeta 4 usa la misma rama que Solo Mode (`NuzlockeMode = 0` → `oEndless_DifficultyPicker`), pero activa `global.ModHelperMode = true` y pide unir el mando ("Pulsa START").
- **Decidido:** reemplaza a la tarjeta "Normal Mode". ✅ Implementado en `mod/coop-helper/` (versión 1: puertas, máscara, ventilador y pausa con el mando; avisos de bloqueo con sonido; sin vibración, porque podría quedarse encendida al cambiar de room).
- **Cambio de rumbo (31 oct 2026):** el runner no detecta el mando virtual Touch, así que el usuario pidió que el ayudante use **teclas** y que sea cómodo para los dos. ✅ Versión de teclado en `mod/coop-helper/`: ← y → puertas, ↓ máscara, ↑ ventilador, en modo exclusivo y solo con `room == Office` en Endless. La tarjeta está siempre desbloqueada y ya no hay paso de unirse. Se eligieron las flechas en vez del teclado numérico porque `oHappiestDayDrawer` (jefe de la oficina) lee el numérico 1–5 y las teclas 1–5. Las flechas solo se usan en el laberinto 3D y en `ShopPickerRoom`, que son otros rooms. Todo el código de mando y el diagnóstico se quitaron.
- **Guardias en Co-op (31 oct 2026, decidido con el usuario):** cada jugador lleva su guardia y el ayudante lo elige con las flechas. Las pasivas funcionan **como en Party**: solo cuenta la del guardia activo, que se cambia en la pantalla de animatrónicos. Al cambiar, `pick_choices()` vuelve a generar la lista con la pasiva nueva (Jeremy: baratos; Vanessa: caros; Michael: juego base; Vannabelle: actualización). Esto viene de `ability_check()` en `oEndless_AnimatronicPicker_Create_0`. **Se descartó combinar las dos pasivas**: hay contradicciones (Jeremy con Vanessa, Edwin, Fritz con Hudson, Strings) y `guard_ability()` aparece 82 veces en 21 archivos. Vidas: 3 en total, `[ayudante, principal, principal]`. La curación completa de Dollie en Solo hace `array_create(3, global.Guard)` y borraría al otro guardia, así que se cambió por `coop_heal()`.
- **v3 (31 oct 2026, petición del usuario):** las pasivas que no son de selección de animatrónicos también cuentan para el compañero. Se hace en `guard_ability()` → `coop_ability()`, con el compañero vivo, sin tocar los 82 usos. El guardia solo se ve en el juego en el **reflejo del monitor** (`oCamera_Draw_77`, `reflection.png`, 640×360, centrado). El compañero se dibuja a la derecha con `selection.png` (`sNightGuardFacesSelection`, 480×360, alineado a la izquierda, 2 frames por guardia: color y silueta). Mapa guardia → pasiva (= id): 0 Jeremy baratos, 2 Vanessa caros, 3 Fritz tiendas de reto, 4 Michael roster base, 5 Vannabelle roster nuevo, 6 Clark, 7 Frank, 8 The Boss meta de fichas, 9 Billy FredTV+, 10 Henry agresividad x2, 11 William Beartrap y muerte = fin, 12 Edwin, 13 Fiona, 14 Elizabeth retos de Eleanor, 15 Cassie energía/máscara, 16 Hudson energía 1 barra, 17 Mary tiempo, 18 Strings pánico, 19 Sally meta de minijuegos, 20 OMC. Guardado: claves extra `_ModHelperMode` y `_ModCoopGuards` en `endlessdata<versión>.txt`; el juego original las ignora.

### Archivos que habría que tocar (estimado)
- `gml_GlobalScript_ControlsScript` (*wrapper*: el núcleo del mod)
- `gml_Object_oSuperGameManager_Step_1` (detectar el mando, desconexión, pausa con Start)
- `gml_Object_oEndless_ModePicker_Create_0` y `_Draw_0` (unirse como ayudante; ya los modificamos para el botón Normal Mode)
- `gml_Object_oCamera_Step_0` (aviso al ayudante cuando la máscara está bloqueada; prioridad de máscara opcional)
- `gml_Object_oCamera_Draw_*` o `oCameraUI` (indicador en pantalla)
- `gml_GlobalScript_SaveData` (guardar el modo)

Mapa útil del código (para próximos mods):
- Menú de título (base y 4LD, también la pausa): `oTitleMenu` (`goto_menu()` en Create y la lógica en Step: `new_game(dificultad)`)
- Título 4LD: `o4LD_Title`, room `TitleScreen4LD`. Título base: `oCameraTitleScreen`, room `TitleScreenMap`
- Brave Tower: `oEndless_NewOrContinue` → `oEndless_ModePicker` → `oEndless_DifficultyPicker` → `oEndless_AnimatronicPicker` (room `EndlessSelection`)
- `title_screen()` devuelve `TitleScreen4LD` o `TitleScreenMap` según `global.FourLayersDownMode`

---

## 1. El juego

| Dato | Valor |
|---|---|
| Nombre | Five Nights at Frickbear's 3 (fangame de FNaF 3) |
| Desarrollador | SpookyRick (Game Jolt) |
| Distribución | Gratis en Game Jolt, solo para **Windows** |
| Motor | **GameMaker Studio** (compilado en modo VM: el código GML está dentro del `data.win` y se puede editar) |
| Versión actual | **2.1.5**, con la expansión "Four Layers Down" (4LD). Confirmado en Game Jolt el 31 de octubre de 2026. |
| Página en Game Jolt | https://gamejolt.com/games/frickbears3/930477 |
| Versión antigua | 1.1.4. Los mods hechos para la 1.1.4 no siempre funcionan en la 2.0 |
| Carpeta de datos del usuario | `C:\Users\<usuario>\AppData\Local\Frickbears3\` |

No hay una guía oficial para modificar el `data.win`; para eso solo están los **tutoriales de la comunidad en GameBanana**. Pero el desarrollador **sí publica plantillas oficiales para addons** en Game Jolt, cada una con su README.

### Descargas en Game Jolt (juego 930477)
Se consultan con `https://gamejolt.com/site-api/web/discover/games/overview/930477`

| Archivo | Tamaño | Qué es |
|---|---|---|
| `frickbears3-4ld-v2.1.5.zip` | 430,5 MB | **Juego completo + 4LD (actual, Windows)** |
| `frickbears3-v1.1.4.zip` | 216,8 MB | Archivo de la versión base 1.1.4 |
| `luigi-basic-guard.zip` | 0,1 MB | Plantilla **oficial** de guardia sencillo |
| `grike-advanced-guard-template.zip` | 3,3 MB | Plantilla **oficial** de guardia avanzado (incluye lo añadido en la 1.1.0) |
| `basic-office.zip` | 0,8 MB | Plantilla **oficial** de oficina personalizada |

---

## 2. Dónde está la comunidad

- **GameBanana, el sitio principal:** https://gamebanana.com/games/24426 (más de 7.000 suscriptores, 27 tutoriales)
- **Sitio de fans (no oficial):** https://frickbears3.org/mods/ y https://frickbears3.org/faq/
- **Wiki:** https://frick-fazbears.fandom.com/wiki/Five_Nights_At_Frickbear's_3_(Game)
- **Consejo:** las páginas de GameBanana cargan el contenido con JavaScript. Para leerlas sin navegador se puede usar su API pública:
  - Tutorial: `https://gamebanana.com/apiv11/Tutorial/<id>/ProfilePage` (el campo `_sText` tiene el texto)
  - Mod: `https://gamebanana.com/apiv11/Mod/<id>/ProfilePage`
  - Lista de tutoriales: `https://gamebanana.com/apiv11/Tutorial/Index?_nPage=1&_nPerpage=50&_aFilters%5BGeneric_Game%5D=24426`

---

## 3. Dos formas de hacer mods

### A) Addons, sin tocar el código
El juego carga contenido personalizado desde `AppData\Local\Frickbears3\`:

- **Guardias personalizados**, en `addons/`:
  - Cada guardia lleva un `properties.txt` (en formato JSON) con la altura, los textos de salvamento, la habilidad, etc., más imágenes, sonidos y diálogos.
  - Habilidad de Endless Mode: añadir `"ability": <n>,` debajo de `"player_sneak_height"`. Solo se pueden usar las habilidades que ya trae el juego (0–17+). Algunas no funcionan en la 2.0.2.
  - Para instalar: se descomprime el addon dentro de `addons/` y se reinicia el juego.
- **Skins de oficina**, en `offices/<nombre>/`:
  - PNG con nombre fijo: `wall_left.png`, `wall_front.png`, `wall_right.png`, `wall_back.png`, `outside_1.png`, `outside_2.png`
  - Opcionales: `door_left.png`, `door_right.png`, `fan_off.png`, `fan_on1.png`, `fan_on2.png`, `windowblinds_left.png`, `windowblinds_right.png`, `tv.png`, `tv_on.png`, `tv_animations/`, `hangingdecoration.png`
  - Un icono de 48x48
  - Un `data.txt` obligatorio (si falta, el juego se cierra):
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
- **Mods de guardia para usar de ejemplo:** Garfield (https://gamebanana.com/mods/706385, versión 4LD, "incluye todas las imágenes, sonidos, propiedades y diálogos posibles") y Spooky (https://gamebanana.com/mods/663620)

### A.2) Documentación oficial de las plantillas (descargadas en `templates/`)
Fuente: los README de las plantillas oficiales de Game Jolt, escritos por BubbledDEV. **Los archivos de `SPOILERS/` no se han leído a propósito.**

- `templates/luigi-basic-guard/`: guardia sencillo. El README lista los archivos mínimos.
- `templates/grike-advanced-guard-template/`: guardia avanzado. `README.txt` es la documentación completa y `README_ForParameters.txt` explica las habilidades de 4LD.
- `templates/basic-office/`: oficina personalizada. `readme.txt` explica las coordenadas.

**Guardia personalizado: lo esencial**
- El nombre de la carpeta es el nombre en el juego. El texto entre paréntesis no se muestra: "Mike (Awesome Version)" aparece como "Mike".
- Los IDs de los guardias personalizados empiezan en **21**, por orden alfabético dentro de `addons/`.
- **Obligatorios (\*):** `extras_info.txt`, `opening_dialogue.txt`, `portrait.png` (cualquier tamaño), `icon.png` (48x48), `outside.png` (640x256), `silhouette.png` (96x128), `reflection.png` (1280x360, dos mitades: normal y en peligro), `minigame.png` (64x16, 4 frames, **solo los 4 colores de la plantilla**) y el sonido de voz al hablar.
  - ⚠️ El README de Grike llama a ese sonido `textsound.ogg`, pero el archivo de las dos plantillas se llama `talksound.ogg`. **Usar `talksound.ogg`.**
- **Opcionales:** `mask.png` (1280x480, dos mitades: normal y con "Cool Glasses"), `properties.txt`, `voicelines/`, `dialogue/`, `songs/`, `bar/give.txt` y `bar/receive.txt`.
- **Voces** (`voicelines/`): `voc_selection_01.ogg`, `voc_die_*`, `voc_gameover_*`, `voc_victory_*`, `voc_salvageopening_*`. Cada una lleva un `.txt` de subtítulos con este formato: `[["texto", 0], ["texto", 1]]`.
- **`properties.txt` (JSON):**
  - `player_height` (24–80, por defecto 48) y `player_sneak_height` (8–24, por defecto 16)
  - `theme_intro`, `theme_game_over`, `theme_victory`, `theme_victory_night5`, `theme_victory_night6`: `["archivo.ogg", volumen]` desde `songs/`
  - `music_player`: `[nombre, archivo, bpm, nombre original, fuente, [inicio_loop, fin_loop]?]`
  - Diálogos sueltos: `maze_rules_poster`, `maze_newspaper_1/2/3`, `upgrade_cadet_story`, `helpy`, `psy_friend_fredbear_house`, `dreadbear` (arrays de `[texto, hablante]`); `withered_bonnie` y `bb_quiz_answer` (strings)
  - `new_opening_dialogue: true`: usa `dialogue/cutscene_Opening.txt`
  - `ability` (entero) y `fld_parameters` (struct con animatrónicos, minijuegos, multiplicadores, energía inicial, etc.)
- **Diálogos** (`dialogue/cutscene_*.txt`): JSON `{"DIALOGUE": [["texto","Hablante"], ...]}`
  - Comandos: `["_skip"]`, `["_delay", frames]` (60 fps), `["_effect", ini, fin, "Shake"]`, `["_lock"]`, `["_buffer"]`, `["_func", [[...]]]`
  - Funciones: `fadeOut`, `fadeIn`, `playSound`, `playMusic`, `fadeMusic`, `salvage`, `credits`
  - Si falta un diálogo, el juego usa uno genérico. **Conviene validar el JSON**, porque un error de formato cierra el juego con "JSON parse error".
- **Consola de trucos** (útil para probar): `room EndlessShopOMC` lleva directo al paseo en bote; `tipsy <id> <id>` prueba los diálogos del bar.

**Oficina personalizada: lo esencial**
- Coordenadas: pared izquierda (0,0), centro (512,0), derecha (1024,0), trasera (512,512). La pared trasera se muestra **volteada** en el juego.
- `data.txt` incluye además `Description` y `MinigamePalette` (colores RGB, del más claro al más oscuro).
- `music/`: `night1–6.ogg` y `custom1–6.ogg` reemplazan la música de cada noche.
- `cameras/cam01–08.png`: vistas de cámara. Para cambiar el edificio se recomienda UTMT (texturas con prefijo `TitleTex`) y el visor de edificio del juego (teclas numéricas para cambiar de cámara, TAB para captura).

### B) Editar el `data.win`: el camino elegido ✅
El `data.win` contiene todo el código GML, los sprites, los sonidos y los textos. Se edita con **UndertaleModTool (UTMT)**.

Detalles técnicos que salen en los tutoriales:
- Los textos de los subtítulos están en `gml_GlobalScript_VoiceLineSubtitles`. Formato con varias líneas por audio:
  ```gml
  case voc_RWQFSFASXC_YOUSUCK:
      return [["Y.", "O.", "U.", "S.", "U.", "C.", "K."], [0, 2, 4, 6, 8, 10, 12]];
  ```
  El segundo array indica en qué segundo cambia cada línea.
- El diálogo del estacionamiento está en `gml_GlobalScript_TextBoxScripts_ParkingLotScript`, con `add_page("texto", "Nombre");`. Números de guardia: 0 Jeremy, 1 Mike, 2 Vanessa, 3 Fritz, 4+ guardias personalizados.
- Para crear un modo de dificultad nuevo hay que tocar: `gml_GlobalScript_SaveData`, `gml_Object_oCameraCredits_Create_0`, `gml_Object_oExtras_Statistics_Create_0`, `gml_Object_oTitleMenu_Create_0`, `gml_Object_oTitleMenu_Draw_77`, `gml_Object_oTitleMenu_Step_0`. Las dificultades se definen en `switch (global.Difficulty)` (0 Easy, 1 Normal, 2 Hard, 3 Lunatic).
- Los sprites de la oficina se encuentran filtrando por `sOffice*` (además de `sBrokenGlass`).
- **Sonidos:** se importan en `.ogg` con el mismo nombre que el original, usando `ImportSingleSound.csx`. Hay que importarlos de uno en uno, porque importar varios a la vez crea un audiogroup nuevo y puede romper el juego.
- **Archivos YYTEX** (retratos, pantallas de muerte, título): si se reemplazan directamente, se restauran al reabrir el juego. La solución es crear una Embedded Texture, una Texture Page Item y un Sprite nuevos, y cambiar el código que los dibuja.
- **Partidas guardadas:** el archivo `savedata` con extensión `.wario` es texto tipo JSON (`"_Guard":4.0`, `"_Salvages":[5.0,9.0,30]`). IDs de mejoras: https://pastebin.com/raw/hhYB8pxB
- **Distribución:** lo normal es publicar un parche `.xdelta` (se instala con DeltaPatcher) en vez del `data.win` entero.

---

## 4. Tutoriales de GameBanana (los 27)

| ID | Título | Tema |
|---|---|---|
| 19849 | Very simple and basic modding guide | **Para empezar**: UTMT, sonidos, textos |
| 19608 | Texture Swapping Guide - Office | Exportar y reemplazar sprites |
| 19899 | How to overwrite YYTEX files (Kinda) | Texturas que no se dejan reemplazar |
| 19662 | Basic Custom Gamemode Tutorial | Dificultad nueva (código) |
| 19944 | How to change max AI Level | Lógica del juego |
| 19900 | How to do weird things with camera | Cámara |
| 19898 | Putting (Interactable) Objects in the office | Objetos en la oficina |
| 20219 | Add New Sounds to a Audiogroup | Audio |
| 19694 | How to add Custom Voice lines for the Office | Audio |
| 19685 | How to add Custom Sprites to the Main Menu | Sprites |
| 19635 | How to add custom sprites to the Parking lot scene | Sprites |
| 19679 | How to add multiple guard reflections | Guardias |
| 19612 | How to add multiple voiced characters for your mod | Voces |
| 19582 | Adding Dialog to custom characters | Diálogo (obsoleto desde la 1.1.0) |
| 19579 | Evil Ending Newspaper Text Guide | Textos |
| 20426 | Offices Skin Tutorial | Addon de oficina |
| 20427 | Endless Mode Abilities to your Custom Guard | Addon de guardia |
| 20440 | I found where to put custom guards boatride dialog | Addon de guardia |
| 20423 | (4LD) Info on guard voicelines | Addon de guardia |
| 20006 | CANIMI Tutorial - Video | https://youtu.be/BiOodsnNVm8 |
| 19605 | Adding mods with a Data.win file | Instalar mods |
| 19617 | How to install a DeltaPatcher mod | Instalar parches xdelta |
| 19636 | Basic Save Editing | Partidas guardadas |
| 20443 | Quick Guide on how to Modify your Records and More | Récords |
| 20434 | How to unlock the two new bloodstone trophies | Jugabilidad |
| 19823 | what are some tips to beat night 2 | Jugabilidad |
| 19593 | Gallery ERROR Fix (1.0.2 or Earlier) | Corrección antigua |

URL de cada uno: `https://gamebanana.com/tuts/<ID>`

---

## 5. Cómo hacerlo desde el Mac

### Equipo (revisado)
- macOS 27.0.1, **Apple Silicon (arm64)**
- Instalados: Homebrew, git, Python 3.14
- No instalados: .NET, Wine, CrossOver, máquina virtual, xdelta

### UndertaleModTool 0.9.2.0 (23 de agosto de 2026)
- Versiones: https://github.com/UnderminersTeam/UndertaleModTool/releases
- La interfaz gráfica (la que usan los tutoriales) **solo existe para Windows**.
- Hay **versión de línea de comandos nativa para Mac**: `UTMT_CLI_v0.9.2.0-macOS.zip` (60,8 MB, arm64). También hay una `-macOS-x86.zip` de 68,3 MB.
- Comandos (sacados del código fuente, `UndertaleModCli/Program.cs`):

| Comando | Opciones | Para qué |
|---|---|---|
| `info <datafile>` | `-v` | Versión de GameMaker y datos básicos |
| `dump <datafile>` | `-o dir`, `-c <scripts \| UMT_DUMP_ALL>`, `-s` textos, `-t` texturas, `--sprites` | Extraer contenido |
| `replace <datafile>` | `-o salida`, `-c 'gml_X=./archivo.gml'`, `-t 'Texture 0=./img.png'` (o `UMT_REPLACE_ALL`) | Volver a meter cambios |
| `load <datafile>` | `-s a.csx b.csx`, `-l "C#"`, `-i` interactivo, `-o`, `-f` | Ejecutar scripts `.csx` |
| `project build` | `-s origen`, `-d destino` y `project.json` | Sistema de proyectos de la 0.9 |
| `new` | `-o`, `-f` | Crear un data file vacío |

### Cómo se trabajaría
1. Bajar el zip de Windows del juego desde Game Jolt y descomprimirlo (no hace falta ejecutarlo).
2. Copiar `data.win` a `original/data.win` y **no tocarlo nunca**.
3. `dump` del código o recursos que se quieran cambiar a `dump/`.
4. Editar los `.gml` en `mod/`.
5. `replace` para generar `build/data.win`.
6. Probar en Windows.
7. Crear el parche para publicar: `brew install xdelta` y luego `xdelta3 -e -s original/data.win build/data.win mod.xdelta`.

Estructura de carpetas propuesta:
```
tools/      # UTMT CLI
original/   # data.win sin modificar (copia de seguridad)
dump/       # código y recursos extraídos
mod/        # archivos editados
build/      # data.win modificado
```

### Para probar el juego hace falta Windows
- **CrossOver** (de pago, prueba de 14 días): lo más sencillo para juegos ligeros de GameMaker. Ahí también podría funcionar la interfaz gráfica de UTMT (sin comprobar).
- **Parallels con Windows 11 ARM:** lo más fiable, pero cuesta más.
- **UTM** (gratis): sin aceleración gráfica puede ir lento.
- **Una PC con Windows:** pasarle el `data.win` modificado.

### Limitaciones de la versión para Mac
- Para editar código y texturas va bien.
- Importar **sonidos o sprites nuevos** es más incómodo: los scripts `.csx` de la comunidad (`ImportSingleSound.csx`, etc.) suelen abrir ventanas, y habría que adaptarlos para la línea de comandos.
- Los tutoriales dan por hecho la interfaz gráfica, así que hay que traducir sus pasos a comandos.
- **Mirar el código te destripa los finales.**

---

## 6. Precauciones (del sitio de fans y los tutoriales)
- Instalar sobre una versión limpia y comprobar que arranca antes de modificar nada.
- Hacer una copia con fecha de la carpeta de partidas guardadas antes de cada cambio, y guardarla fuera del disco del juego.
- Un mod a la vez, y jugar una noche completa antes de añadir otro.
- Si DeltaPatcher falla: o la versión del juego no es la correcta o ya hay otro mod instalado. Reinstalar limpio.
- Descargar los mods de la página de su autor, no de resubidas.

---

## 7. Próximos pasos
- [x] Descargar `UTMT_CLI_v0.9.2.0-macOS.zip` del GitHub oficial (SHA-256 `03042fa7…5444ef`, coincide con GitHub). Descomprimido en `tools/utmt-cli/`. Funciona en arm64 sin instalar .NET.
  - Se ejecuta con: `tools/utmt-cli/UndertaleModCli --help`
- [x] Crear la estructura de carpetas (`tools/`, `original/`, `dump/`, `mod/`, `build/`)
- [x] Bajar `frickbears3-4ld-v2.1.5.zip` (430,5 MB) de Game Jolt y copiar `data.win` a `original/`
- [x] Bajar las plantillas oficiales (Luigi, Grike, oficina) a `templates/`
- [x] Ejecutar `info` para confirmar la versión de GameMaker y que se lee bien (GMS2, VM, bytecode 17)
- [x] Prueba de extraer y volver a meter un script
- Las URLs de descarga de Game Jolt se obtienen con `POST https://gamejolt.com/site-api/web/discover/games/builds/get-download-url/<buildId>` (body `{}`). Los IDs de build están en la tabla de la sección 2.
  - Build IDs: juego 2.1.5 = `2063625`, Luigi = `1924814`, Grike = `2063550`, oficina = `2061941`
- [ ] Decidir el primer mod (algo simple: cambiar textos o subtítulos, o una textura de la oficina)
- [ ] Elegir cómo probar en Windows (CrossOver / Parallels / UTM / PC)
- [x] Instalar `xdelta` para generar el parche final (`brew install xdelta`, xdelta3 3.2.2)
