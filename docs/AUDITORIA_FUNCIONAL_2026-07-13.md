# Auditoría funcional de Formulae, 2026-07-13

Este documento es el estado verificable de la revisión integral realizada en
la rama `agent/formulae-image-regeneration-20260713`, iniciada sobre la base
local `be796b1`. Sustituye las afirmaciones no fechadas de "producción lista"
en la documentación histórica. No autoriza despliegues, publicaciones en
tiendas, promociones de hosting ni merges a `main` sin revalidar el SHA exacto.
Durante la revisión `origin/main` avanzó a `c79e866`, por lo que sus cambios no
se confunden con la evidencia del checkout inicial.

## Alcance revisado

- Landing Astro, assets publicados bajo `landing/public/imagenes/` y sus
  validadores.
- Formulae Pro y Formulae Community, con foco en diagramas, layouts pequeños,
  FAQ y flujos de PDF.
- BFF, contrato OpenAPI, cobertura de rutas y documentación de los clientes
  Dart generados.
- Compose local y dependencias de runtime que no se pueden simular sin el
  entorno del operador.

## Hecho y verificado localmente

| Área | Resultado |
| --- | --- |
| Assets canónicos | Hay 176 assets en `landing/public/imagenes/`. Pro y Community declaran exactamente las mismas 176 URLs sin rutas por idioma. La auditoría OCR dejó solamente la marca fija CAPDESIS, permitida por el contrato visual. |
| Contrato visual | Las imágenes no contienen copy localizado. Las instrucciones y etiquetas viven en Flutter ARB. Los aliases históricos de `imagenes_ingles` redirigen al asset canónico, no a otra variante. |
| Landing | El validador local de assets pasa. Hero y galería usan previews matemáticos renderizados por código, sin texto incrustado ni capturas por idioma; `/en/support`, JSON-LD y la comparativa de capacidades se validan en el build. La landing ya tiene redirecciones de compatibilidad en `.htaccess` y `nginx.conf`. |
| Imágenes Community | Las cargas remotas de `community/lib` usan `ImagenRemotaRobusta`: cache, timeout de 12 s, placeholder localizado y `FORMULAE_IMAGE_ORIGIN` para revisar contra la landing local. Los logos compactos conservan su tamaño y un fallo remoto no deja spinner ni error de imagen sin controlar. |
| Responsive | Se corrigieron tres tarjetas de derivación que desbordaban verticalmente, el título Formulae de Pro y Community ahora escala en una AppBar estrecha, los labels de tarjetas dejan de imponer ancho de pantalla dentro de un contenedor pequeño y la cabecera móvil de la landing dejó de desbordar 18 px a 320 px. Community usa barra inferior compacta bajo 900 px y `NavigationRail` desde 900 px; Home vuelve a la raíz sin duplicarla. Hay pruebas estrictas ES/EN en 320, 600, 900 y 1440 px, más una comprobación visual de la landing entre 320 y 1440 px. |
| PDF Pro | El flujo de Pro genera bytes localmente desde la pantalla, muestra vista previa web nativa y visor móvil. Los 378 IDs de botones PDF se resuelven en `widgetTable`. Favoritos y la exportación de tareas usan el mismo exportador multiplataforma; Tareas usa `pw.MultiPage` para no truncar listas largas y su regresión cubre 180 tareas en 320, 600, 900 y 1440 px. En Linux guarda el PDF en Descargas o Documentos, sin invocar el share sheet no implementado. |
| PDF Community | `Ver PDF` y `Descargar/Imprimir/Compartir PDF` generan una ficha de estudio local con `pdf`, validan su firma `%PDF-`, la muestran con `SfPdfViewer.memory` y la exportan mediante adaptadores condicionales de plataforma. No hacen fetch de la URL heredada. La ficha declara que es local y remite a la lección; no se presenta como el PDF histórico recuperado. |
| Ejecución móvil y AdMob | El Debug del simulador iOS expande el ID oficial de prueba, instala y arranca sin `GADInvalidInitializationException`. Android Debug generó el APK, lo instaló y sobrevivió a un reinicio cálido en API 36.1 sin crash; su manifest fusionado contiene el ID oficial de prueba. Guardias de Xcode y Gradle rechazan Release sin un ID de aplicación real no-test; los IDs de release no están en el checkout. Las capturas de Home muestran un placeholder de imagen, consistente con el bloqueo externo de 176 URLs públicas 404. |
| BFF | El checkout actual pasó `bun run typecheck`, `bun run check:persistence-config` y `bun test` con 138 pruebas. OpenRouter normaliza errores y timeout, IAP falla cerrado fuera de desarrollo y limita solicitudes; aun así, los validadores reales y la autoridad de entitlement no están listos para producción. |
| Rutas BFF | `bash scripts/route-coverage.sh` pasa: `/auth/token`, `/openai/chat` y `/iap/validate` tienen consumidores reales; no hay rutas huérfanas ni llamadas muertas. |

## Validaciones ejecutadas

Los comandos siguientes se ejecutaron durante esta auditoría, salvo cuando se
indica que dependen de un operador o de infraestructura externa.

```bash
cd bff && bun install --frozen-lockfile && bun run typecheck && bun test
cd .. && bash scripts/route-coverage.sh

cd landing
bun run lint
bun run test
bun run build
bun run check:localized-marketing
bun run check:formulae-images

cd ../pro
flutter analyze --no-pub --fatal-infos --fatal-warnings
flutter test --no-pub --reporter compact \
  --dart-define=JWT_SHARED_SECRET=test-shared-secret \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci
JWT_SHARED_SECRET=test-shared-secret ./build_web.sh \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci

cd ../community
flutter analyze --no-pub --fatal-infos --fatal-warnings
FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub \
  --dart-define=JWT_SHARED_SECRET=test-shared-secret \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci
flutter build ios --debug --simulator --no-codesign
xcrun simctl install booted build/ios/iphonesimulator/Runner.app
xcrun simctl launch booted capdesis.formulae
flutter build apk --debug --no-pub
adb install -r build/app/outputs/flutter-apk/app-debug.apk
adb shell am force-stop capdesis.formulae
adb shell am start -W -n capdesis.formulae/.MainActivity
cd .. && RUNS=5 make measure-community-android
```

La landing pasó lint, 64 pruebas, build de 13 páginas, validación de marketing
localizado y validador de 176 assets locales. Pro pasó análisis estricto, 88
pruebas y build web; Tareas y
Favoritos se revisaron en navegador local a 320 y 900 px sin overflow ni
errores de consola. Community pasó 100 pruebas, incluidas las regresiones
estrictas de imagen, PDF local, derivación, ecuaciones de primer grado,
navegación y ciclo de vida del chat. `flutter analyze --no-pub --fatal-infos
--fatal-warnings` terminó con `No issues found!`; CI y Make ya conservan el
gate estricto. El simulador iOS compiló, instaló y lanzó Home sin el crash de
AdMob; Android Debug compiló, se instaló y abrió Home en el AVD API 36.1. Una
compilación Release sin configuración de AdMob falla deliberadamente con la
guardia de configuración.

## Bloqueos externos vigentes

Estos problemas no se pueden resolver editando código sin los archivos o el
acceso del operador. Se conservan aquí para no repetir la investigación.

1. El smoke remoto final `bun run check:formulae-images:remote` se repitió tras
   los gates finales y sigue fallando 176 de 176: las URLs
   `https://formulaeapps.com/imagenes/...` responden 404 `text/html` aunque el
   set local está completo. Hay que promover exactamente
   `landing/public/imagenes/` y las reglas de compatibilidad al hosting
   autorizado, después correr el smoke remoto otra vez.
2. No hay fuente aprobada de los PDFs históricos de Community. Se revisaron 257 IDs activos,
   514 destinos por locale y 438 URLs reales únicas. Se observaron 430 respuestas
   HTTP 404 y fallos de transporte en las restantes, sin un PDF recuperable.
   Tampoco hay PDFs fuente en este checkout. La ficha PDF local ya permite
   ver/exportar contenido útil sin red, pero no se deben inventar ni presentar
   como recuperados los documentos históricos.
3. El overlay explícito `docker-compose.local.yml` permite renderizar la
   configuración local sin el `.env` raíz ni secretos IAP de producción, no se
   aplica automáticamente en un despliegue y expone BFF sólo en loopback. Con
   un BFF nativo temporal en
   `localhost:3001`, `bash scripts/infra-validate.sh --local` pasó el lint y el
   preflight CORS. Falta únicamente la evidencia de contenedor, volumen y backup
   en un daemon Docker/VPS autorizado; los secretos no se agregan al repo.
4. Tras `git fetch origin` durante la revisión, `origin/main` avanzó a
   `c79e866`. El checkout auditado quedó detrás de esos cambios y con trabajo
   local sin commit; no se hizo merge ni rebase. Revalidar sobre el SHA de
   promoción antes de liberar, especialmente porque la comprobación final del
   servidor público devolvió health 200 pero OpenAPI 1.0.0 con sólo cuatro rutas,
   mientras `main` contiene un contrato más reciente.
5. Android e iOS ya se ejecutaron en emuladores. El iPhone físico sigue
   requiriendo desbloqueo y Developer Mode si se necesita esa evidencia extra.
   La medición reproducible de primera UI interactiva en el AVD Android de 1
   core/2 GB fue mediana 2711 ms y p95 6143 ms en cinco corridas; el antiguo
   `Fully drawn +19s31ms` no mide solo la app antes de que el menú sea útil. El
   primer boot produjo un ANR de System UI, no de Community. Para publicar con
   anuncios, CI también debe inyectar IDs AdMob reales no-test aprobados; el
   Release se rechaza intencionalmente si faltan.
6. IAP no está listo para producción: sin credenciales de Apple/Google el
   snapshot inicial podía anunciar disponibilidad y devolver una respuesta de
   stub. La corrección local está en `FML-115`; las compras sandbox, secretos y
   validadores reales requieren configuración autorizada fuera de Git.
7. Los rulesets actuales de GitHub no exigen checks verdes para `main`; se
   observaron merges con `JWT light preflight` fallido. Requerir checks, review,
   permisos mínimos y un entorno de producción es trabajo de administración
   externa registrado en `FML-116`.

## Decisiones de producto pendientes

- El flujo PDF local de Community ya está implementado. Producto debe decidir
  si la ficha local basta o si necesita restaurar el contenido histórico exacto
  desde una fuente aprobada; no debe confundirse esa decisión de contenido con
  la funcionalidad actual de ver/exportar.
- Los prompts FAQ ya deben pedir pictogramas universales, nunca mockups con
  texto o capturas dependientes del idioma. Las oportunidades prioritarias que
  aún no deben generarse sin revisar la pantalla consumidora son: secante y
  tangente para derivación, área bajo curva para integración, distribución
  normal, multiplicación de matrices y armónicos de Fourier.
- La suite amplia de Community ya no suprime errores con `FlutterError.onError`,
  drains de `takeException`, `warnIfMissed:false` ni `catch` vacíos. El fake de
  WebView está limitado a la prueba de mapeo de rutas; las excepciones de
  widgets siguen siendo aserciones de prueba.

## Checklist para una promoción autorizada

1. Construir la landing con el lockfile y promover el directorio `dist/` más
   `public/imagenes/` mediante el procedimiento FTPS protegido.
2. Confirmar HTTP 200, MIME y decodificación con
   `cd landing && bun run check:formulae-images:remote`.
3. Si producto requiere los documentos históricos exactos, restaurarlos desde
   una fuente aprobada y publicar un manifiesto verificable. La funcionalidad
   actual de ver/exportar la ficha local no depende de ese paso.
4. Con un daemon Docker autorizado, repetir la validación usando el contenedor
   BFF y verificar recreate, permisos y backup del volumen sin agregar secretos
   al repositorio.
5. Inyectar por CI los IDs AdMob reales no-test aprobados para una publicación
   con anuncios y validar Android/dispositivo físico; no usar los IDs de prueba
   de Debug/Profile en Release.
6. Ejecutar los quality gates del SHA exacto que se vaya a promover y confirmar
   que GitHub exige resultados verdes. No basar un release en este informe si
   el SHA ya cambió.

## Documentación relacionada

- `README.md`: arquitectura, límites y comandos de desarrollo actuales.
- `docs/TICKETS.md`: estado operativo, prioridades, evidencia y próximos pasos.
- `landing/README.md` y `landing/public/imagenes/README.md`: pipeline y smoke
  de assets.
- `docs/DEPLOY_CI_WEB.md`: controles de promoción manual.
- `pro/docs/CATALOGO_PROMPTS_IMAGENES.md`: contrato de creación de nuevos
  diagramas sin idioma.
