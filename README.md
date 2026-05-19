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
| `pro/` | Flutter 3.41, Dart 3, http + crypto + shared_preferences | Hostinger (FTP) — `app.formulaeapps.com` (web); App Store + Play (mobile) | ✅ producción (chat AI pendiente de BFF deploy) |
| `community/` | Flutter, Dart 2 (tech debt) | Play Store + App Store (con ads) | ✅ producción (chat AI pendiente de BFF deploy) |
| `bff/` | Bun + Hono + Zod-OpenAPI + jose | VPS Contabo — `api.formulaeapps.com` | 🟡 implementado localmente · cutover Cloudflare DNS pendiente |
| `contracts/` | OpenAPI 3.1 (generated) | n/a — artifact | ✅ |
| `scripts/` | Bash + Bun TS | n/a — dev tooling | ✅ |

> Pro y Community comparten el `name: formulae` en su `pubspec.yaml` porque son dos *flavors* del mismo producto.

## Capacidades actuales (verificadas)

- **Chat AI server-side**: las apps Pro y Community ya NO embeben la OpenAI API key. Llaman al BFF en `api.formulaeapps.com/openai/chat` con un JWT corto firmado por el BFF.
- **JWT emitido por BFF**: el cliente obtiene su JWT vía `POST /auth/token` (no firma su propio JWT). Rotación automática vía `X-Auth-Refresh` header.
- **System prompts BFF-side**: los 22 system prompts viven en `bff/src/schemas/prompts.ts` con versionado semver. Actualizaciones de prompts NO requieren release a App Store.
- **Generación de tipos automática**: cambios en `bff/src/schemas/*.ts` (Zod) regeneran `contracts/bff.openapi.yaml` (vía `bun run build:openapi`) y los tipos Dart en `pro/lib/generated/bff/` + `community/lib/generated/bff/` (vía `bash scripts/generate-bff-types.sh`).
- **CI gates** (`.github/workflows/ci.yml`):
  - `bff-test` — 31/31 tests en 63 ms (typecheck + unit + integration).
  - `verify-parity` — falla si Zod, OpenAPI o tipos Dart drifean.
  - `verify-routes` — falla si hay rutas huérfanas o llamadas muertas.
- **Build-time guards** (Pro + Community `main.dart`): release builds con `JWT_SHARED_SECRET` placeholder son rechazados al startup.

## Límites conocidos

- **BFF no deployado todavía** en `api.formulaeapps.com`. El chat AI no funciona en producción real hasta el cutover Cloudflare DNS (feature 002 US6 T060-T068).
- **`/iap/validate` orphan**: la ruta de validación server-side de IAP existe en el BFF pero los clientes todavía no la consumen. Decisión de producto pendiente: o se conecta el flujo FE de IAP, o se elimina la ruta + secrets del compose.
- **Pro `flutter analyze` + `flutter test`** todavía no se han corrido contra el código refactorizado en esta máquina. Wired en CI pero la validación local se difirió a US2-full (deps + build_runner).
- **Community en Dart 2** sigue siendo deuda técnica. La migración a Dart 3 está fuera del alcance de feature 002.
- **Pro Web en producción se compiló con `JWT_SHARED_SECRET=PLACEHOLDER_DEV_NOT_FOR_PROD`** — chat AI roto hasta que se rebuildee con secret real + BFF deployado.

## Próximos pasos

1. **VPS Contabo cutover** (feature 002 US6 T060-T068): provisionar secrets Apple/Google, verificar Traefik middlewares, repuntar DNS `api.formulaeapps.com`. Bloquea el chat AI en producción.
2. **US2 full**: agregar deps (`dio`, `built_value`, `build_runner`) a Pro+Community, generar `.g.dart`, correr `flutter analyze` + `flutter test` + release builds.
3. **US1 zombie reconciliation**: archivar los working trees `FormulaeApps/{FormulaePro,FormulaeCommunity,formulae-landing,formulaeapps-monorepo}/` que duplican código canónico.
4. **Decisión `/iap/validate`**: wire-up o remover.

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

# 2. Configurar JWT secret + OpenAI key
cp bff/.env.example bff/.env
# editar bff/.env: JWT_SHARED_SECRET=$(openssl rand -hex 32), OPENAI_API_KEY=sk-...

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
cd bff && bun test                 # 31 unit + integration tests
```

## Despliegue

- **Landing**: Hostinger vía FTP. Build: `cd landing && bun run build`. Deploy: lftp script al hosting compartido.
- **Pro Web**: Hostinger vía FTP en subdominio `app.formulaeapps.com`. Build: `flutter build web --release --base-href "/" -t lib/main_pro.dart --dart-define=...`.
- **Pro Mobile**: `flutter build apk --release` / `flutter build ipa --release`. Distribución por App Store + Play.
- **Community**: similar a Pro Mobile.
- **BFF**: VPS Contabo vía `docker compose up -d bff`. Cutover Cloudflare DNS `api.formulaeapps.com` → VPS IP. Detalle paso-a-paso en `specs/002-formulae-fe-be-sync/research.md` § R7.

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
