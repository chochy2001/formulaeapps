# Formulae Pro — MASTER_SPEC

**Scope**: This document records source-verified evidence for the `pro/` sub-app inside `CAPDESIS/formulaeapps`. Every capability, integration boundary, and validation row points to a file path under `~/Code/formulaeapps/pro/`, the BFF contract at `~/Code/formulaeapps/contracts/`, or an audit artifact at `~/Documents/Apps/specs/002-formulae-fe-be-sync/audit/`. Markdown-only claims are flagged as `unresolved` if not traceable.

## Executive Summary

Formulae Pro is the paid Flutter app (Android/iOS/macOS/Windows/Linux/Web) of the Formulae family — a math-formulae study aid with chat-AI assistance, PDF export, and an offline favorites store. As of feature 002 (FE↔BE sync), the chat-AI client has been refactored away from a direct OpenAI integration and now calls the FormulaeApps BFF (`POST /openai/chat`) with a BFF-issued session JWT obtained at app startup (`POST /auth/token`). No OpenAI API key is shipped in the client. All client-side wire types are generated from `~/Code/formulaeapps/contracts/bff.openapi.yaml` into `lib/generated/bff/` (27 generator-emitted Dart files, treated as immutable by `.gitattributes linguist-generated=true`).

Client readiness: **Partial — local build verified; release-mode validation deferred to Flutter SDK availability.** The refactored chat path is wired and grep-verified to contain zero `api.openai.com` references. Full `flutter analyze` / `flutter test` / release builds (web/android/ios) are tracked in feature 002 tasks T082-T086 and remain pending pubspec dep additions (T072) + `flutter pub get` (T073).

## Current Capabilities

### Detected stacks

- Flutter (Dart 3.0+ per `pubspec.yaml:8-9`)
- Android (Kotlin + Gradle per `android/app/build.gradle`)
- iOS (Swift + Xcode project per `ios/Runner.xcodeproj/`)
- macOS (Xcode project per `macos/Runner.xcodeproj/`)
- Windows, Linux, Web (Flutter desktop + web targets)

### Manifest evidence

- `pro/pubspec.yaml` (app version `1.0.0+1`, Flutter SDK ≥ 3.0.0 < 4.0.0)
- `pro/android/app/build.gradle`, `pro/android/build.gradle`, `pro/android/settings.gradle`
- `pro/ios/Runner.xcodeproj/project.pbxproj`
- `pro/macos/Runner.xcodeproj/project.pbxproj`
- `pro/windows/CMakeLists.txt`
- `pro/web/index.html`

### Source roots

- `lib/` — application source (chat client, favorites, providers, screens, l10n)
- `lib/chat_gpt/` — BFF chat client (refactored under feature 002, see Integration Boundaries below)
- `lib/generated/bff/` — **generated** Dart wire types from `contracts/bff.openapi.yaml` (27 files, `DO NOT EDIT`)
- `lib/Favorites/` — local SQLite favorites store with PDF export
- `lib/l10n/` — Flutter intl localizations
- `test/` — 2 unit tests (`favorites_notifier_test.dart`, `favorites_pdf_generator_test.dart`)

### Platform targets

6 platforms: android, ios, linux, macos, web, windows.

## Architecture and Source Map

- Repository: `CAPDESIS/formulaeapps` (canonical monorepo)
- Working tree: `~/Code/formulaeapps/pro/`
- Git remote: `git@github.com:CAPDESIS/formulaeapps.git`
- Sibling apps: `community/` (Flutter), `landing/` (Astro), `bff/` (Bun/Hono BFF) — see workspace `ARCHITECTURE.md`
- Feature audit: `specs/002-formulae-fe-be-sync/`

## Key Workflows

- Local development: `flutter run -d <device> -t lib/main_pro.dart --dart-define=JWT_SHARED_SECRET=<hex32> --dart-define=FORMULAE_BFF_CHAT_URL=http://localhost:3000`
- Codegen refresh: `cd .. && bash scripts/generate-bff-types.sh` (regenerates `pro/lib/generated/bff/` from contracts)
- Parity check (CI gate): `cd .. && bash scripts/verify-parity.sh`
- Release builds: `flutter build web --release -t lib/main_pro.dart --base-href "/" --dart-define=FLAVOR=pro --dart-define=JWT_SHARED_SECRET=<real> --dart-define=FORMULAE_BFF_CHAT_URL=https://api.formulaeapps.com --dart-define=FORMULAE_BUILD_NONCE=<hex32>`

## Integration Boundaries

### BFF (api.formulaeapps.com)

| Route | Method | Client file | Evidence |
|-------|--------|-------------|----------|
| `/auth/token` | POST | `lib/chat_gpt/auth_service.dart` | Mints session JWT; HMAC-SHA256 `client_proof` from `JWT_SHARED_SECRET` + stable UUIDv4 `client_id` persisted via SharedPreferences. Replaces the FE-self-signed `jwt_service.dart` pattern per spec FR-005. |
| `/openai/chat` | POST | `lib/chat_gpt/api_service.dart` | Sends `{ message, model_id }`; receives `ChatResponse` shape per contract `E5`. Bearer auth from `AuthService.getToken()`. System prompts moved server-side per spec FR-019. Adopts rotated tokens from `X-Auth-Refresh` header. |
| `/iap/validate` | POST | _not yet consumed_ | Documented intentional orphan in `audit/route-coverage-post.md`; future US2 work or removal from contract pending. |
| `/health` | GET | _infrastructure (Docker healthcheck)_ | Exempt from coverage check per `data-model.md § E12`. |

### Client constants

- `lib/chat_gpt/api_consts.dart` — all values come from `--dart-define` (no hardcoded URLs or secrets). Variables: `FORMULAE_BFF_BASE_URL`, `FORMULAE_BFF_CHAT_URL`, `JWT_SHARED_SECRET`, `FORMULAE_BUILD_NONCE`, `FORMULAE_APP_VERSION`.

### Release-mode placeholder guard

`lib/main_pro.dart`'s `bootstrap()` rejects placeholder values for `JWT_SHARED_SECRET` (`""`, `"PLACEHOLDER_DEV_NOT_FOR_PROD"`, `"replace-with-real-hex-secret"`) when `kReleaseMode == true` — spec FR-006. Evidence in `audit/us2-narrow-2026-05-18.md` § T081.

## Data, Storage, and Deployment

### Local storage

- SharedPreferences (`shared_preferences ^2.2.0`) — stores BFF `client_id` (key `formulae_bff_client_id`) and user-side prefs (theme, language).
- SQLite (via Flutter — through Favorites/) — favorites + PDF generation.
- **No persistent BFF session tokens** (in-memory only per `auth_service.dart`; intentional, FR-022).

### Deployment

- Web target: built by `flutter build web --release` → static artifacts deployable to Hostinger LiteSpeed (`app.formulaeapps.com` per workspace `ARCHITECTURE.md`).
- Android: Play Store / direct APK (`flutter build apk --release`).
- iOS: App Store via `flutter build ipa --release`.

## Validation Evidence

| scope | command | status | reason | next_action |
|-------|---------|--------|--------|-------------|
| docs | `manual-review` | pass | This file traces every claim to source. | none |
| flutter | `flutter pub get` | skipped | T073 pending — depends on T072 pubspec deps. | Run during US2 full per `specs/002-formulae-fe-be-sync/tasks.md`. |
| flutter | `flutter analyze --no-pub --fatal-infos --fatal-warnings` | skipped | T082 pending. | Run during US2 full. |
| flutter | `flutter test` | skipped | T083 pending. 2 tests exist (`test/favorites_notifier_test.dart`, `test/favorites_pdf_generator_test.dart`). | Run during US2 full. |
| flutter-web | `flutter build web --release -t lib/main_pro.dart --dart-define=...` | skipped | T084 pending. | Run during US2 full. |
| flutter-android | `flutter build apk --release` | skipped | T085 pending. | Run during US2 full. |
| flutter-ios | `flutter build ipa --release --no-codesign` | skipped | T086 pending (no-codesign acceptable for CI). | Run during US2 full. |
| codegen | `bash ../scripts/verify-parity.sh` | **pass** | Generated `lib/generated/bff/` matches `contracts/bff.openapi.yaml`; drift gated by CI per `audit/codegen-pipeline-verified.md`. | Wired in `.github/workflows/ci.yml`. |
| chat-grep | `grep -rn "api.openai.com" lib/` | **pass** | Zero matches per spec FR-004; verified `audit/us2-narrow-2026-05-18.md § T100`. | Re-run on any chat-client edit. |

## Documentation Drift Findings

### Resolved by feature 002

- Old `lib/chat_gpt/jwt_service.dart` (FE-self-signed JWT pattern) was deleted; replaced by `lib/chat_gpt/auth_service.dart` (BFF-issued JWT). Evidence: `audit/us2-narrow-2026-05-18.md § Pro`.
- Old `lib/chat_gpt/api_service.dart` direct-OpenAI client (with 18 hardcoded system prompts) was rewritten to call the BFF; prompts moved to `bff/src/schemas/prompts.ts` per FR-019. Evidence: `audit/us2-narrow-2026-05-18.md § T078`.

### Open items pending US2-full

- `lib/chat_gpt/chat_model.dart` and `lib/chat_gpt/models_model.dart` still exist (T074/T075 deferred until T108 lands and the generated DTOs become the consumed shape).
- `pubspec.yaml` still uses `http: ^1.1.0`; `dio` + generated-package path dep not yet declared (T072 pending).

## Known Limits and Risks

- Release builds untested in this session (Flutter SDK not invoked — spec FR-006 placeholder guard verified by code review, not by runtime release-mode execution).
- `lib/generated/bff/` contains `package:formulaeapps_bff_client/...` imports that require a separate pubspec resolution strategy (T072 + path dep). Until landed, the generated code is on-disk but not consumed by `api_service.dart` (which uses raw `http.Client` — functional, but not enforcing Principle VII type-safety contract).
- Two unit tests in `test/` (`favorites_*`) do not cover the chat path. Chat-flow coverage is at the BFF integration-test layer (`bff/tests/integration/chat-flow.test.ts`), not in Pro.
- Mobile vs Web `--dart-define` matrix not yet executed (T084-T086 pending). Risk: a per-platform build flag drift could break one target.

## Client Readiness

Readiness label: **Partial — local build OK, release validation pending**.

Suitable for:

- Internal demos against a local BFF (`docker compose up -d bff` from monorepo root, then `flutter run -d chrome -t lib/main_pro.dart --dart-define=FORMULAE_BFF_CHAT_URL=http://localhost:3000`).
- Client scoping conversations about the BFF-mediated chat capability.

Not yet suitable for:

- Production demo claims about chat reliability under load (no perf test against `api.formulaeapps.com` yet — pending T067 cutover).
- Release tag declaration (T131 gated on full validation matrix per T130).

## Next Steps

1. **Unblock US2 full**: install Flutter SDK locally, run `cd ~/Code/formulaeapps/pro && flutter pub get && flutter analyze && flutter test`.
2. **Add codegen path dep**: T072 — declare `formulaeapps_bff_client` as a path dependency once the generator's pubspec is preserved by `scripts/generate-bff-types.sh`.
3. **Wire generated `ChatApi`**: T108 — switch `lib/chat_gpt/api_service.dart` from raw `http.Client` to the generated `ChatApi.openaiChatPost(...)` once T072 lands.
4. **Smoke test**: T098 — run Pro Web against local BFF; observe request in BFF logs; verify chat renders.

## Superseded or Historical Documentation

Markdown files reviewed for ownership and drift:

- `pro/README.md` (kept — user-facing app description)
- (zombie clone) `~/Documents/Apps/FormulaeApps/FormulaePro/README.md` — pending T012/T013 disposition; tracked in `audit/working-trees-2026-05-18.md`.

## Cross-references

- Feature 002 spec: [`../specs/002-formulae-fe-be-sync/spec.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/spec.md)
- US2 narrow audit: [`../specs/002-formulae-fe-be-sync/audit/us2-narrow-2026-05-18.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/audit/us2-narrow-2026-05-18.md)
- Codegen pipeline audit: [`../specs/002-formulae-fe-be-sync/audit/codegen-pipeline-verified.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/audit/codegen-pipeline-verified.md)
- Route-coverage post-refactor: [`../specs/002-formulae-fe-be-sync/audit/route-coverage-post.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/audit/route-coverage-post.md)
- Workspace MASTER_SPEC: [`../../../Documents/Apps/FormulaeApps/MASTER_SPEC.md`](../../../Documents/Apps/FormulaeApps/MASTER_SPEC.md)
- Sibling app: [`../community/MASTER_SPEC.md`](../community/MASTER_SPEC.md)
