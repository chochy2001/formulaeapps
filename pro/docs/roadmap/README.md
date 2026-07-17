# Roadmap de contenido P0 verificado (listo para generar)

Specs de contenido nuevo para Formulae Pro, redactadas y **verificadas
adversarialmente contra referencias de libros de texto** (Hibbeler, Beer, Sadiku,
Boylestad, Chang, Petrucci). Mismo esquema JSON que consumio el generador
determinista del lote de las 752 formulas de las imagenes.

## Contenido

| Dominio | Pantallas | Formulas | Estado |
|---|---|---|---|
| quimica_general | 10 | 62 | listo |
| estatica_y_resistencia_de_materiales | 12 | 86 | listo |
| circuitos_electricos | 15 | 86 | listo (1 correccion aplicada) |
| **Total** | **37** | **234** | |

## GATE DURO antes de produccion

A diferencia de las 752 formulas ya mergeadas (transcritas de los folletos
FISICOS del operador), estas 234 son formulas de **referencia** derivadas de
libros. **Requieren revision humana del operador antes de ir a produccion.** Por
eso viven aqui como specs y se materializarian a una **rama/PR de revision**,
nunca directo a main.

## Como generarlas (cuando el operador apruebe)

1. Revisar y aprobar las formulas de cada `spec-*.json`.
2. Anadir los 3 slugs a `NEW_SECTION_TITLES` del generador con titulos ES/EN.
3. Correr el generador determinista (mismo que el lote de imagenes) apuntando a
   estos specs, sobre un worktree limpio desde origin/main.
4. `flutter gen-l10n`, `flutter analyze --fatal-infos` (0), suite verde,
   actualizar las guardas de conteo de rutas/widget_mapper, build web.
5. Abrir PR para revision; no push directo a main.

## Circuitos electricos: decision pendiente

Verificar contra la seccion existente `electricidad_y_magnetismo` si ya cubre
circuitos DC/AC, para no duplicar y decidir el nombre final de la seccion.

## Graficos

El marco de sourcing esta resuelto (Wikimedia CC0/CC-BY, tikz.net CC BY-SA,
Matplotlib BSD, TikZ propio; GeoGebra vetado por licencia no comercial; render via
flutter_svg con recoloreo por tema). De los 35 graficos pendientes del lote de
imagenes, ~20 tienen candidato open-source identificado; ver
`GRAFICOS_PENDIENTES.md`. Estas 234 formulas de referencia no traen graficos
asignados todavia.

Fuentes verificadas por dominio estan dentro de cada `spec-*.json` (campo
`referencias` y `referencia` por formula).
