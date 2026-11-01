# Four Layers Down Co-op

Mod de cooperativo local para **Five Nights at Frickbear's 3 + Four Layers Down v2.1.5** (Windows, GameMaker), de SpookyRick.
*Local co-op mod for Brave Tower: a main player and a helper on one keyboard.*

En Brave Tower aparece la tarjeta **"Co-op Mode"**:

- Cada jugador elige su guardia (sin repetir) y hay 3 vidas compartidas.
- El ayudante, con las flechas, maneja las puertas (← →), la máscara (↓) y el ventilador (↑).
- El guardia activo se cambia en la pantalla de animatrónicos, como en Party Mode. Las pasivas de Jeremy, Vanessa, Michael y Vannabelle son solo del guardia activo; las demás cuentan para los dos.
- El guardia del ayudante aparece en el reflejo del monitor, a la derecha del principal.
- La partida Co-op se guarda y se puede continuar.

## Descarga e instalación
El paquete es [`dist/FourLayersDownCoop-v1.0-xdelta.zip`](dist/FourLayersDownCoop-v1.0-xdelta.zip): un parche `.xdelta` para DeltaPatcher, con README.txt en inglés y LEEME.txt en español. Se aplica sobre el `data.win` original v2.1.5, cuyo SHA-256 es `c254b690b0e2ac7f52914fecc24d4753106a3daf893b11252c3c43ec5ae0df5b`.

## Estructura
| Ruta | Contenido |
|---|---|
| `mod/coop-helper/` | Scripts GML del mod y su [README](mod/coop-helper/README.md) técnico |
| `mod/normal-mode-button/` | Primer mod de prueba: botón "Normal Mode" en Brave Tower |
| `build/FourLayersDownCoop-v1.0.xdelta` | Parche de la v1.0 |
| `INVESTIGACION_MODDING.md` | Investigación, herramientas, flujo de trabajo y decisiones de diseño |

El juego, el código decompilado, los `data.win` completos y las herramientas **no** están en el repositorio (ver `.gitignore`).

## Compilar
Se necesitan [UndertaleModTool CLI](https://github.com/UnderminersTeam/UndertaleModTool) (en `tools/utmt-cli/`), el `data.win` original en `original/` y `xdelta3`. El comando de compilación está en [mod/coop-helper/README.md](mod/coop-helper/README.md). Para crear el parche:

```bash
xdelta3 -e -9 -S none -s original/data.win build/data.win build/FourLayersDownCoop-v1.0.xdelta
```

## Créditos
Five Nights at Frickbear's 3 pertenece a SpookyRick. Este es un mod no oficial de fans.
