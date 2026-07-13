# Handoff para Codex: imagenes + contenido de Formulae Pro

Documento self-contained para que Codex (que SI puede generar imagenes y
programar) continue el trabajo sin alucinar. Leelo completo antes de empezar.
Junto con `pro/docs/CATALOGO_PROMPTS_IMAGENES.md` es todo el contexto que
necesitas.

## 1. Contexto del workspace y el repo (NO alucinar rutas)

- El workspace `/Users/jorge/Documents/Apps` es una carpeta PLANA que contiene
  repos independientes. NUNCA hagas `git init` ni `git submodule` en `/Apps`.
  Corre git DENTRO del repo especifico.
- El repo de esto es **`CAPDESIS/formulaeapps`** (privado), clonado en
  `/Users/jorge/Documents/Apps/Formulae/monorepo`. Es un monorepo:
  - `pro/` = app Flutter **Formulae Pro** (la que se actualiza; es dark-only).
  - `landing/` = sitio Astro de `formulaeapps.com` (deploy manual lftp a Hostinger).
  - `community/` = app Free. **NO la toques.**
  - `bff/` = backend Bun/Hono.
- Trabaja en un git worktree/rama propia; abre PR a `main`. Hay OTRAS sesiones de
  IA trabajando en paralelo en este repo (design-system, deploy). **No destruyas
  su trabajo**: trabaja solo en tu worktree, no toques ramas ajenas, y todo
  converge en `main` via PRs (que detectan conflictos).

## 2. Tarea A: generar las 176 imagenes rotas

Las imagenes de diagramas vivian en `capdesis.com/sistema/formulae/Imagenes/` que
ahora da 404 (176 imagenes muertas: 124 de electricidad y magnetismo, 18
geometria, 19 FAQ, 15 discretas/raiz/trig). Hoy la app muestra un placeholder en
su lugar (no crashea).

- **QUE generar**: el CONTENIDO exacto de cada imagen (que muestra el diagrama)
  esta en `pro/docs/CATALOGO_PROMPTS_IMAGENES.md`, con un prompt por imagen y su
  ruta destino. Usa ESE catalogo como fuente de la descripcion tecnica.
- **ESTILO/FORMATO (ya alineado con el bloque "Estilo de fondo" del catalogo)**:
  - Formato **PNG** (salvo las 2 variantes `.jpg` de Preguntas frecuentes).
  - Fondo: **transparente**, o si tu generador no logra transparencia limpia,
    fondo **solido navy `#27283D`** (el fondo de la app), para que se integre. La
    app es dark-only, NO uses fondo blanco. Las 2 `.jpg` (que no soportan alfa)
    van con fondo solido navy `#27283D`.
  - Trazos y etiquetas en **colores claros** que lean sobre navy: lineas
    off-white `#E8E8F0`; acentos con moderacion: dorado `#F3A73D`, teal
    `#3AC0C9`, rojo `#FF6B6B` (carga positiva/sentido), azul `#6BA9FF`
    (carga negativa/campo). Etiquetas en **espanol**, sans-serif legible.
  - Resolucion **1200x900** (4:3) o **1024x1024** cuadrado donde la figura lo
    pida. Diagrama tecnico 2D plano, sin sombras 3D ni fotorrealismo.
  - **CRITICO**: correccion tecnica (topologia de circuito, sentido de campo,
    geometria exactos). No inventes ni pongas decoracion que confunda.
  - Los assets de MARCA (Google Play badge, logos CAPDESIS) e iconos de UI
    marcados como placeholder en el catalogo: **NO los generes con IA**; usa el
    oficial o un icono del sistema.
- **DONDE ponerlas** (hosting Hostinger, NO R2):
  - Guarda cada PNG en `landing/public/imagenes/<ruta>` (respeta subcarpetas y
    nombre exacto de la columna "target" del catalogo).
  - Al desplegar la landing, esa carpeta se sirve en
    `https://formulaeapps.com/imagenes/<ruta>`.
  - La app Pro **ya apunta ahi**: las URLs estan en
    `pro/lib/constantes/urls_imagenes.dart` (ya reescritas a
    `https://formulaeapps.com/imagenes/...`). NO necesitas cambiar el codigo de
    la app para las imagenes; solo generar los PNG y colocarlos.
  - **Offline**: la app usa `cached_network_image`, asi que al ver una imagen una
    vez se cachea en el dispositivo y queda disponible sin internet. Ya esta.
- **Verificacion**: tras subir a Hostinger, confirma que
  `https://formulaeapps.com/imagenes/<ruta>` responde 200 para cada imagen, y que
  se ven bien sobre el fondo navy de la app.

## 3. Tarea B: enriquecer secciones con poco contenido

Hay pantallas con muy poco (0-1 formula, sin imagen). ANTES de tocarlas, verifica
si ya usan un widget alterno (tabla, `TextoEcuaciones`, etc.) porque esas NO
estan vacias. Candidatas reales a revisar (verificar una por una):

- `pro/lib/secciones_app/calculo_multivariable/` : derivadas_parciales,
  integrales_de_linea, teorema_integrales, longitud_de_arco,
  integral_en_coordenadas_cilindricas, area_de_una_superficie_de_revolucion,
  teorema_de_fubini, diferencial_total.
- `pro/lib/secciones_app/ecuaciones_diferenciales/` : ecuacion_diferencial_homogenea,
  ecuacion_diferencial_separable, ecuacion_diferencial_de_rectas_paralelas.
- `pro/lib/secciones_app/series_de_fourier/transformadas/` : transformada_de_laplace,
  transformada_de_fourier, transformada_seno_y_coseno_de_fourier (probablemente
  deberian ser TABLAS de transformadas; enriquecer con la tabla completa).
- `pro/lib/secciones_app/probabilidad_y_estadistica/combinaciones_y_permutaciones.dart`.
- `pro/lib/secciones_app/constantes_matematicas/constantes_fisicas_universales.dart`.

Como enriquecer (patron de la app): agregar las formulas faltantes como
`Latex(formulaText: r"...")`, notas con `TextoEcuaciones(...)`, y el diagrama si
aplica. Usa fuentes de referencia correctas; no inventes formulas. Mantiene el
patron de pantalla existente (ver cualquier pantalla con contenido como
`secciones_app/trigonometria/teorema_de_pitagoras.dart`).

## 4. Reglas de trabajo (obligatorias)

- Commits en **ingles**, autor **chochy2001**
  (`git -c user.name=chochy2001 -c user.email=54371626+chochy2001@users.noreply.github.com commit`).
- **Sin ninguna referencia a IA** en commits/codigo/PRs. **Sin em-dashes ni
  en-dashes** en ningun lado (usa comas o guiones normales).
- Usa **bun**, nunca npm/npx, para la landing.
- Verifica SIEMPRE antes de PR (en `pro/`):
  - `cd packages/formulaeapps_bff_client && flutter pub get && cd ../..` luego `flutter pub get`
  - `flutter analyze --no-pub --fatal-infos --fatal-warnings` (debe ser "No issues found")
  - `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --dart-define=JWT_SHARED_SECRET=test-shared-secret --dart-define=FORMULAE_BUILD_NONCE=ci --dart-define=FORMULAE_APP_VERSION=0.0.0`
  - `flutter build web -t lib/main_pro.dart --dart-define=FLAVOR=pro --dart-define=JWT_SHARED_SECRET=0000000000000000000000000000000000000000000000000000000000000000 --dart-define=FORMULAE_BUILD_NONCE=v --dart-define=FORMULAE_APP_VERSION=0`
  - Si tocas la landing: `cd landing && bun install --frozen-lockfile && bun run test && bun run build`.
- Si agregas rutas de contenido, hay tests de "forma" que aseveran conteos
  exactos de rutas/widget_mapper (`pro/test/routes_widget_mapper_test.dart`):
  actualizalos a los nuevos totales.
- Todo termina en `main` via PR. No pushes directo a main.

## 5. Anti-alucinacion (checklist)

- La lista EXACTA de las 176 imagenes y sus prompts: `pro/docs/CATALOGO_PROMPTS_IMAGENES.md`.
- Las URLs que consume la app: `pro/lib/constantes/urls_imagenes.dart` (ya apuntan
  a `formulaeapps.com/imagenes/`). No inventes rutas nuevas; usa las del catalogo.
- Backlog y estado general del proyecto: `pro/docs/BACKLOG_REDISENO_PRO.md`.
- El deploy web esta en solo-build por decision del gobierno del repo; publicar es
  promocion manual. No re-habilites auto-deploy sin acuerdo.
- No uses R2 para las imagenes; van a Hostinger via `landing/public/imagenes/`.

## 6. Que YA quedo hecho (no rehacer)

- 121 pantallas / 752 formulas nuevas; PDF con LaTeX renderizado + preview +
  tamano S/M/L; rediseno responsivo; branding limpio; hover; formato de formulas
  (no se cortan); favoritos con carpetas; paleta con acentos y contraste WCAG AA;
  placeholder para imagenes rotas; URLs de imagenes re-hosteadas a Hostinger;
  catalogo de prompts de las 176 imagenes. Todo en `main`.
- Falta (tu trabajo + backlog): generar y colocar las 176 imagenes, enriquecer las
  pantallas delgadas, y los items del backlog (calculadoras interactivas,
  navegacion mas plana, Pro-vs-Free, 85% coverage).
