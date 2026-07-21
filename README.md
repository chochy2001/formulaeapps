# Formulae Apps

Monorepo de Formulae Pro, Formulae Community, la landing pública y el BFF.
Este archivo describe el checkout; **no** afirma que hosting o tiendas estén
al día.

**Estado vivo (LLMs / agentes):** [`docs/STATUS.md`](docs/STATUS.md) — SHAs,
hecho vs bloqueado, cobertura, validación vía CI.  
Tablero FML-*: [`docs/TICKETS.md`](docs/TICKETS.md).  
Auditoría funcional histórica: [`docs/AUDITORIA_FUNCIONAL_2026-07-13.md`](docs/AUDITORIA_FUNCIONAL_2026-07-13.md) (números pueden estar stale; STATUS gana).

## Componentes

| Directorio | Stack | Propósito |
| --- | --- | --- |
| `landing/` | Astro 7, Tailwind 4, Bun | Sitio estático y origen de los assets canónicos de Formulae. |
| `pro/` | Flutter / Dart 3.12 | Aplicación Pro, sin anuncios, con generación local de PDF y chat. |
| `community/` | Flutter / Dart 3.12 | Copia vendored; Play Store canónico = repo `FormulaeCommunity`. |
| `bff/` | Bun, Hono, Zod OpenAPI | Sesiones, chat y contrato del backend. |
| `contracts/` | OpenAPI 3.1 generado | Contrato derivado de los schemas Zod. |
| `scripts/` | Bash y Bun | Paridad, rutas e infraestructura. |

Pro y Community mantienen `name: formulae` porque son sabores del mismo
producto, pero se construyen y validan por separado.

## Estado (resumen — detalle en STATUS.md)

Verificado en `main` **2026-07-21** (`9facda3`): BFF **186/186**, landing
**64/64**, Pro **215/215** + cobertura cruda **87.18%** (≥85%), Community
monorepo **115/115**, gates de paridad/rutas PASS. Toolchain: Flutter
**3.44.7**, Bun **1.3.14**, Node **24**, Astro **7**; solo `landing/bun.lock`.

**Bloqueado (usuario/externo):** T04 FTPS, issues **#9**/**#13**, FML-101
imágenes 404, FML-129, FML-116, FML-117, T40–T42. IAP sigue fail-closed fuera
de desarrollo.

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
FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --reporter compact \
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
- [Trabajo distribuido y sincronización Git](docs/MULTI_MACHINE_WORKFLOW.md)
- [Candidatos web y promoción segura](docs/DEPLOY_CI_WEB.md)
- [Pipeline de landing](landing/README.md)
- [Contratos BFF](contracts/README.md)
- Constitución compartida del workspace:
  `/Users/jorge/Documents/Apps/.specify/memory/constitution.md`

No se deben editar a mano `contracts/bff.openapi.yaml` ni los clientes Dart en
`pro/packages/formulaeapps_bff_client/` y
`community/packages/formulaeapps_bff_client/`. Cambia Zod, regenera y ejecuta
`bash scripts/verify-parity.sh`.
