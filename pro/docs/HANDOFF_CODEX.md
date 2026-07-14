# Handoff para Codex: imagenes + contenido de Formulae

Documento self-contained para que Codex (que SI puede generar imagenes y
programar) continue el trabajo sin alucinar. Leelo completo antes de empezar.
Junto con `pro/docs/CATALOGO_PROMPTS_IMAGENES.md` es todo el contexto que
necesitas.

## Actualización verificada, 2026-07-13

Esta sección prevalece sobre los pendientes históricos de este archivo.

- Las 176 imágenes canónicas se generaron y auditaron localmente. Pro y
  Community comparten exactamente las mismas rutas y no hay assets por idioma.
  `cd landing && bun run check:formulae-images` pasa.
- La promoción a `formulaeapps.com` sigue pendiente: el smoke
  `bun run check:formulae-images:remote` falla 176 de 176 por HTTP 404. No
  volver a generar assets ni inventar rutas; promover `landing/public/imagenes/`
  y las reglas de compatibilidad mediante el proceso autorizado, después repetir
  el smoke remoto.
- Community recibió fallback localizado para todas sus cargas remotas de
  imagen, pruebas responsive estrictas y manejo seguro del PDF remoto. El host
  de PDFs heredados continúa indisponible: 257 IDs activos resuelven 438 URLs
  únicas, sin un PDF recuperable en la auditoría. Se necesita restaurar
  contenido fuente o migrar Community al generador local de Pro.
- Pro genera PDFs localmente, incluidos Favoritos y Tareas. En Linux guarda la
  exportación en Descargas o Documentos sin usar el share sheet no implementado.
- El detalle, los comandos y los bloqueos están en
  `../../docs/AUDITORIA_FUNCIONAL_2026-07-13.md`. No declarar una liberación lista
  sin repetir sus gates sobre el SHA exacto de promoción.

## 1. Contexto del workspace y el repo (NO alucinar rutas)

- El workspace `/Users/jorge/Documents/Apps` es una carpeta PLANA que contiene
  repos independientes. NUNCA hagas `git init` ni `git submodule` en `/Apps`.
  Corre git DENTRO del repo especifico.
- El repo de esto es **`CAPDESIS/formulaeapps`** (privado). Trabaja desde el
  checkout o worktree activo, no asumas una ruta histórica. Es un monorepo:
  - `pro/` = app Flutter **Formulae Pro** (dark-only).
  - `landing/` = sitio Astro de `formulaeapps.com` (deploy manual lftp a Hostinger).
  - `community/` = app Flutter **Formulae Community** (Free). Comparte los
    diagramas canónicos con Pro: sus rutas de imagen deben conservar el mismo
    contrato sin idioma, aunque no se toque contenido ajeno a ese contrato.
  - `bff/` = backend Bun/Hono.
- Trabaja en un git worktree/rama propia; abre PR a `main`. Hay OTRAS sesiones de
  IA trabajando en paralelo en este repo (design-system, deploy). **No destruyas
  su trabajo**: trabaja solo en tu worktree, no toques ramas ajenas, y todo
  converge en `main` via PRs (que detectan conflictos).

## 2. Tarea A: conjunto visual canónico sin idioma, completada localmente

Las imágenes históricas estaban bajo `capdesis.com`, host que hoy devuelve 404.
Formulae Pro y Formulae Community tienen ahora **176 rutas canónicas** bajo
`https://formulaeapps.com/imagenes/...`; la lista autoritativa está en
`pro/lib/constantes/urls_imagenes.dart` y debe coincidir con el registro de
Community. El GIF local `assets/images/gif/carga.gif` no se regenera.

- **Un asset por concepto y por ruta:** todos los locales consumen la misma URL.
  No crear, publicar ni volver a referenciar `imagenes_ingles/`.
- **Contenido permitido dentro del bitmap:** notación matemática/científica,
  fórmulas, variables, unidades, geometría, polaridades, flechas y valores
  lógicos `0`/`1`. Quedan prohibidos títulos, palabras, frases, leyendas,
  capturas de UI/OS y valores `V`/`F` o `T`/`F`.
- **Excepción de marca:** los logotipos oficiales Formulae y CAPDESIS son
  identidad fija, no prosa localizada; se conservan sólo en los assets cuya
  función es mostrar la marca.
- **Texto y accesibilidad:** los nombres, explicaciones y pasos viven en los
  widgets y archivos ARB localizados de ambas apps Flutter. Revisa la pantalla
  consumidora antes de regenerar un diagrama para no perder contexto pedagógico.
- **FAQ:** sustituir capturas estáticas por pictogramas de iconos sin texto o por
  UI Flutter real; una captura con cadenas incrustadas no es internacionalizable.
- **Fondo y formato:** PNG, salvo las dos rutas JPG históricas; fondo opaco navy
  `#27283D`, 1024x768 o cuadrado cuando corresponda. No transparencia con
  rejilla ni fondo blanco. Mantener física, topología, sentido de campo y
  geometría técnicamente correctos.
- **Reconstrucción local:** `cd landing && bun run recover:formulae-images` toma
  las fuentes históricas, las normaliza y aplica la neutralización determinista.
  Esta etapa usa Tesseract para detectar prosa y reemplaza los assets FAQ por
  pictogramas universales.
- **Verificación:** `bun run check:formulae-images` exige las 176 rutas,
  extensiones, decodificación, dimensiones y esquinas navy. Tras una promoción
  manual, `bun run check:formulae-images:remote` comprueba respuestas HTTP y
  MIME. Inspecciona muestras en móvil/web y en más de un locale antes de darlo
  por listo.
- **Compatibilidad:** los paths históricos `imagenes_ingles/...` redirigen
  temporalmente a su equivalente canónico (incluido `clic_card_buy.png` hacia
  `carrito_comprar.png`) para no romper versiones antiguas de la app. No son
  variantes de contenido.

## 3. Tarea B: enriquecer secciones con poco contenido

La lista historica de candidatas no debe tratarse como una lista de pantallas
vacias. La revision de codigo encontro contenido existente en todas: entre 2 y
10 `Latex` en las candidatas de calculo multivariable y ecuaciones diferenciales,
2 y 4 en las pantallas de Fourier, 3 en combinaciones/permutaciones (incluye una
calculadora), y 6 en constantes fisicas. La pantalla que si tenia una sola
formula, `transformada_de_laplace.dart`, ya incluye definicion y cinco formulas
operacionales.

Antes de enriquecer otra pantalla, revisa el widget completo y su flujo real:
una tabla, calculadora, `TextoEcuaciones`, PDF o diagrama puede aportar contenido
aunque el conteo de formulas sea bajo. Solo agrega conocimiento matematico con
fuente verificada, siguiendo el patron `Latex(formulaText: r"...")` y
`TextoEcuaciones(...)`; evita duplicar contenido o afirmar que una pantalla esta
vacia solo por una busqueda textual.

## 4. Reglas de trabajo (obligatorias)

- Commits en **ingles**, autor **chochy2001**
  (`git -c user.name=chochy2001 -c user.email=54371626+chochy2001@users.noreply.github.com commit`).
- **Sin ninguna referencia a IA** en commits/codigo/PRs. **Sin em-dashes ni
  en-dashes** en ningun lado (usa comas o guiones normales).
- Usa **bun**, nunca npm/npx, para la landing.
- Verifica SIEMPRE antes de PR en cada app Flutter afectada:
  - `cd packages/formulaeapps_bff_client && flutter pub get && cd ../..` luego `flutter pub get`
  - `flutter analyze --no-pub --fatal-infos --fatal-warnings` (debe ser "No issues found")
  - `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --dart-define=JWT_SHARED_SECRET=test-shared-secret --dart-define=FORMULAE_BUILD_NONCE=ci --dart-define=FORMULAE_APP_VERSION=0.0.0`
  - `flutter build web -t lib/main_pro.dart --dart-define=FLAVOR=pro --dart-define=JWT_SHARED_SECRET=0000000000000000000000000000000000000000000000000000000000000000 --dart-define=FORMULAE_BUILD_NONCE=v --dart-define=FORMULAE_APP_VERSION=0`
  - En `community/`, la CI usa `flutter analyze --no-pub --no-fatal-infos --fatal-warnings` mientras exista el baseline documentado de infos, más las pruebas focales estrictas de imagen, PDF y responsive.
  - Si tocas la landing: `cd landing && bun install --frozen-lockfile && bun run lint && bun run test && bun run build && bun run check:formulae-images`.
- Si agregas rutas de contenido, hay tests de "forma" que aseveran conteos
  exactos de rutas/widget_mapper (`pro/test/routes_widget_mapper_test.dart`):
  actualizalos a los nuevos totales.
- Todo termina en `main` via PR. No pushes directo a main.

## 5. Checklist de exactitud

- La lista exacta de las 176 URLs canónicas está en
  `pro/lib/constantes/urls_imagenes.dart`; el registro de Community debe
  resolver las mismas rutas. No inventes rutas ni agregues ramas por locale.
- `pro/docs/CATALOGO_PROMPTS_IMAGENES.md` describe la intención pedagógica. Su
  regla de internacionalización prevalece sobre el texto histórico de cada
  prompt: ninguna palabra natural puede entrar en un bitmap.
- Revisa la pantalla Flutter que consume cada imagen, no sólo el catálogo. La
  explicación debe vivir en ARB/widgets localizados y el diagrama conservar solo
  notación universal técnicamente correcta.
- Backlog y estado general del proyecto: `pro/docs/BACKLOG_REDISENO_PRO.md`.
- El deploy web está en solo-build por decisión del gobierno del repo; publicar
  es promoción manual. No re-habilites auto-deploy sin acuerdo.
- No uses R2 para las imágenes; van a Hostinger vía `landing/public/imagenes/`.
- Los paths históricos `imagenes_ingles/...` son aliases temporales de
  compatibilidad, no un conjunto de assets que se deba regenerar.

## 6. Que YA quedo hecho (no rehacer)

Los siguientes elementos quedaron integrados historicamente antes de esta tarea.
Confirma el SHA actual con `git rev-parse origin/main`, no asumas que sigue siendo
`103f253`:

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

Las 176 imágenes ya no son un pendiente local. El pendiente externo es su
promoción y smoke remoto. El backlog restante incluye calculadoras interactivas,
navegación más plana, Pro-vs-Free y cobertura honesta; antes de tomar un item,
revisar el informe de auditoría actualizado y el estado Git del checkout.

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
