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

## 2. Tarea A: generar las 229 imagenes rotas (176 ES + 53 EN)

Las imagenes de diagramas vivian en `capdesis.com/sistema/formulae/Imagenes/` que
ahora da 404, asi que TODAS estan rotas. Son **229 en total** (verificado contando
`pro/lib/constantes/urls_imagenes.dart`):

- **176 en espanol** bajo `https://formulaeapps.com/imagenes/...` (124 de
  electricidad y magnetismo, 18 geometria, 19 FAQ, 15 discretas/raiz/trig).
- **53 en ingles** bajo `https://formulaeapps.com/imagenes_ingles/...` (mismas
  subcarpetas: electricidad_y_magnetismo, geometria, matematicas_discretas,
  preguntas_frecuentes, mas algunos mockups de FAQ en la raiz). Cada una es el
  MISMO diagrama que su equivalente en espanol, pero con etiquetas en ingles.

Hoy la app muestra un placeholder (no crashea). La lista autoritativa de las 229
URLs es `pro/lib/constantes/urls_imagenes.dart` (230 `const String`: 229 remotas +
1 asset local `assets/images/gif/carga.gif` que NO se regenera).

- **QUE generar**:
  - Para las 176 ES: el CONTENIDO exacto de cada diagrama esta en
    `pro/docs/CATALOGO_PROMPTS_IMAGENES.md`, con un prompt por imagen y su ruta
    destino. Usa ESE catalogo como fuente de la descripcion tecnica.
  - Para las 53 EN: toma el prompt del equivalente en espanol (mismo nombre de
    archivo bajo `imagenes/`), **traduce las etiquetas a ingles** y deja el resto
    identico. Guarda bajo `imagenes_ingles/<misma ruta>`.
- **ESTILO/FORMATO (ver el bloque "Estilo de fondo" del catalogo, es la autoridad)**:
  - Formato **PNG** (salvo las 2 variantes `.jpg` de Preguntas frecuentes).
  - Fondo **por defecto: RELLENO SOLIDO navy `#27283D`** (exactamente el fondo de
    la app, constante `kColorFondo`). Es lo recomendado y robusto: los generadores
    suelen hornear la rejilla de ajedrez de "transparente" como pixeles reales o
    dar alfa sucio; un relleno solido del mismo color se ve identico a transparente
    sobre la app sin ese riesgo. Transparente REAL solo si tu herramienta da alfa
    limpio sin rejilla. NUNCA fondo blanco. Las 2 `.jpg` van con navy solido.
  - Trazos y etiquetas en **colores claros** que lean sobre navy: lineas
    off-white `#E8E8F0`; acentos con moderacion: dorado `#F3A73D`, teal
    `#3AC0C9`, rojo `#FF6B6B` (carga positiva/sentido), azul `#6BA9FF`
    (carga negativa/campo). Etiquetas en **espanol** (set ES) o **ingles**
    (set EN), sans-serif legible.
  - Resolucion **1024x768** (4:3) o **1024x1024** cuadrado donde la figura lo
    pida; exportable al doble para retina. Diagrama tecnico 2D plano, sin sombras
    3D ni fotorrealismo.
  - **CRITICO**: correccion tecnica (topologia de circuito, sentido de campo,
    geometria exactos). No inventes ni pongas decoracion que confunda.
  - Los assets de MARCA (Google Play badge, logos CAPDESIS) e iconos de UI
    marcados como placeholder en el catalogo: **NO los generes con IA**; usa el
    oficial o un icono del sistema.
- **DONDE ponerlas** (hosting Hostinger, NO R2):
  - ES: `landing/public/imagenes/<ruta>` -> se sirve en
    `https://formulaeapps.com/imagenes/<ruta>`.
  - EN: `landing/public/imagenes_ingles/<ruta>` -> se sirve en
    `https://formulaeapps.com/imagenes_ingles/<ruta>`. (Esa carpeta ya existe con
    un README; antes no habia PNGs.)
  - Respeta subcarpetas y el nombre EXACTO que aparece en `urls_imagenes.dart`.
  - La app Pro **ya apunta ahi**; NO cambies codigo de la app para las imagenes,
    solo genera los PNG y colocalos.
  - **Offline**: la app usa `cached_network_image`, asi que al ver una imagen una
    vez se cachea en el dispositivo y queda disponible sin internet. Ya esta.
  - **Nota de render**: en movil (iOS/Android) la imagen se dibuja con
    `BoxFit.contain` directo sobre navy `#27283D`; en **web** hoy NO se muestra
    (la widget retorna `SizedBox.shrink()` bajo `kIsWeb`). Por eso el fondo navy
    solido es lo correcto.
- **Verificacion**: tras subir a Hostinger, confirma que cada URL de
  `urls_imagenes.dart` (imagenes/ e imagenes_ingles/) responde 200, y que se ven
  bien sobre el fondo navy de la app.

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

- La lista EXACTA de las 229 URLs de imagen: `pro/lib/constantes/urls_imagenes.dart`
  (176 en `formulaeapps.com/imagenes/` + 53 en `formulaeapps.com/imagenes_ingles/`).
  No inventes rutas; usa exactamente esas.
- Los prompts de las 176 ES: `pro/docs/CATALOGO_PROMPTS_IMAGENES.md`. Las 53 EN
  reusan el prompt del equivalente ES con etiquetas en ingles.
- Backlog y estado general del proyecto: `pro/docs/BACKLOG_REDISENO_PRO.md`.
- El deploy web esta en solo-build por decision del gobierno del repo; publicar es
  promocion manual. No re-habilites auto-deploy sin acuerdo.
- No uses R2 para las imagenes; van a Hostinger via `landing/public/imagenes/` y
  `landing/public/imagenes_ingles/`.

## 6. Que YA quedo hecho (no rehacer)

Todo lo siguiente ya esta en `main` (HEAD `103f253`):

- 121 pantallas / 752 formulas nuevas (140 erratas corregidas) en 14 secciones.
- PDF con LaTeX renderizado como imagen + preview + nombre por pantalla + tamano S/M/L.
- Rediseno responsivo (NavigationRail + sidebar en desktop, bottom nav, grids 2/3 col).
- Branding limpio (marca de producto, sin caja blanca CAPDESIS) + hover en drawer.
- Formato de formulas (no se cortan, con indicador de scroll).
- Favoritos con carpetas (crear, mover, exportar a PDF) + UX de mover-a-carpeta.
- Paleta con acentos (dorado/teal) y contraste WCAG AA en iconos/textos.
- Placeholder para imagenes rotas (sin spinner infinito) + URLs re-hosteadas a Hostinger.
- Landing: seccion Materias ES/EN, email visible, copyright dinamico.
- Docs: catalogo de imagenes, backlog, ecosistema Super Plus, modularizacion/auth, roadmap.

Falta (tu trabajo + backlog): generar y colocar las 229 imagenes, enriquecer las
pantallas delgadas, y los items del backlog (calculadoras interactivas, navegacion
mas plana, Pro-vs-Free, 85% coverage). Ver seccion 7 para el detalle.

## 7. Contexto completo de la campana (para no repetir trabajo)

Origen: 68 fotos de DOS folletos de bolsillo (matematicas + fisica) se
transcribieron a LaTeX (con correccion adversarial de OCR), se analizaron brechas
vs el contenido existente, y un generador determinista en Python emitio las
pantallas. Todo se entrego en PRs squash-merged a `main`, autor `chochy2001`, sin
referencias a IA. Cronologia verificada por git (PR / SHA / que cambio):

- **#42** `cdd9906` fix CI rojo en main (gate JWT, community analyze, parity).
- **#43** `ad9e863` 121 pantallas de formulas nuevas en 14 secciones.
- **#44** `d2fdaab` landing anuncia la cobertura ampliada de Pro.
- **#45** `f33f154` PDF: renderiza LaTeX como imagen en el export de favoritos.
- **#46** `52279de` bff: gitleaks shadow tests se saltan si falta el binario.
- **#47** `279845e` correccion de contenido auditado + fallback de PDF.
- **#50** `86b21a3` docs: ecosistema, modularizacion/auth, formulas nuevas, roadmap P0.
- **#51** `618fc2b` landing: email real, copyright dinamico, fixes de auditoria.
- **#52** `6c47689` PDF: nombre por pantalla + visor en web.
- **#53** `bf66954` layout responsivo adaptativo con shell de navegacion persistente.
- **#54/#55/#57** deploy web: se ajusto varias veces; termino en build-only con gates
  (gobierno del repo lo revirtio dos veces; publicar es MANUAL, no auto).
- **#56** `b567cd5` hover en items del drawer.
- **#59** `8f555d1` branding unificado, quita el logo con caja blanca.
- **#60** `a380f72` backlog/roadmap de rediseno (fuente de verdad).
- **#61** `b4f98d1` placeholder para imagenes rotas (no mas spinner infinito).
- **#62** `fc7e6f7` preview de PDF inline, tamano de formula, UX de carpetas, contraste.
- **#63** `7918a80` formulas anchas: caben o se desvanecen, nunca se cortan en silencio.
- **#64** `7adc42d` re-hosting de imagenes a Hostinger (host capdesis muerto).
- **#65** `99ef03b` catalogo de prompts de imagenes.
- **#66** `0177736` paleta de acentos dorado/teal con contraste accesible.
- **#67** `103f253` este handoff + enriquecimiento de contenido delgado.

Pendiente (backlog, ademas de tus Tareas A y B), en orden util:

1. **To-do list**: indicador de swipe lateral + arreglar texto que se corta.
2. **Navegacion mas plana** (menos secciones dentro de secciones).
3. **Pro-vs-Free** explicito en app y landing (mas contenido, sin ads, PDF, carpetas, calculadoras).
4. **Calculadoras interactivas input->output** (conversiones, area, volumen): el
   diferenciador #1 vs la competencia. Feature multi-fase.
5. **35 diagramas open-source** adicionales (ver `GRAFICOS_PENDIENTES.md`): 6
   algebra, 5 algebra lineal, 3 calculo integral, 11 mecanica, 8 optica, 2 trig,
   con verificacion de licencia y creditos en la app.
6. **234 formulas de referencia** verificadas (quimica / estatica-resistencia /
   circuitos) a un PR de REVISION con visto bueno humano, NO directo a main.
7. **Dominios de contenido faltantes** (ver `PLAN_ACTUALIZACION_FUTURA.md`):
   estatica y resistencia de materiales, quimica y estequiometria, circuitos DC/AC,
   fluidos, tablas de Laplace, ondas/acustica, metodos numericos, electronica basica.
8. **85% coverage honesto** en Pro (baseline ~58 tests; multi-semana).
9. **Super Plus**: login/identidad compartida (SSO), servicio central de
   entitlements, gating por app, billing de suscripcion. Proyecto multi-app grande.
   Diseno en `ECOSISTEMA_CAPDESIS_SUPERPLUS.md` + `MODULARIZACION_Y_AUTH_FORMULAE.md`.
10. **Modularizacion Free/Pro**: extraer paquetes compartidos (motor de contenido,
    export LaTeX/PDF, l10n base ES/EN, componentes UI) versionados por estandar de flota.
11. **DEPLOY**: prod (`app.formulaeapps.com`) aun sirve el build de MAYO; publicar
    esta bloqueado por secretos del operador (`FTP_PASSWORD`, `FORMULAE_JWT_SHARED_SECRET`
    = el real del BFF en VPS ancare) + promocion manual revisada (FTPS + smoke +
    rollback). NO re-habilites auto-deploy sin acuerdo. La landing tambien es lftp manual.
12. **Tiendas iOS/Android**: flujo aparte del web.
