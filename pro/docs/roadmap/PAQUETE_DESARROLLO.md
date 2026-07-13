# Paquete de desarrollo — Roadmap Formulae Pro (specs verificadas + gráficos)

Fecha: 2026-07-12
Fuentes: `roadmap/spec-*.json` (3 clusters), `scratchpad/generador.py`,
`investigacion/graficos-open-source.md`.

> NOTA DE PROCEDENCIA: la tarea mencionaba `PLAN_GRAFICOS_SOURCING.md`; ese
> archivo no existe en el workspace. El sourcing de gráficos verificado vive en
> `scratchpad/investigacion/graficos-open-source.md` y es la fuente usada aquí.

---

## 1. Resumen: dominios listos para implementar

Las 3 specs comparten el MISMO esquema que consume `generador.py`
(`cluster`, `target_seccion`, `es_nueva`, `pantallas[].{titulo_es, titulo_en,
archivo, formulas[].{nombre_es, nombre_en, latex, condiciones, referencia}}`).
Las tres son secciones NUEVAS (`es_nueva: true`) y ninguna está en
`EXISTING_SECTIONS`, así que cada una generará submenú + botón en el menú
principal.

| Dominio (target_seccion) | Pantallas | Fórmulas | Estado |
|---|---:|---:|---|
| `quimica_general` | 10 | 63 | LISTO — autocontenido, sin solape |
| `estatica_y_resistencia_de_materiales` | 12 | 86 | LISTO — dominio nuevo, sin solape |
| `circuitos_electricos` | 15 | 86 | LISTO en contenido; requiere DECISIÓN humana de nombre de sección (solape conceptual con la sección de física existente) |
| **TOTAL** | **37** | **235** | |

Desglose por pantalla:

- **quimica_general (10 / 63):** Mol y N_A (6), Masa molar y composición (4),
  Fórmula empírica y molecular (5), Estequiometría (4), Reactivo limitante y
  rendimiento (4), Leyes de gases ideales (10), Concentraciones (8), Equilibrio
  químico (5), pH/pOH y ácido-base (10), Termoquímica básica (7).
- **estatica_y_resistencia_de_materiales (12 / 86):** Equilibrio del cuerpo
  rígido (9), Centroides y CG (10), Momento de inercia de áreas (9), Armaduras
  nodos/secciones (6), Esfuerzo normal y cortante (6), Deformación y Hooke (9),
  Esfuerzo por flexión (7), Cortante en vigas (6), Torsión en ejes (7), Esfuerzo
  térmico (4), Círculo de Mohr / transformación (8), Factor de seguridad (5).
- **circuitos_electricos (15 / 86):** Ohm y potencia CD (8), Serie/paralelo (7),
  Divisores (5), Mallas (4), Nodos (4), Thévenin (4), Norton (4), Máxima
  transferencia (5), Capacitor (6), Inductor (5), Transitorios RC/RL (7), CA y
  RMS (7), Reactancia/impedancia (7), Potencia CA y FP (6), Resonancia RLC (7).

### Cuáles necesitan revisión humana y por qué

TODO el paquete requiere firma humana antes de producción, con estos focos:

1. **Las 235 fórmulas son de REFERENCIA (libros de texto), no transcritas de
   imágenes del operador.** Fuentes: Hibbeler, Beer & Johnston, Sadiku,
   Boylestad, Nilsson & Riedel, Irwin, Chang, Petrucci. A diferencia del lote
   de 752 fórmulas ya mergeado (que vino de folletos del operador), aquí no hay
   una imagen-fuente que valide cada símbolo. Un ingeniero/químico debe revisar
   antes de prod (Constitución + AI_QUALITY_PLAYBOOK: evidencia antes de
   `main`/prod).

2. **`circuitos_electricos` — nombre de sección y no-duplicación.** El propio
   spec trae `nota_no_duplicacion`: ya existe
   `electricidad_y_magnetismo/circuitos_electricos.dart` con enfoque FÍSICO
   (Ohm microscópica J=σE, arrastre, Joule, RC detallado). Esta sección nueva es
   de ANÁLISIS DE CIRCUITOS (ingeniería: divisores, mallas, nodos,
   Thévenin/Norton, fasores, RLC). No hay colisión de ruta de archivo (una es
   screen dentro de `electricidad_y_magnetismo/`, la otra sería sección
   top-level `circuitos_electricos/`), y `uniq()` resuelve colisiones de
   clase/ruta/l10n con sufijo numérico — pero el usuario vería DOS entradas
   parecidas. Decisión humana recomendada: titular la nueva como
   "Análisis de circuitos" para diferenciarla de la física "Circuitos
   eléctricos".

3. **Títulos de sección faltantes en el generador.** `NEW_SECTION_TITLES` en
   `generador.py` (líneas 24-31) NO incluye los 3 nuevos slugs. Sin ellos el
   fallback produce `sec.replace('_',' ').title()` → "Quimica General",
   "Estatica Y Resistencia De Materiales", "Circuitos Electricos" (sin acentos,
   "Y"/"De" capitalizadas) y ADEMÁS pone el MISMO string en ES y EN (rompe
   bilingüe). Hay que añadir entradas ES/EN correctas ANTES de correr.

4. **Correcciones auto-señaladas en los specs** — verificar puntualmente:
   - circuitos, "Valor medio de senoide rectificada": el spec ya trae
     `[corregido: ...]` (2·Vm/π = onda completa, no media onda). Confirmar.
   - quimica, nota de coordinación: N_A (6.022e23) y R (8.314 / 0.08206) YA
     viven en la sección de constantes; estas pantallas los referencian por
     símbolo y NO deben duplicar sus valores. El generador solo emite líneas
     `Latex(...)` (no crea entradas de constante), así que no duplica por
     diseño — pero revisar que ninguna pantalla se lea como "definición de
     constante".

---

## 2. Orden de implementación y uso del generador determinista

### Orden recomendado (de menor a mayor riesgo)

1. **`quimica_general`** — el más limpio: dominio nuevo, cero solape con
   secciones existentes, sin decisiones de nombre pendientes más allá del
   título de sección.
2. **`estatica_y_resistencia_de_materiales`** — dominio nuevo sin solape;
   volumen alto (86 fórmulas) pero mecánico.
3. **`circuitos_electricos`** — al final, porque es el único con decisión
   humana abierta (nombre/no-duplicación frente a la sección de física).

Se pueden generar los tres en una sola corrida del generador (agrupa por
`target_seccion`) una vez tomada la decisión de nombres; el orden anterior es
para revisión y para acotar el blast radius si algo falla.

### Cómo reusar el generador (a RAMA/PR, no a main)

El generador está escrito para `brechas/gap-*.json`. Estas specs son
`roadmap/spec-*.json` con esquema idéntico. Dos caminos equivalentes:

- **Opción A (recomendada, menos cambios de código):** copiar/enlazar los 3
  `spec-*.json` al directorio `brechas/` renombrados `gap-*.json` (el generador
  solo lee `target_seccion`, `es_nueva`, `pantallas[]` y, por fórmula, `latex`
  y el opcional `grafico`; el campo extra `file` de la spec de circuitos es
  ignorado).
- **Opción B:** apuntar `GAPS` a `roadmap/` y cambiar el glob de `gap-*.json`
  a `spec-*.json` (línea 245).

Pasos (todo en rama/worktree, revisión del operador, PR — NUNCA push directo a
`main`, porque son fórmulas de referencia sin imagen-fuente):

1. **Worktree/rama limpia** desde `origin/main`. Ajustar `ROOT` (línea 11) al
   nuevo worktree (el actual apunta a `worktrees/formulae-content-20260712`,
   que puede ya no existir). El generador re-parchea los archivos compartidos
   "desde la base limpia de git", así que DEBE correrse sobre un checkout
   limpio; si se corre dos veces sin `git restore`, los appends (rutas,
   favoritos, arb) se duplican.
2. **Añadir a `NEW_SECTION_TITLES`** los 3 slugs con ES/EN correctos, p. ej.:
   - `quimica_general`: ('Química general', 'General Chemistry')
   - `estatica_y_resistencia_de_materiales`: ('Estática y resistencia de
     materiales', 'Statics and Strength of Materials')
   - `circuitos_electricos`: ('Análisis de circuitos', 'Circuit Analysis')
     (título deliberadamente distinto de la física "Circuitos eléctricos").
3. **Correr `python3 generador.py`.** Emite: pantallas Dart en
   `secciones_app/<sec>/`, barrels `export_<sec>.dart`, submenús
   `menus/menu_<sec>.dart`, y parchea `contantes_rutas.dart`,
   `constantes_favoritos.dart`, `routes.dart`, `Favorites/widget_mapper.dart`,
   `busqueda/search_delegate.dart`, `menus/export_menus.dart`,
   `menus/principal_menu.dart`, `l10n/app_es.arb`, `l10n/app_en.arb`. Escribe
   además `scratchpad/graphics_manifest.json` (ver §3).
4. **Verificar** (ver §4), commit, abrir PR para revisión del operador.

Idempotencia: el generador usa `uniq()` contra clases/rutas/widgets/l10n
existentes, así que es seguro frente a colisiones con el lote ya mergeado; y
usa `patch()` con aserción de "el ancla aparece exactamente 1 vez" — si algún
ancla compartida ya no es única (por cambios previos), aborta con
`ANCHOR ERROR` en vez de corromper. Eso es una salvaguarda, no un fallo.

---

## 3. Estado de gráficos

**Gráficos con candidato open-source cableados a estas fórmulas: 0.**

Ninguna de las 235 fórmulas trae el campo opcional `grafico` en las specs. El
generador solo agrega al `graphics_manifest.json` cuando `fm.get('grafico')` es
truthy, así que la corrida producirá un manifiesto de gráficos VACÍO para estos
3 dominios. Los gráficos son un follow-up separado, no bloquean la generación
de las pantallas de fórmulas.

Lo que SÍ está resuelto es el marco de sourcing (`graficos-open-source.md`),
apto para app comercial cerrada:

- **Fuentes aptas (uso comercial):** Wikimedia Commons (CC0 / CC BY / CC BY-SA,
  verificar archivo por archivo), tikz.net y texample.net (CC BY-SA 4.0),
  Matplotlib (BSD/PSF, salida propia sin atribución), TikZ propio compilado
  (salida = copyright propio). **Vetado:** GeoGebra (CC BY-NC-SA en UI/exports →
  no comercial sin licencia pagada). Render: `flutter_svg` (MIT), un SVG neutro
  por diagrama recoloreado por tema, no PNG duplicado.
- **Diagramas con candidato identificado (relevantes a estos 3 dominios):**
  - Estática: diagrama de cuerpo libre (`File:Free body diagram.svg`,
    `Category:Free body diagrams`), círculo de Mohr (TikZ), centroides/inercia
    de figuras (TikZ/Matplotlib).
  - Circuitos: diagramas de circuito (`File:Circuit diagram.svg`,
    `Category:SVG electrical circuits`, o `circuitikz` propio), triángulo de
    potencia, curvas de transitorios RC/RL y resonancia (Matplotlib).
  - Química: curvas (titulación, distribución) vía Matplotlib.

Estimación de candidatos "con fuente open-source viable" para el catálogo de
estos dominios: cobertura ALTA vía Wikimedia + TikZ/circuitikz + Matplotlib
propio; pero **aún 0 seleccionados/descargados/atribuidos**. Próximo paso:
decidir qué fórmulas ameritan gráfico, añadirles `grafico`/`descripcion_grafico`
en las specs, y poblar `CREDITS.md` (plantilla ya lista en el doc de sourcing)
por archivo desde el primer asset.

---

## 4. Riesgos y verificaciones

### Antes de generar
- **`ROOT` obsoleto** (worktree `formulae-content-20260712`): reapuntar a un
  worktree fresco o falla al leer/escribir.
- **`NEW_SECTION_TITLES` incompleto:** sin las 3 entradas, títulos de sección
  quedan feos y no-bilingües. Bloqueante de calidad.
- **Correr sobre base git limpia:** re-parcheo de archivos compartidos asume
  base limpia; segunda corrida sin `git restore` duplica appends.

### Después de generar (verificaciones obligatorias)
- **`flutter analyze --fatal-infos` en 0:** las 37 pantallas deben compilar. La
  plantilla usa imports `package:formulae/...` (evita el bug conocido de
  imports relativos que sobrepasan `lib/`) y envuelve las fórmulas en
  `const ZoomPersonalizado(child: Column(...))`, así que `Latex(formulaText:
  <raw string>)` debe ser const-construible en contexto const (patrón idéntico
  al lote de 752 ya mergeado). Confirmar que no aparezcan infos de const/import.
- **`flutter gen-l10n` + paridad ARB:** el generador escribe ES y EN a la vez
  (paridad por construcción), pero las nuevas claves van sin metadata `@key`.
  Regenerar l10n y confirmar 0 claves faltantes en cualquiera de los dos.
- **Tests "de forma" (routes / widget_mapper / favoritos / búsqueda):** cualquier
  test que asevere CONTEOS exactos de rutas, entradas de `widget_mapper`,
  claves l10n o resultados de búsqueda necesitará actualizar sus números al
  sumar 37 pantallas + rutas + widgets + entradas de búsqueda + 3 submenús + 3
  botones de menú principal. Verificar además el invariante
  ruta→widget→favorito→búsqueda de punta a punta (no confiar en harnesses que
  se traguen crashes — antecedente de ~90 testWidgets fake-green en la flota).
- **Revisión humana de las 235 fórmulas de referencia ANTES de prod:** firma de
  un revisor calificado (símbolos, unidades, condiciones y las correcciones
  auto-señaladas). Este es el gate duro; el PR queda para revisión del
  operador, sin merge a `main`/deploy hasta esa firma.

### Riesgos de contenido específicos
- **circuitos vs física:** doble entrada de "circuitos" en el menú si no se
  renombra; decidir taxonomía antes de merge.
- **quimica / constantes:** no duplicar valores de N_A y R (viven en la sección
  de constantes); referenciar por símbolo.
- **circuitos, valor medio de senoide rectificada:** verificar la corrección ya
  anotada en el spec (2·Vm/π onda completa).
