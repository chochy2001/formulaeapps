# Backlog y roadmap de rediseno de Formulae Pro

Fuente de verdad del esfuerzo de mejora de Formulae Pro (2026-07-12/13). Escrito
para que ninguna sesion pierda el contexto al compactar. Todo aplica SOLO a Pro
(Community/Free no se toca ahora). Reglas: commits en ingles autor chochy2001, sin
referencias a IA, sin em-dashes; todo termina en main; verificar en arbol mergeado
antes de merge; paralelo solo en archivos disjuntos, secuencial en archivos
compartidos.

## 1. Ya hecho y en main

- 752 formulas / 121 pantallas nuevas (2 folletos foto: mate + fisica), 140 erratas
  corregidas (#43). Lista: `docs/FORMULAS_NUEVAS_2026-07-12.md`.
- PDF: render de LaTeX como imagen (antes salia crudo) (#45).
- PDF: nombre del archivo por pantalla + visor web via iframe blob (#52).
- CI rojo de main reparado (#42) + robustez test gitleaks (#46).
- Landing: seccion Materias ES/EN (#44); email visible + copyright dinamico +
  auditoria pagina por pagina (#51).
- Docs: ecosistema Super Plus, modularizacion/auth, roadmap 234 formulas
  verificadas de referencia (quimica/estatica/circuitos, requieren visto bueno
  humano antes de prod) (#50). Ver `docs/roadmap/`.
- Rediseno responsivo: shell adaptativo con NavigationRail + sidebar persistentes
  en desktop, bottom nav en TODAS las pantallas, grids 2/3 col, back solo si
  canPop (#53).
- Hover en items del drawer (#56).

## 2. En vuelo (pendiente de merge)

- Branding (#59): marca de producto (icono_app_nuevo, chip redondeado sin caja
  blanca) reemplaza el logo CAPDESIS en caja blanca en drawer/menus; "by Capdesis"
  una sola vez en el footer. El icono usa cian (refuerza el acento teal de la
  paleta propuesta).
- Agente PDF/carpetas: preview inline de View PDF + tamano de formula S/M/L +
  verificacion de carpetas de favoritos.

## 3. Estado del DEPLOY (importante, leer)

- Prod (app.formulaeapps.com) sirve el build de MAYO. Lo nuevo NO esta en vivo.
- Se construyo un auto-deploy por FTPS con gates (#57) pero el gobierno del repo lo
  REVIRTIO DOS VECES a solo-build (#55 y `fix(ci): restore build-only`). Senal
  clara: el deploy de Formulae web debe ser PROMOCION MANUAL REVISADA, no
  auto-en-push. No re-habilitar auto-deploy sin acuerdo explicito del gobierno.
- Estado actual: workflow "Build Web Release Candidate" (solo build, dispatch,
  preflight de main exacto, candidatos inmutables 14 dias). Para PUBLICAR falta:
  (a) 2 secretos del operador: `FTP_PASSWORD` y `FORMULAE_JWT_SHARED_SECRET` (VPS
  ancare, debe coincidir con el BFF vivo); (b) un paso de promocion manual
  revisada (FTPS + smoke + rollback). Runbook: `docs/DEPLOY_CI_WEB.md`.
- Landing tambien es deploy manual (lftp Hostinger).

## 4. Backlog priorizado (feedback del operador, todos los turnos)

### P0 - visibilidad, accesibilidad y formato (lo que mas molesta)

1. Formato de formulas: el widget Latex mete cada formula en un
   SingleChildScrollView horizontal SIN affordance, asi que las formulas anchas
   (cadenas de conversion "1 cm3 = ... = ...") se CORTAN sin senal de que hay mas.
   Fix: en movil auto-fit/escala si cabe; si no, degradado/indicador claro a la
   derecha ("desliza, hay mas"). Un widget mejora TODAS las pantallas.
2. Paleta de color: hoy es navy (#27283D fondo, #393A5D tarjetas) + texto blanco,
   con dorado (#F3A73D) casi sin usar -> se ve "morado y blanco". Propuesta:
   mantener navy, PROMOVER el dorado como acento primario (activo, favorito,
   carpeta activa, boton primario), agregar acento TEAL/cian (~#3AC0C9, ya vive en
   el icono de la app) para acciones secundarias (mover a carpeta, enlaces), y
   colores semanticos (rojo destructivo, verde exito). Contraste WCAG AA en todo.
3. Contraste de iconos: el icono "mover a carpeta" es muy oscuro sobre la tarjeta
   navy, no se distingue. Subir contraste (usar el acento teal). Revisar TODOS los
   iconos sobre navy.
4. Feedback de interacciones: con 1 sola carpeta, el boton "mover a carpeta" se ve
   gris y al tocarlo navega como si fuera la formula (sin feedback, parece que
   falla). Fix: mensaje claro ("crea otra carpeta primero para mover aqui"),
   estados disabled explicados. Regla: la gente no sabe usar el software, cada
   interaccion debe explicar que pasa.
5. To-Do list: se ve bien pero (a) no avisa que puedes deslizar (swipe) para ver
   acciones (Recordatorio / borrar / compartir / editar); (b) el texto se corta de
   ambos lados porque no cabe. Fix: affordance de swipe + manejo de texto.
6. Spinners atascados: en algunas secciones un componente que carga por red (chat,
   PDFs/videos/imagenes por URL) se queda con el spinner girando para siempre
   cuando no carga (offline/localhost). Fix: timeout + estado de error claro +
   fallback; ningun componente debe quedar colgado.
7. Preview PDF: el mensaje de error "There was an issue loading the PDF... check
   your internet connection" es ENGANOSO (el PDF es local, no necesita internet).
   Ademas el preview inline a veces no renderiza. (En el agente PDF/carpetas.)

### P1 - features de producto

8. Calculadoras interactivas (input -> output): meter un valor y obtener resultado
   (conversiones, area, volumen). Diferenciador #1 del benchmark (Formulia). Ya hay
   precedente (algunas pantallas de algebra tienen calculadora). Piloto en
   conversiones + geometria, luego expandir. Multi-fase.
9. Imagenes/diagramas en las pantallas (hoy "puro texto"). 35 diagramas ya
   identificados (`docs/GRAFICOS_PENDIENTES.md`) con sourcing open source +
   licencia + atribucion (`docs/roadmap/`, investigacion). Fase dedicada.
10. Tamano de formula configurable en el PDF (S/M/L). (En el agente PDF/carpetas.)
11. Reducir anidamiento: "muchas secciones dentro de otras secciones". Revisar la
    jerarquia de navegacion para que sea mas plana, visible y facil de buscar.

### P1 - diferenciacion Pro vs Free

12. Dejar claro (en la app Y en el landing) POR QUE Pro es mejor que Free, con
    justificacion visible: mas contenido, sin anuncios, PDF export, carpetas,
    calculadoras, IA, etc. Que el usuario sienta "Pro es mucho mejor". Solo mejorar
    Pro; Free no se toca.

### P2 - contenido de referencia (requiere visto bueno humano)

13. Generar las 234 formulas verificadas de quimica / estatica-resistencia de
    materiales / circuitos (`docs/roadmap/spec-*.json`) a una rama/PR de REVISION
    (son de libros, no de las fotos del operador). No push directo a main.

### Grande / multi-sesion

14. 85% de code coverage en Pro. Hoy ~58 tests para cientos de pantallas (bajo).
    Llegar a 85% honesto (sin fake-green) son miles de tests, semanas. Campana
    dedicada por fases (como CapLiving/CapMenu). Primer paso: medir baseline.
15. Deploy a tiendas iOS/Android (flujo distinto al web).
16. Suscripcion unica Super Plus + login/entitlements + modularizacion Free/Pro
    (arquitectura documentada en `docs/ECOSISTEMA_CAPDESIS_SUPERPLUS.md` y
    `docs/MODULARIZACION_Y_AUTH_FORMULAE.md`). Proyecto grande multi-app.
    Cross-promocion: IngenieriaTracker promociona Formulae/cursos; Formulae
    promociona cursos de matematicas (a futuro).

## 5. Principios de diseno (para todo el rediseno)

- Tema oscuro tipo "estudio de noche", instrumento tecnico preciso, no folleto
  corporativo. UNA marca de producto por superficie; credito a Capdesis una vez.
- Contraste accesible (WCAG AA) en iconos y texto sobre navy.
- Affordances claros: si hay mas contenido (scroll/swipe lateral), indicarlo
  (degradado, flecha, hint). Nunca dejar al usuario pensando "aqui acaba" o "no
  reacciona".
- Estados: cargando (con timeout), vacio (invitacion a actuar), error (que paso y
  como arreglarlo, en la voz de la interfaz). Ningun spinner infinito.
- Jerarquia mas plana; facil de buscar y ver lo que se hace.
- Interactividad donde aporte (calculadoras input->output).
- Conservar la grid de 2 columnas (al operador le gusta) y el navy + wordmark
  Sriracha.

## 6. Otros contextos verificados

- Repos: canonico `CAPDESIS/formulaeapps` (monorepo, buildea a prod);
  `FormulaeCommunity` standalone = app de Play Store (no tocar); `FormulaePro`
  archivado. Pro vive en `monorepo/pro`.
- La app es dark-only. Se despliega tambien como Flutter web (canvaskit).
- Carpetas de favoritos YA EXISTEN (FavoriteFolder, createFolder, mover entre
  carpetas, exportFolder = imprimir carpeta a un PDF). Solo pulir UX.
- Existe un `capdesis-ui` (design system) en el workspace, de otro equipo; no
  tocar desde Formulae salvo instruccion explicita.
