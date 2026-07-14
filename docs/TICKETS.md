# Tablero de ejecución de Formulae

Este es el registro operativo activo de Formulae. No es un handoff: Codex
mantiene y ejecuta los tickets hasta cerrarlos o dejar una dependencia externa
con evidencia concreta. La primera fuente de verdad es el código y las pruebas;
este tablero refleja ese estado y no lo sustituye.

## Uso

- El ticket de menor prioridad numérica con estado `EN_CURSO` es el trabajo
  inmediato.
- Un ticket solo pasa a `HECHO` con evidencia ejecutable o visual en su campo
  correspondiente.
- `BLOQUEADO` requiere causa, dependencia y próximo paso verificable. No se usa
  para posponer deuda local.
- Antes de cerrar una sesión se actualizan el estado, evidencia y próximo paso.
- `make verify-tickets` valida IDs, estados y los campos obligatorios.

## Resumen actual

| Estado | Tickets | Lectura rápida |
| --- | ---: | --- |
| `EN_CURSO` | 0 | Ninguno: el trabajo restante depende de controles y runners externos. |
| `PENDIENTE` | 0 | Ninguno. |
| `BLOQUEADO` | 4 | Hosting, staging/promoción, runners/controles externos y decisión/validadores de entitlement. |
| `HECHO` | 25 | Tracker, assets, PDF local, pruebas, navegación, QA, móvil, calidad, rendimiento, localización, IAP fail-closed, BFF resiliente, configuración persistente, dependencia segura, Compose local aislado, validador de infraestructura, documentación archivada, fallback extensible, integración y aislamiento BFF. |
| `CANCELADO` | 0 | Ninguno. |

## Orden de ejecución

1. Resolver `FML-116`: restaurar un runner autorizado de `ci-builds`, repetir
   CI y el candidato web sobre el SHA exacto de `main`, y registrar resultados
   terminales antes de cerrar `FML-127`.
2. Resolver `FML-101`: promover las imágenes únicamente mediante la ruta FTPS
   protegida, con snapshot, smoke y rollback verificables.
3. Resolver la decisión de producto y los validadores/sandbox de `FML-117`
   antes de activar IAP remoto o cuentas. No inventar evidencia de producción
   ni de controles GitHub/VPS.

## Tickets

### FML-099: Tracker operativo verificable

- Estado: HECHO
- Prioridad: P0
- Area: Documentación y calidad
- Responsable: Codex
- Proximo paso: Mantener este archivo al cerrar cada ticket.
- Criterio de cierre: Tracker versionado, validable desde Make y enlazado desde
  la documentación de entrada.
- Evidencia: `docs/TICKETS.md`, `scripts/validate-ticket-tracker.sh` y
  `make verify-tickets`.
- Bloqueo: Ninguno.

### FML-100: Assets canónicos sin idioma

- Estado: HECHO
- Prioridad: P0
- Area: Landing, Pro y Community
- Responsable: Codex
- Proximo paso: Conservar un solo asset por concepto y ejecutar el validador al
  modificar el catálogo.
- Criterio de cierre: 176 assets locales válidos y las dos apps declarando las
  mismas URLs canónicas sin variante por idioma.
- Evidencia: `cd landing && bun run check:formulae-images` pasó con 176 assets;
  las pruebas de mapa de URL de Pro y Community cubren la paridad.
- Bloqueo: Ninguno para el código local.

### FML-101: Publicar y verificar las imágenes canónicas

- Estado: BLOQUEADO
- Prioridad: P0
- Area: Hosting de landing
- Responsable: Codex, requiere acceso de hosting autorizado
- Proximo paso: Promover `landing/public/imagenes/` y reglas de compatibilidad,
  luego ejecutar `cd landing && bun run check:formulae-images:remote`.
- Criterio de cierre: Las 176 URLs de `https://formulaeapps.com/imagenes/`
  responden HTTP 200, MIME de imagen y decodifican correctamente.
- Evidencia: El smoke remoto se repitió tras los gates finales y devolvió 404
  `text/html` para 176 de 176 URLs; los assets fuente están presentes y
  validados localmente. La comprobación de presencia no encontró variables
  FTP/Hostinger ni `.env` local.
- Bloqueo: `docs/DEPLOY_CI_WEB.md` exige entorno protegido, FTPS validado,
  snapshot y smoke con rollback. La ruta FTPS (host, autenticación, snapshot,
  publicación atómica y rollback) no se pudo verificar desde este checkout;
  no existe una promoción de hosting segura que ejecutar aún.

### FML-102: PDF funcional sin dependencia de PDFs remotos en Community

- Estado: HECHO
- Prioridad: P0
- Area: Community
- Responsable: Codex
- Proximo paso: Mantener la ficha explícitamente diferenciada del PDF histórico
  y restaurar ese contenido solo si producto aporta una fuente aprobada.
- Criterio de cierre: Las acciones de PDF de Community no dependen de las URLs
  heredadas 404 para ofrecer un resultado útil o una alternativa explícita.
- Evidencia: `community/lib/pdf/community_pdf_document.dart` genera bytes
  locales `%PDF-`; `ver_pdf.dart` los muestra con `SfPdfViewer.memory` y el
  exportador es condicional por plataforma. `community_pdf_document_test.dart`
  y `ver_pdf_local_action_test.dart` cubren generación, exportación y que no
  exista fallback de red; la suite completa terminó con 100 pruebas.
- Bloqueo: Ninguno para ver/exportar la ficha local. Recuperar el contenido
  histórico exacto requiere una fuente aprobada aparte.

### FML-103: Eliminar falsos verdes de pruebas Community

- Estado: HECHO
- Prioridad: P0
- Area: Community, pruebas
- Responsable: Codex
- Proximo paso: Conservar las aserciones de comportamiento y el fake WebView
  limitado a la prueba que necesita plataforma nativa.
- Criterio de cierre: Las rutas cubiertas fallan ante un error Flutter real y la
  suite mantiene pruebas de comportamiento útiles.
- Evidencia: Se eliminaron `FlutterError.onError`, drains de `takeException`,
  `warnIfMissed:false` y `catch` vacíos de las cinco suites afectadas. El
  mapeador verifica 297 rutas no nativas y 259 widgets, y la suite completa
  terminó con 100 pruebas.
- Bloqueo: Ninguno.

### FML-104: Navegación y responsive de Community

- Estado: HECHO
- Prioridad: P0
- Area: Community, UX
- Responsable: Codex
- Proximo paso: Mantener los breakpoints cubiertos al añadir destinos o acciones
  nuevas.
- Criterio de cierre: Home no infla la pila y la navegación principal mantiene
  funcionalidades alcanzables en los breakpoints soportados.
- Evidencia: Home usa `popUntil(isFirst)` y `menu.dart` usa barra inferior bajo
  900 px y `NavigationRail` desde 900 px. `navigation_shell_test.dart` cubre
  320, 899, 900 y 1440 px y el retorno a Home.
- Bloqueo: Ninguno.

### FML-105: QA integrado visual y funcional

- Estado: HECHO
- Prioridad: P0
- Area: Landing, Pro y Community
- Responsable: Codex
- Proximo paso: Repetir esta matriz en el SHA que se vaya a promover y ante cada
  cambio de layout o plataforma.
- Criterio de cierre: Sin overflow, error de consola ni acción inaccesible en los
  flujos modificados; quality gates de los stacks tocados pasan.
- Evidencia: Landing se inspeccionó entre 320 y 1440 px sin overflow; Pro
  inspeccionó Tareas y Favoritos a 320/900 px sin errores de consola y cubre
  180 tareas. Community pasó sus pruebas responsive/PDF/navegación, compiló y
  arrancó en simuladores iOS y Android; la imagen superior mostró el
  placeholder esperado por `FML-101`, no un error de layout.
- Bloqueo: Ninguno para el alcance local. Android/dispositivo físico se registra
  aparte en `FML-108`.

### FML-106: Reducir baseline del analizador de Community

- Estado: HECHO
- Prioridad: P1
- Area: Community, calidad de código
- Responsable: Codex
- Proximo paso: Mantener `--fatal-infos` en Make y CI, y revisar cualquier
  nueva categoría de diagnóstico en el cambio que la introduzca.
- Criterio de cierre: `flutter analyze --no-pub --fatal-infos --fatal-warnings`
  pasa sin un baseline tolerado.
- Evidencia: El comando estricto terminó con `No issues found!`; además, la
  suite completa de Community pasó 100 pruebas con los `dart-defines` de CI.
  El baseline inicial de 587 diagnósticos `info` fue eliminado sin suprimir el
  gate.
- Bloqueo: Ninguno.

### FML-107: Integrar el trabajo sobre el SHA de promoción

- Estado: HECHO
- Prioridad: P1
- Area: Git e integración
- Responsable: Codex
- Proximo paso: Mantener los gates de integración para cambios posteriores y
  comprobar el SHA remoto antes de cualquier promoción externa.
- Criterio de cierre: El cambio existe sobre el SHA objetivo, sin conflictos y
  con quality gates repetidos desde ese estado.
- Evidencia: La PR [#79](https://github.com/CAPDESIS/formulaeapps/pull/79)
  integró el trabajo en `main` mediante
  `4bc1c6aa0d664a36eb4b5bb400b84b0939247fbc`, tras el preflight verde
  `29300786169` sobre `563c316`. Incluye el aislamiento BFF `e9d8a13`;
  `make verify-all` pasó sobre ese candidato con contrato/paridad, 173 pruebas
  BFF (481 expectativas), análisis y pruebas Flutter, landing,
  infraestructura y tickets. `bun run build` del BFF y
  `gitleaks protect --staged --redact` también pasaron. El preflight previo
  del padre `5c65bc0` detectó mocks IAP contaminados; `e9d8a13` los sustituyó
  por inyección aislada antes de la integración.
- Bloqueo: Ninguno para la integración ya realizada. El merge no constituye
  evidencia de staging ni de producción.

### FML-108: Validación en emulador y dispositivos móviles

- Estado: HECHO
- Prioridad: P1
- Area: Android e iOS
- Responsable: Codex, requiere dispositivo o emulador configurado
- Proximo paso: Repetir esta ejecución para cambios móviles relevantes. El
  iPhone físico es una validación adicional, no un sustituto de la evidencia
  emulada ya obtenida.
- Criterio de cierre: Evidencia de ejecución en ambos sistemas o una matriz de
  plataformas realmente soportadas aprobada por producto.
- Evidencia: iOS Simulator compiló, instaló y abrió Community sin crash
  (`FML-109`). Para Android se restauraron las Command-line Tools y la imagen
  Google Play ARM64 API 36.1 que faltaban; `flutter doctor -v` y `flutter
  devices` reconocen `emulator-5554`. El APK Debug se instaló, abrió
  `capdesis.formulae/.MainActivity` y sobrevivió a un reinicio cálido sin
  `FATAL EXCEPTION`, `AndroidRuntime` ni `GADInvalidInitializationException`.
- Bloqueo: Ninguno para la matriz emulada. El iPhone físico sigue condicionado
  a desbloqueo y Developer Mode si se requiere esa validación adicional.

### FML-109: Configuración segura de AdMob en Community iOS/Android

- Estado: HECHO
- Prioridad: P0
- Area: Community, iOS y anuncios
- Responsable: Codex
- Proximo paso: Para publicar con anuncios, inyectar por CI un
  `ADMOB_IOS_APP_ID` real no-test y los IDs de unidad reales, sin usar valores
  de Debug/Profile.
- Criterio de cierre: Debug de iOS/Android usa únicamente los IDs oficiales de
  prueba y iOS arranca sin `GADInvalidInitializationException`; Release sin
  configuración aprobada se rechaza antes de convertirse en una app con
  anuncios inválidos.
- Evidencia: El `Runner.app` anterior expandía `GADApplicationIdentifier` vacío
  y crasheaba. Tras corregir las referencias xcconfig, `flutter build ios
  --debug --simulator --no-codesign` contiene el ID oficial de prueba;
  `xcrun simctl launch booted capdesis.formulae` devolvió PID y abrió Home sin
  la excepción. `flutter build apk --debug --no-pub` generó el
  APK y el manifest Android fusionado contiene el ID oficial de prueba. Las
  compilaciones Release de Xcode y Gradle sin ID fallan deliberadamente con la
  guardia de AdMob. `admob_config_test.dart` y las pruebas del controlador
  pasaron 6/6.
- Bloqueo: Ninguno para Debug. Una publicación Release con anuncios requiere
  configuración real aprobada fuera de Git.

### FML-110: Medir y optimizar el arranque Android

- Estado: HECHO
- Prioridad: P1
- Area: Community, rendimiento Android
- Responsable: Codex
- Proximo paso: Repetir `RUNS=5 make measure-community-android` después de un
  cambio que afecte el arranque, y comparar sobre el mismo AVD o dispositivo.
- Criterio de cierre: Existe una medición reproducible con entorno y percentil
  documentados, y no se atribuye a Community trabajo posterior a que la UI ya
  es interactiva.
- Evidencia: `scripts/measure-community-android-startup.sh` fuerza el cierre,
  abre la actividad y espera el `ScrollView` de Home vía `uiautomator`. En
  `emulator-5554` (API 36.1, 1 core/2 GB), cinco corridas dieron 2539, 6143,
  2740, 2711 y 2578 ms: mediana 2711 ms, p95 6143 ms, sin timeout. El anterior
  `am start -W` de `Fully drawn +19s31ms` incluye trabajo posterior a la UI
  útil y no se usa como métrica de experiencia inicial.
- Bloqueo: Ninguno para la medición reproducible; un perfil de hardware físico
  requiere el dispositivo correspondiente.

### FML-111: Marketing localizado sin visuales dependientes del idioma

- Estado: HECHO
- Prioridad: P0
- Area: Landing, i18n y SEO
- Responsable: Codex
- Proximo paso: Ejecutar `bun run check:localized-marketing` al modificar Hero,
  galería, enlaces localizados, JSON-LD u OG.
- Criterio de cierre: ES y EN muestran los mismos previews matemáticos sin copy
  incrustado, las rutas localizadas existen y las capacidades comparadas son
  verdaderas para ambas apps.
- Evidencia: `FormulaePreview.astro` sustituyó las capturas localizadas del Hero
  y la galería; `/en/support` se comprobó en el navegador local, EN no incrusta
  el video español, JSON-LD/OG quedaron localizados o neutrales y la comparación
  ya reconoce Tareas y PDF local de Community. Build y
  `bun run check:localized-marketing` pasaron localmente.
- Bloqueo: Ninguno para el checkout local.

### FML-112: Fallback visible de diagramas Pro ante un host remoto caído

- Estado: HECHO
- Prioridad: P0
- Area: Pro, resiliencia de imágenes
- Responsable: Codex
- Proximo paso: Mantener `ImagenRemotaRobusta` en rutas nuevas que carguen
  diagramas desde red y conservar la regresión de fallback.
- Criterio de cierre: Un fallo HTTP/red no deja huecos silenciosos en los puntos
  centrales de renderizado de diagramas Pro.
- Evidencia: `constantes_imagenes.dart` usa `ImagenRemotaRobusta` en los dos
  caminos que usaban `Image.network` sin `errorBuilder`; la prueba
  `ver_imagen_fallback_test.dart` pasó 5/5 y el analizador estricto de Pro no
  informó diagnósticos.
- Bloqueo: El asset real de producción sigue sujeto a `FML-101`; el fallback
  evita un estado roto, no sustituye publicar las 176 imágenes.

### FML-113: Controles Community localizados y seguros entre plataformas

- Estado: HECHO
- Prioridad: P0
- Area: Community, i18n, accesibilidad y configuración
- Responsable: Codex
- Proximo paso: Mantener las claves ARB y las pruebas de URL/plataforma al
  añadir controles nuevos o soporte de plataforma.
- Criterio de cierre: No quedan controles españoles hardcodeados en el flujo
  revisado, la navegación cumple contraste AA y cancelar suscripción no puede
  lanzar `LateInitializationError` en plataformas sin URL nativa.
- Evidencia: La auditoría de UI identificó texto hardcodeado en
  `boton_pistas.dart`, `task_tile.dart` y `alerts_dialogs.dart`, título de app
  incorrecto, contraste 2.90:1 y una URL `late` no inicializada fuera de móvil.
  Las correcciones usan ARB, `#8A93C4` (4.84:1) y URL segura por plataforma;
  análisis estricto pasó, pruebas focales 11/11 y suite completa 100/100.
- Bloqueo: Community no declara targets Web/Windows/Linux; no se generaron sin
  decisión de producto, pero las rutas de esos casos se cubren unitariamente.

### FML-114: Gates y documentación coherentes con el estado verificable

- Estado: HECHO
- Prioridad: P1
- Area: Documentación, Make y calidad
- Responsable: Codex
- Proximo paso: Mantener los comandos de la auditoría ejecutables desde el
  directorio indicado y actualizar los conteos de tickets al cambiar estados.
- Criterio de cierre: `verify-all` incluye typecheck BFF y lint de landing, el
  build valida marketing localizado, y los documentos no presentan handoff ni
  CI/despliegues históricos como estado actual.
- Evidencia: Make añade `bff-typecheck`, `landing-lint` y
  `check:localized-marketing`; el validador admite y contabiliza `CANCELADO`.
  Se actualizan auditoría, README de landing/BFF/Community y el archivo
  histórico de Pro con fuentes de verdad actuales.
- Bloqueo: Ninguno para la documentación y los gates locales.

### FML-115: Disponibilidad IAP BFF fail-closed

- Estado: HECHO
- Prioridad: P0
- Area: BFF, compras y CI
- Responsable: Codex
- Proximo paso: Mantener la disponibilidad en `false` hasta que validadores
  reales y pruebas sandbox se entreguen en la misma revisión.
- Criterio de cierre: Staging/producción no comunican validación disponible sin
  un proveedor real y dev conserva solamente el stub explícito de pruebas.
- Evidencia: `iap-availability.ts` devuelve `*_not_configured` o
  `*_validator_not_ready` fuera de desarrollo; `/iap/validate` responde
  `503 E_IAP_VALIDATION_UNAVAILABLE` sin campo `valid`. Además,
  `iap-entitlement-persistence.ts` persiste el grant móvil antes de permitir
  `valid=true`; ausencia de sujeto devuelve `E_IAP_MISSING_SUBJECT` y un fallo
  de almacenamiento se convierte en `E_ENTITLEMENT_PERSISTENCE`, no en un
  éxito falso. `iap-entitlement-persistence.test.ts` cubre ambos fallos.
- Bloqueo: Los validadores Apple/Google y compras sandbox siguen en `FML-117`;
  el aislamiento de pruebas que vive en `origin/main` se sigue en `FML-118`.

### FML-116: Controles externos de promoción, GitHub y persistencia BFF

- Estado: BLOQUEADO
- Prioridad: P0
- Area: GitHub, VPS y despliegue
- Responsable: Operador de infraestructura, con apoyo de Codex
- Proximo paso: Reparar el runner de landing, provisionar staging para el SHA
  exacto, required checks/permisos mínimos y un entorno de producción protegido;
  después verificar FTPS con snapshot/rollback y el volumen BFF con
  backup/restore en el VPS antes de promocionar.
- Criterio de cierre: `main` no acepta cambios con preflight rojo, el BFF posee
  almacenamiento persistente escribible y la promoción usa secretos y entorno
  protegidos sin incorporarlos al repositorio.
- Evidencia: GitHub permitió merges con `JWT light preflight` rojo porque no hay
  required checks ni revisión obligatoria. Los rulesets activos sólo cubren
  borrado/non-fast-forward; no existe entorno `production` protegido y el único
  entorno observado fue `copilot`. El último intento de workflow de landing no
  llegó a una promoción: falló al preparar Node en el runner con `EACCES` bajo
  su toolcache. No hay staging que pueda atestiguar un SHA candidato ni rollback
  probado. En el VPS, `/opt/infrastructure/formulaeapps` no es un checkout Git
  trazable y el contenedor BFF observado tiene `LocalVolumes=0`; por tanto no
  existe evidencia de volumen, recreate, backup o restore. La ruta FTPS web
  tampoco tiene host/certificado, snapshot, publicación atómica, marker ni
  rollback verificables. Las 176 imágenes siguen 404 en el hosting público.
- Bloqueo: Producción queda bloqueada hasta que operador aporte staging, SHA
  verde, entorno/secretos protegidos y una ruta FTPS/VPS comprobable con
  snapshot, smoke y rollback. No se deben inventar archivos `.env`, credenciales
  ni cambiar controles remotos sin la configuración autorizada.

### FML-117: Autoridad de entitlement y vínculo cuenta-dispositivo

- Estado: BLOQUEADO
- Prioridad: P0
- Area: Producto, BFF y compras
- Responsable: Producto e infraestructura, con apoyo de Codex
- Proximo paso: Elegir la autoridad de entitlement para online/offline,
  timeout, `503` y restauraciones; después implementar validadores sandbox y,
  si producto requiere migrar un dispositivo existente a una cuenta, una
  vinculación basada en sesión verificada o pairing de un solo uso.
- Criterio de cierre: Las compras sólo se conceden según una política aprobada,
  validadores reales, persistencia durable y una cuenta/dispositivo que pruebe
  posesión, sin poder reclamar `client_id` ajeno.
- Evidencia: Pro actualmente concede por StoreKit/Billing local y la llamada BFF
  es opt-in/telemetría. El candidato actual corrige el riesgo anterior:
  register/login usan esquemas estrictos que rechazan `client_id`, emiten
  `sub=user:<user_id>` y no adoptan grants de dispositivo; el helper de binding
  fue eliminado. `readMobileEntitlement` filtra una fila de sujeto vinculada a
  otro `user_id`; regresiones demuestran que un `client_id` ajeno no expone ni
  vincula su entitlement. El contrato generado es `2.0.0`. Estas correcciones
  no equivalen a una decisión de autoridad ni a validadores Apple/Google listos.
- Bloqueo: Requiere decisión de producto, credenciales/sandbox Apple y Google,
  y diseño de identidad/persistencia. No es seguro escoger la política ni
  activar una compra remota por inferencia.

### FML-118: Integrar y aislar pruebas BFF de la rama entrante

- Estado: HECHO
- Prioridad: P0
- Area: Git, BFF y pruebas
- Responsable: Codex
- Proximo paso: Mantener esta suite como gate de todo cambio en rutas protegidas,
  validadores IAP, JWT o contrato generado.
- Criterio de cierre: El candidato integrado no comparte mocks entre archivos,
  pasa sus pruebas BFF de forma reproducible y no incorpora el vínculo inseguro
  de `FML-117`.
- Evidencia: El preflight de `5c65bc0` reveló dos falsos resultados `valid:true`
  porque `mock.module` de otra prueba alteraba el singleton de IAP. `e9d8a13`
  elimina los mocks globales, crea router/handler IAP con dependencias inyectadas
  por prueba y añade una regresión que prueba que un 503 simulado no altera el
  stub normal. Sobre ese SHA, `make verify-all` terminó correctamente: BFF
  `173 pass`, `0 fail`, `481 expect()` en 30 archivos; además el grupo IAP se
  repitió aleatoriamente 10 veces (130/130). La ejecución vuelve a generar y
  verifica el contrato `2.0.0` y ambos clientes Dart, sin cambios fuera del
  índice. El aislamiento quedó integrado en `main` por la PR
  [#79](https://github.com/CAPDESIS/formulaeapps/pull/79), merge `4bc1c6a`.
- Bloqueo: Ninguno local.

### FML-119: Resiliencia y contratos seguros de OpenRouter e IAP

- Estado: HECHO
- Prioridad: P1
- Area: BFF, seguridad y rate limiting
- Responsable: Codex
- Proximo paso: Mantener el timeout, el contrato de error y el límite IAP al
  modificar proveedores o rutas protegidas.
- Criterio de cierre: Chat no filtra mensajes/tipos de proveedor, termina por
  timeout controlado y el 429 anunciado para IAP tiene límite real y probado.
- Evidencia: `openrouter-proxy.ts` usa `AbortController` de 20 s y errores
  normalizados; `error.ts` sólo confía en `BffError` y las regresiones cubren
  timeout, abort y secretos de proveedor. `/iap/validate` limita a 10 por
  ventana, con key hash de IP+sujeto, `429 E_RATE_LIMITED_IAP` y `Retry-After`.
  `bun run typecheck`, `check:persistence-config` y BFF tests pasaron 138/138.
- Bloqueo: Ninguno conocido para la corrección local.

### FML-120: Eliminar fallos silenciosos de cargas remotas restantes en Pro

- Estado: HECHO
- Prioridad: P1
- Area: Pro, resiliencia de imágenes
- Responsable: Codex
- Proximo paso: Usar `ImagenRemotaRobusta` para cualquier consumidor remoto
  nuevo y mantener las pruebas de consumidores/fallback compacto.
- Criterio de cierre: Ningún logo, diálogo, tarea o pantalla de chat revisado
  mantiene spinner o hueco indefinido cuando el host público devuelve 404.
- Evidencia: Se reemplazaron los ocho `FadeInImage`/`NetworkImage` restantes
  en información, configuración, chat, compra, diálogos, ejercicios y tareas.
  `rg` no encuentra cargas directas en `pro/lib`; quedan sólo el cargador
  `CachedNetworkImage` con timeout/fallback. Análisis estricto pasó y la suite
  Pro con defines de CI pasó 88/88, incluidas 23 pruebas focales.
- Bloqueo: La corrección visual local no publica los assets; la disponibilidad
  de las imágenes reales sigue en `FML-101`.

### FML-121: Persistencia y permisos del runtime BFF

- Estado: HECHO
- Prioridad: P0
- Area: BFF, Docker y datos
- Responsable: Codex
- Proximo paso: Al integrar los stores entrantes, conservar los paths y el
  guardia `bun run check:persistence-config`; validar backup y recreate en el
  VPS antes de declarar una operación productiva.
- Criterio de cierre: Compose declara un volumen estable para ambas rutas,
  Docker prepara `/app/.data` antes de bajar privilegios y un guardia estático
  detecta drift de paths/permisos sin secretos ni daemon.
- Evidencia: Docker crea/chown/chmod `/app/.data`, Compose monta
  `formulaeapps_bff_data`, `.env.example` declara ambos paths y
  `check:persistence-config`, typecheck y BFF tests pasaron (138/138). El
  overlay local explícito ahora resetea realmente `.env`, secretos, red y
  etiquetas de producción, se enlaza sólo a loopback y no contiene firmante JWT
  determinista; su lint y el preflight CORS contra un BFF nativo temporal en
  `localhost:3001` pasaron.
- Bloqueo: La prueba real de volumen, permisos y backup sigue siendo parte de
  la promoción externa `FML-116`. La inspección del VPS observó
  `LocalVolumes=0` en el BFF y un directorio de stack sin checkout Git trazable;
  por tanto la topología local no prueba persistencia productiva.

### FML-122: Remediar advisory transitivo de BFF

- Estado: HECHO
- Prioridad: P1
- Area: BFF, dependencias y seguridad
- Responsable: Codex
- Proximo paso: Ejecutar `bun run audit` al actualizar el lockfile o SDKs de
  proveedor y no aceptar una excepción que esconda un advisory alto.
- Criterio de cierre: El advisory HIGH de `form-data` se resuelve con una
  versión compatible, lockfile congelado, auditoría limpia y tests del BFF.
- Evidencia: `@apple/app-store-server-library` traía `form-data@4.0.5` de forma
  transitiva; `overrides.form-data=4.0.6` conserva el rango `^4.0.4` del SDK.
  `bun pm why form-data` muestra sólo 4.0.6, `bun run audit` no reporta
  vulnerabilidades y typecheck/tests BFF pasaron 138/138.
- Bloqueo: Ninguno para el checkout local.

### FML-123: Aislar Compose local y cablear el BFF de desarrollo

- Estado: HECHO
- Prioridad: P0
- Area: Docker, Pro y seguridad local
- Responsable: Codex
- Proximo paso: Mantener la overlay local nombrada explícitamente y exigir un
  firmante generado por el operador antes de iniciar flujos autenticados.
- Criterio de cierre: Un comando estándar de producción no aplica ajustes de
  desarrollo; el BFF local sólo escucha en loopback y Pro recibe base/auth/chat
  coherentes contra `localhost:3001`.
- Evidencia: `docker-compose.override.yml` se sustituyó por
  `docker-compose.local.yml`; Make y la documentación usan `-f` explícitos. El
  guardia `infra-validate` verifica overlay, red, secretos, puerto loopback y
  args de Pro. `docker compose -f docker-compose.yml -f
  docker-compose.local.yml --profile full config` confirmó base
  `http://localhost:3001` y chat `/openai/chat`; `make compose-lint` pasó.
- Bloqueo: El arranque real de contenedor sigue requiriendo daemon Docker y un
  `JWT_SIGNING_SECRET` independiente del operador; la evidencia de VPS queda
  en `FML-116`.

### FML-124: Hacer confiable el validador de infraestructura

- Estado: HECHO
- Prioridad: P1
- Area: Infraestructura y calidad
- Responsable: Codex
- Proximo paso: Conservar el escaneo del workspace excluyendo worktrees y
  repositorios protegidos; ajustar la lista de hosts sólo con rutas verificables.
- Criterio de cierre: El gate no da PASS falso por ruta de workspace errónea,
  HTTP 4xx/null, TLS inválido o CORS de API fallido.
- Evidencia: `infra-validate.ts` ahora ubica el workspace real, excluye
  `worktrees`, `copilot-worktrees` y `No_tocar_repos_clientes`, agrupa clones
  de FormulaeApps y exige endpoints 2xx/3xx, TLS válido y CORS de API. El gate
  local pasó con 38 routers y cero colisiones Formulae; el gate de producción
  comprobó los cuatro hosts y falló correctamente sólo por el `.env` protegido
  ausente.
- Bloqueo: El Compose base y la promoción/VPS siguen dependiendo de secretos y
  acceso autorizados en `FML-116`.

### FML-125: Distinguir documentación histórica de evidencia vigente

- Estado: HECHO
- Prioridad: P1
- Area: Documentación
- Responsable: Codex
- Proximo paso: Actualizar README, auditoría y tickets con evidencia nueva; no
  reutilizar snapshots históricos para decisiones operativas.
- Criterio de cierre: Ningún `MASTER_SPEC` o documento histórico puede
  presentarse como autorización de release frente a la auditoría actual.
- Evidencia: `landing/MASTER_SPEC.md`, `pro/MASTER_SPEC.md`,
  `community/MASTER_SPEC.md`, `ARCHITECTURE.md` y
  `DEPLOY-NOTES-2026-04-30.md` se marcaron como históricos/no operativos y
  enlazan a README, auditoría, despliegue protegido y tracker vigentes.
  `pro/docs/BACKLOG_REDISENO_PRO.md` también se archivó; la visión Super Plus
  ahora declara que IAP remoto no es una autoridad productiva; `flavors.md`
  exige los defines release; `GRAFICOS_PENDIENTES.md` hereda el contrato visual
  sin idioma. Los README generados de los clientes eliminan enlaces `doc/*.md`
  inexistentes e instrucciones Dart inválidas de forma determinista en
  `scripts/generate-bff-types.sh`; sus 6+6 pruebas y el generador pasaron.
- Bloqueo: Ninguno para la corrección documental local.

### FML-126: Hacer extensible la localización de fallback y metadatos Community

- Estado: HECHO
- Prioridad: P1
- Area: Pro, Community e i18n
- Responsable: Codex
- Proximo paso: Añadir cualquier copy nuevo a ARB y conservar la identidad
  Community si se habilita Windows con una decisión de producto.
- Criterio de cierre: El fallback de imagen de Pro no elige idioma mediante un
  condicional ES/EN y Community no reutiliza identidad/ruta Windows de Pro.
- Evidencia: `imagenNoDisponible` se incorporó a ARB y localizaciones generadas
  de Pro, con pruebas ES/EN. `community/pubspec.yaml` usa Formulae Community,
  `CAPDESIS.FormulaeCommunity` y ruta de logo relativa. Análisis estricto y
  pruebas focales de ambas apps pasaron.
- Bloqueo: Community sigue sin target Windows por decisión de producto; no se
  generó plataforma nueva.

### FML-127: Alinear la CI Flutter con el gate determinista

- Estado: BLOQUEADO
- Prioridad: P1
- Area: CI, Pro y Community
- Responsable: Codex
- Proximo paso: Restaurar un runner `ci-builds` autorizado y en línea; después
  repetir la CI y el candidato web del SHA exacto de `main` y registrar los
  resultados Flutter y de clientes BFF.
- Criterio de cierre: Los jobs remotos de Pro y Community ejecutan exactamente
  la misma concurrencia que `make flutter-test`, terminan sin timeout y pasan
  análisis, pruebas y contratos generados.
- Evidencia: La PR [#83](https://github.com/CAPDESIS/formulaeapps/pull/83)
  integró `FLUTTER_TEST_CONCURRENCY=1` en `main` mediante
  `081aa889ff95705b64e88d06b310097f6ee468ed`; `make flutter-test` ya pasó con
  esa concurrencia y el YAML de Actions valida. Los runs exactos de ese SHA,
  CI `29301504493` y candidato web `29301504487`, se enviaron después de
  cancelar los runs obsoletos `29300874967` y `29300874991`. Quedaron en cola:
  los runners elegibles de `ci-builds` (`test-light` y `build-heavy`) están
  offline y el runner de política compatible también quedó offline. No existe
  todavía resultado remoto terminal ni artefacto candidato para este SHA.
- Bloqueo: Depende de `FML-116`: un operador debe restaurar capacidad de runner
  autorizada para Formulae. No es seguro redirigir estas cargas a un runner o
  grupo no autorizado ni afirmar CI verde mientras siguen en cola.
