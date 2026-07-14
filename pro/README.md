# Formulae Pro

Formulae Pro es la edición sin anuncios de Formulae. Está construida con
Flutter y Dart 3 para móvil y escritorio, y cuenta con una compilación web.

## Capacidades verificadas

- Fórmulas, calculadoras, vídeos y diagramas pedagógicos.
- Imágenes canónicas compartidas entre idiomas. El texto explicativo se
  localiza fuera del bitmap.
- Todas las cargas remotas de diagramas y marca usan fallback localizado,
  timeout y tamaño compacto seguro; un 404 no deja spinner ni hueco silencioso.
- Favoritos, carpetas y tareas con generación local de PDF a partir del
  contenido de la pantalla.
- Vista previa nativa en web y visor de bytes PDF en móvil.
- Exportación de favoritos y tareas en web mediante descarga del navegador. En
  Linux, el PDF se guarda en Descargas o Documentos para evitar el share sheet
  no implementado.
- El PDF de Tareas usa páginas múltiples y tiene regresión cubierta con 180
  tareas en 320, 600, 900 y 1440 px.
- La ayuda para cancelar suscripción se localiza por tienda en móvil y usa la
  página de soporte Formulae en web/escritorio, sin URLs sin inicializar.

El resultado de compartir puede depender de la plataforma y de que el usuario
complete el share sheet. No se debe confundir ese resultado con la generación
correcta de los bytes del PDF.

## Preparación y validación

```bash
cd packages/formulaeapps_bff_client && flutter pub get
cd ../..
flutter pub get

flutter analyze --no-pub --fatal-infos --fatal-warnings
FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --reporter compact \
  --dart-define=JWT_SHARED_SECRET=test-shared-secret \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci
JWT_SHARED_SECRET=test-shared-secret ./build_web.sh \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci
```

Para inspeccionar los diagramas desde una landing local, sin modificar las
URLs canónicas que usa release:

```bash
flutter run -d chrome -t lib/main_pro.dart \
  --dart-define=FORMULAE_IMAGE_ORIGIN=http://127.0.0.1:4321
```

## Estado de hosting

El código y los assets locales se validan por separado del hosting. En la
auditoría del 2026-07-13 las 176 URLs públicas de imágenes devolvían 404, por
lo que se requiere una promoción manual autorizada de la landing antes de
considerar los diagramas remotos disponibles en producción. Ver
[la auditoría funcional](../docs/AUDITORIA_FUNCIONAL_2026-07-13.md) y
[el tablero de tickets activo](../docs/TICKETS.md).
