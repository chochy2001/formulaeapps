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
| `EN_CURSO` | 0 | No queda una corrección local prioritaria sin cerrar. |
| `PENDIENTE` | 1 | Integración sobre el SHA actual de `origin/main`. |
| `BLOQUEADO` | 1 | Publicación de imágenes en hosting. |
| `HECHO` | 10 | Tracker, assets, PDF local, pruebas, navegación, QA, móvil, calidad y rendimiento. |

## Orden de ejecución

1. Revalidar/integrar sobre el SHA de promoción en `FML-107` con autorización
   explícita para crear el commit y resolver la integración.
2. Reintentar `FML-101` únicamente cuando exista acceso de hosting autorizado;
   no inventar evidencia de producción.

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
- Evidencia: El smoke remoto del 2026-07-13 devolvió 404 para 176 de 176 URLs;
  los assets fuente están presentes y validados localmente. La comprobación de
  presencia no encontró variables FTP/Hostinger ni `.env` local.
- Bloqueo: `docs/DEPLOY_CI_WEB.md` exige entorno protegido, FTPS validado,
  snapshot y smoke con rollback; no existen credenciales ni promoción de
  hosting disponible en este checkout.

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
  exista fallback de red; la suite completa terminó con 95 pruebas.
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
  terminó con 95 pruebas.
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
  suite completa de Community pasó 95 pruebas con los `dart-defines` de CI.
  El baseline inicial de 587 diagnósticos `info` fue eliminado sin suprimir el
  gate.
- Bloqueo: Ninguno.

### FML-107: Integrar el trabajo sobre el SHA de promoción

- Estado: PENDIENTE
- Prioridad: P1
- Area: Git e integración
- Responsable: Codex
- Proximo paso: Con autorización explícita para crear el commit, integrar o
  revalidar contra `origin/main` antes de abrir una promoción.
- Criterio de cierre: El cambio existe sobre el SHA objetivo, sin conflictos y
  con quality gates repetidos desde ese estado.
- Evidencia: Tras `git fetch origin` el 2026-07-13, `HEAD=be796b1`,
  `origin/main=d475fc8` y `HEAD...origin/main` indicó `0 11`; el árbol tiene
  cambios locales sin commit. La medición se debe refrescar antes de integrar.
- Bloqueo: No hay autorización para crear commit, rebase ni merge; hacerlo con
  un árbol local pendiente mezclaría cambios sin una revisión de integración.

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
