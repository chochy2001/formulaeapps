# Formulae Apps

Monorepo de Formulae Pro, Formulae Community, la landing pública y el BFF.
Este archivo describe el estado del checkout, no una declaración de que el
hosting o las tiendas están actualizados. El informe verificable más reciente
es [docs/AUDITORIA_FUNCIONAL_2026-07-13.md](docs/AUDITORIA_FUNCIONAL_2026-07-13.md).

## Componentes

| Directorio | Stack | Propósito |
| --- | --- | --- |
| `landing/` | Astro 6.4, Tailwind 4, Bun | Sitio estático y origen de los assets canónicos de Formulae. |
| `pro/` | Flutter y Dart 3 | Aplicación Pro, sin anuncios, con generación local de PDF y chat. |
| `community/` | Flutter y Dart 3 | Aplicación Community con anuncios y catálogo educativo. |
| `bff/` | Bun, Hono, Zod OpenAPI | Sesiones, chat y contrato del backend. |
| `contracts/` | OpenAPI 3.1 generado | Contrato derivado de los schemas Zod. |
| `scripts/` | Bash y Bun | Paridad, rutas e infraestructura. |

Pro y Community mantienen `name: formulae` porque son sabores del mismo
producto, pero se construyen y validan por separado.

## Estado auditado

- BFF local: `bun run typecheck` y `bun test` pasaron el 2026-07-13, con 138
  pruebas. IAP responde `503 E_IAP_VALIDATION_UNAVAILABLE` fuera de desarrollo
  mientras no haya validadores Apple/Google reales; no es un entitlement listo
  para producción.
- Cobertura de rutas: `bash scripts/route-coverage.sh` pasa; el consumidor Pro
  de `/iap/validate` es opt-in y está apagado por defecto. No equivale a un
  entitlement de compras listo para producción.
- Imágenes: existen 176 assets canónicos locales, compartidos por todos los
  idiomas de Pro y Community. El host público todavía responde 404 a 176 de
  176 rutas, por lo que hace falta una promoción autorizada antes de afirmar
  que esos diagramas funcionan en producción.
- PDF: Pro genera y exporta contenido local, incluidos Favoritos y Tareas.
  Community genera, visualiza y exporta una ficha de estudio local sin pedir
  los PDFs heredados al host. Esa ficha no pretende ser una recuperación del
  contenido histórico; restaurar ese material exacto requiere una fuente
  aprobada.
- Community: las cargas de imagen remotas tienen fallback localizado. Sus
  controles revisados se localizan, el contraste de navegación es AA y la
  cancelación de suscripción no inicializa URLs inválidas. El análisis estricto
  terminó sin diagnósticos y la suite local pasó 100 pruebas; el host público de
  las imágenes sigue bloqueado aparte por sus 176 respuestas 404.

## Desarrollo local

```bash
# Landing
cd landing && bun install --frozen-lockfile

# BFF
cd ../bff && bun install --frozen-lockfile

# Apps Flutter, primero el cliente generado de cada una
cd ../pro/packages/formulaeapps_bff_client && flutter pub get
cd ../.. && flutter pub get

cd ../community/packages/formulaeapps_bff_client && flutter pub get
cd ../.. && flutter pub get
```

Los secretos pertenecen al entorno del operador. Nunca crear ni commitear un
`.env`, material de firma, tokens o archivos de secretos para hacer pasar una
validación local.

## Validaciones principales

```bash
# BFF y contratos
cd bff && bun run typecheck && bun test
cd .. && bash scripts/route-coverage.sh
bash scripts/verify-parity.sh

# Landing y assets locales
cd landing
bun run lint
bun run test
bun run build
bun run check:localized-marketing
bun run check:formulae-images

# Pro
cd ../pro
flutter analyze --no-pub --fatal-infos --fatal-warnings
flutter test --no-pub --reporter compact \
  --dart-define=JWT_SHARED_SECRET=test-shared-secret \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci

# Community, con los mismos dart-defines de prueba y ejecución serial local
cd ../community
flutter analyze --no-pub --fatal-infos --fatal-warnings
FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --reporter compact \
  --dart-define=JWT_SHARED_SECRET=test-shared-secret \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci
```

Desde la raíz, `make flutter-test` ejecuta las dos suites Flutter y los
clientes BFF con los `dart-defines` de prueba no secretos.

`make verify-all` incluye typecheck BFF, lint de landing, el validador de
marketing localizado, Flutter, Compose y los demás gates. El lint de Compose
funciona en un checkout limpio mediante `docker-compose.local.yml` explícito y no requiere un
daemon Docker. Para probar activamente CORS, inicia un BFF local en el puerto
3001; si no está disponible, el validador lo registra como evidencia omitida,
no como una falla de código. Usa las validaciones individuales anteriores para
separar fallas de código de requisitos de runtime.

Para una demo local de chat, usa `make compose-up` (se enlaza sólo a
`127.0.0.1:3001`) y proporciona ambos defines a Pro o Community:
`FORMULAE_BFF_BASE_URL=http://localhost:3001` y
`FORMULAE_BFF_CHAT_URL=http://localhost:3001/openai/chat`. El secreto de firma
JWT del BFF debe ser un valor independiente generado por el operador; no hay
uno versionado ni un `.env` local implícito para Docker.

## Contrato de imágenes

Las apps solo declaran rutas `https://formulaeapps.com/imagenes/...`. Un único
asset sirve todos los idiomas; dentro del bitmap solo van símbolos, notación y
geometría universales. El texto explicativo debe vivir en los ARB y widgets.

```bash
cd landing
bun run check:formulae-images
# Solo después de una promoción manual autorizada:
bun run check:formulae-images:remote
```

No agregar `check:formulae-images:remote` como gate local o de CI: verifica el
hosting publicado y debe ejecutarse como smoke posterior a la promoción.

## Fuentes de verdad

- [Auditoría funcional actual](docs/AUDITORIA_FUNCIONAL_2026-07-13.md)
- [Tablero de tickets activo](docs/TICKETS.md)
- [Pipeline de landing](landing/README.md)
- [Contratos BFF](contracts/README.md)
- Constitución compartida del workspace:
  `/Users/jorge/Documents/Apps/.specify/memory/constitution.md`

No se deben editar a mano `contracts/bff.openapi.yaml` ni los clientes Dart en
`pro/packages/formulaeapps_bff_client/` y
`community/packages/formulaeapps_bff_client/`. Cambia Zod, regenera y ejecuta
`bash scripts/verify-parity.sh`.
