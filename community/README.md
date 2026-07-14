# Formulae Community

Formulae Community es la edición con anuncios del catálogo educativo de
Formulae. Usa Flutter y Dart 3, con soporte de interfaz en español e inglés.

## Capacidades verificadas

- Catálogo de fórmulas, calculadoras, vídeos y diagramas científicos.
- URLs canónicas de imágenes compartidas con Pro, sin una variante bitmap por
  idioma.
- Fallback localizado, con cache y timeout, para todas las imágenes remotas
  consumidas por Community.
- Generación, visualización y exportación de una ficha de estudio PDF local,
  sin solicitar el PDF heredado a la red.
- Navegación, favoritos, tareas y chat, sujetos a su configuración de runtime.

Los PDFs heredados no están actualmente disponibles en el host. La ficha local
indica explícitamente que fue generada por Community y remite a la lección
dentro de la app; no se presenta como una copia recuperada del documento
histórico. Restaurar el contenido exacto sigue requiriendo una fuente aprobada.
Consulta [la auditoría funcional](../docs/AUDITORIA_FUNCIONAL_2026-07-13.md).

## Preparación

```bash
cd packages/formulaeapps_bff_client && flutter pub get
cd ../..
flutter pub get
```

Para revisar diagramas contra una landing local sin cambiar las URLs de
producción:

```bash
flutter run \
  --dart-define=FORMULAE_IMAGE_ORIGIN=http://127.0.0.1:4321
```

## Validación

```bash
flutter analyze --no-pub --fatal-infos --fatal-warnings
FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --reporter compact \
  --dart-define=JWT_SHARED_SECRET=test-shared-secret \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci

# Regresiones de esta auditoría
FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub \
  --dart-define=JWT_SHARED_SECRET=test-shared-secret \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci \
  test/responsive_derivacion_basica_test.dart \
  test/zoom_image_personalizado_test.dart \
  test/formula_render_overflow_test.dart \
  test/community_pdf_document_test.dart \
  test/ver_pdf_local_action_test.dart \
  test/navigation_shell_test.dart \
  test/chat_screen_lifecycle_test.dart
```

La CI hace fatales los `info`; el análisis estricto de 2026-07-13 terminó sin
diagnósticos. Mantén ese gate al modificar pantallas o widgets del catálogo.

## Límites de plataforma

Este checkout no contiene un target Flutter Web de Community; no se declara
esa plataforma como soporte de la app. En Android e iOS el visor recibe los
bytes del PDF local y la exportación usa el manejador de la plataforma. La
evidencia adicional de dispositivos físicos sigue registrada en el tablero
antes de publicar una tienda. Para repetir la medición de primer contenido
interactivo Android en un emulador o dispositivo conectado, ejecuta desde la
raíz `RUNS=5 make measure-community-android`.

## Anuncios en Release

Debug y Profile usan únicamente los IDs oficiales de prueba. Un Release exige
un ID de aplicación AdMob real no-test desde la configuración protegida de
Xcode/Gradle; además, los anuncios quedan desactivados hasta recibir
`ADMOB_ENABLED=true` y las seis unidades reales válidas por `dart-define`.
No se guardan IDs de producción ni archivos `AdMob.xcconfig` en Git. El build
falla explícitamente si se intenta empaquetar Release sin el ID de aplicación
aprobado.
