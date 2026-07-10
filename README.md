# Formulae Apps

Monorepo oficial de **Formulae Apps** (CAPDESIS). Reúne la landing, las dos apps Flutter del producto (Pro + Community), y el BFF que las une al backend.

## Estructura

```text
formulaeapps/
├── landing/      Astro 5 + Tailwind v4 — sitio público formulaeapps.com
├── pro/          Flutter 3.41 / Dart 3 — Formulae Pro (sin ads, IAP, chat AI)
├── community/    Flutter / Dart 2 — Formulae Community (con AdMob, chat AI)
├── bff/          Bun 1.3 + Hono 4 — Backend-For-Frontend (api.formulaeapps.com)
├── contracts/    OpenAPI 3.1 generado desde Zod en bff/src/schemas/
├── scripts/      verify-parity, route-coverage, infra-validate, generate-bff-types
└── docker-compose.yml + override (dev/prod)
```

| Componente | Stack | Despliegue | Estado |
| ---------- | ----- | ---------- | ------ |
| `landing/` | Astro 5.7 + Tailwind 4 | Hostinger (FTP) — `formulaeapps.com`, `www.formulaeapps.com` | ✅ producción |
| `pro/` | Flutter 3.41, Dart 3, http + crypto + shared_preferences | Hostinger (FTP) — `app.formulaeapps.com` (web); App Store + Play (mobile) | ✅ producción |
| `community/` | Flutter, Dart 2 (tech debt) | Play Store + App Store (con ads) | ✅ producción |
| `bff/` | Bun + Hono + Zod-OpenAPI + jose | VPS Contabo — `api.formulaeapps.com` | ✅ producción (tag `v1.0.0-bff`, cutover 2026-05-19) |
| `contracts/` | OpenAPI 3.1 (generated) | n/a — artifact | ✅ |
| `scripts/` | Bash + Bun TS | n/a — dev tooling | ✅ |

> Pro y Community comparten el `name: formulae` en su `pubspec.yaml` porque son dos *flavors* del mismo producto.

## Capacidades actuales (verificadas)

- **Chat AI server-side**: las apps Pro y Community ya NO embeben la OpenAI API key. Llaman al BFF en `api.formulaeapps.com/openai/chat` con un JWT corto firmado por el BFF.
- **JWT emitido por BFF**: el cliente obtiene su JWT vía `POST /auth/token` (no firma su propio JWT). Rotación automática vía `X-Auth-Refresh` header.
- **System prompts BFF-side**: los 22 system prompts viven en `bff/src/schemas/prompts.ts` con versionado semver. Actualizaciones de prompts NO requieren release a App Store.
- **Generación de tipos automática**: cambios en `bff/src/schemas/*.ts` (Zod) regeneran `contracts/bff.openapi.yaml` (vía `bun run build:openapi`) y los clientes Dart en `pro/packages/formulaeapps_bff_client/` + `community/packages/formulaeapps_bff_client/` (vía `bash scripts/generate-bff-types.sh`).
- **CI gates** (`.github/workflows/ci.yml`):
  - `bff-test` — 110/110 tests across 19 files (typecheck + unit + integration).
  - `verify-parity` — falla si Zod, OpenAPI o tipos Dart drifean.
  - `verify-routes` — falla si hay rutas huérfanas o llamadas muertas.
- **Build-time guards** (Pro + Community `main.dart`): release builds con `JWT_SHARED_SECRET` placeholder son rechazados al startup.

## Límites conocidos

- **`/iap/validate` orphan**: la ruta de validación server-side de IAP existe en el BFF pero los clientes todavía no la consumen. Los validadores reales (Apple/Google SDK) están stubbed; producción devuelve 503 si los secrets montados son placeholders. Decisión de producto pendiente: wire-up FE o remover la ruta.
- **Community en Dart 2** sigue siendo deuda técnica. La migración a Dart 3 está fuera del alcance de feature 002.
- **Pro Web rebuild**: si el build en Hostinger aún usa `JWT_SHARED_SECRET=PLACEHOLDER_DEV_NOT_FOR_PROD`, el chat AI fallará hasta un rebuild con secret real apuntando a `api.formulaeapps.com`.

## Próximos pasos

1. **Decisión `/iap/validate`**: wire-up FE + validadores reales, o remover ruta y secrets del compose.
2. **US1 zombie reconciliation**: archivar los working trees `FormulaeApps/{FormulaePro,FormulaeCommunity,formulae-landing,formulaeapps-monorepo}/` que duplican código canónico en este monorepo.
3. **Community test coverage**: ampliar suite iniciada en #17 (`community/test/COVERAGE_TODO.md`).

## Desarrollo local

### Setup inicial

```bash
git clone git@github.com:CAPDESIS/formulaeapps.git
cd formulaeapps

# Landing
cd landing && bun install && cd ..

# Pro
cd pro && flutter pub get && cd ..

# Community
cd community && flutter pub get && cd ..

# BFF
cd bff && bun install && cd ..
```

### Correr el BFF localmente

```bash
# 1. Crear bff/secrets/ placeholders (vacíos OK en dev)
mkdir -p bff/secrets && touch bff/secrets/apple_p8.txt bff/secrets/google_sa.json

# 2. Configurar JWT secret + OpenRouter key
cp bff/.env.example bff/.env
# editar bff/.env: JWT_SHARED_SECRET=$(openssl rand -hex 32), OPENROUTER_API_KEY=sk-or-v1-...

# 3. Levantar
docker compose up -d bff
curl http://localhost:3001/health  # → {"status":"ok",...}
```

### Correr Pro Web contra BFF local

```bash
cd pro
flutter run -d chrome -t lib/main_pro.dart \
  --dart-define=FLAVOR=pro \
  --dart-define=JWT_SHARED_SECRET=$(grep ^JWT_SHARED_SECRET ../bff/.env | cut -d= -f2) \
  --dart-define=FORMULAE_BFF_CHAT_URL=http://localhost:3001/openai/chat \
  --dart-define=FORMULAE_BUILD_NONCE=$(openssl rand -hex 16)
```

### Validar cualquier cambio

```bash
# Todos los gates a la vez (no Flutter):
make verify-all

# Individuales:
bash scripts/verify-parity.sh      # Zod ↔ OpenAPI ↔ Dart drift
bash scripts/route-coverage.sh     # rutas huérfanas / llamadas muertas
bash scripts/infra-validate.sh --local   # compose + CORS + Traefik
cd bff && bun test                 # 110 unit + integration tests (see bff/README.md for current count)
```

## Despliegue

- **Landing**: Hostinger vía FTP. Build: `cd landing && bun run build`. Deploy: lftp script al hosting compartido.
- **Pro Web**: Hostinger vía FTP en subdominio `app.formulaeapps.com`. Build: `flutter build web --release --base-href "/" -t lib/main_pro.dart --dart-define=...`.
- **Pro Mobile**: `flutter build apk --release` / `flutter build ipa --release`. Distribución por App Store + Play.
- **Community**: similar a Pro Mobile.
- **BFF**: VPS Contabo vía `docker compose up -d bff` en `api.formulaeapps.com` (Traefik routers `formulae-bff`). Health check: `curl https://api.formulaeapps.com/health`. Cutover documentado en feature 002 audit (`round-10-production-cutover-2026-05-19`, `round-11-chat-live-2026-05-19`).

## Documentación detallada

- **Constitución del workspace**: `../.specify/memory/constitution.md` (v1.1.0, 9 principios).
- **Feature spec 002** (FE↔BE sync): `specs/002-formulae-fe-be-sync/spec.md` + `plan.md` + `tasks.md`.
- **Auditorías de cada gate**: `specs/002-formulae-fe-be-sync/audit/` (11 archivos cubriendo baseline, BFF tests, codegen, route coverage, infra, US2-narrow, validación final).
- **Arquitectura workspace** (incluyendo histórico): `../FormulaeApps/ARCHITECTURE.md`.

## Notas operativas

- `community/android/app/google-services.json` está commiteado a propósito (config de cliente Firebase, no es secreto). La seguridad real vive en Firebase Security Rules.
- El repo es **privado** en la organización `CAPDESIS`.
- Variables sensibles (`.env`, keystores Android, `apple_p8.txt`, `google_sa.json`) están en `.gitignore`.
- Los directorios `pro/lib/generated/`, `community/lib/generated/`, y `contracts/*.yaml` están marcados `linguist-generated=true` en `.gitattributes` y son regenerados por `bash scripts/generate-bff-types.sh` + `cd bff && bun run build:openapi`. **NO editar a mano.**
