# Formulae Community — MASTER_SPEC

> **Historical / non-operational snapshot — 2026-07-13.**
>
> This file is preserved as historical evidence only. It is **not** the current
> source of truth for readiness, builds, tests, entitlements, deployment, or
> outstanding work; claims below must not authorize a release or promotion
> without fresh verification. Use the current sources instead:
>
> - [`community/README.md`](README.md) and the [workspace README](../README.md)
> - [`docs/AUDITORIA_FUNCIONAL_2026-07-13.md`](../docs/AUDITORIA_FUNCIONAL_2026-07-13.md)
> - [`docs/TICKETS.md`](../docs/TICKETS.md)
>
> Source code, manifests, tests, and runtime configuration prevail over this
> archived snapshot.

**Scope**: This document records source-verified evidence for the `community/` sub-app inside `CAPDESIS/formulaeapps`. Every capability, integration boundary, and validation row points to a file path under `~/Code/formulaeapps/community/`, the BFF contract at `~/Code/formulaeapps/contracts/`, or an audit artifact at `~/Documents/Apps/specs/002-formulae-fe-be-sync/audit/`. Markdown-only claims are flagged as `unresolved` if not traceable.

## Executive Summary

Formulae Community is the free, ad-supported Flutter app (Android + iOS) of the Formulae family — same math-formulae study core as Pro, but with `google_mobile_ads` integration in place of paid features. As of feature 002 (FE↔BE sync), the chat-AI client has been refactored away from a direct OpenAI integration and now calls the FormulaeApps BFF (`POST /openai/chat`) with a BFF-issued session JWT obtained at app startup (`POST /auth/token`). No OpenAI API key is shipped in the client. All client-side wire types are generated from `~/Code/formulaeapps/contracts/bff.openapi.yaml` into `lib/generated/bff/` (27 generator-emitted Dart files, treated as immutable by `.gitattributes linguist-generated=true`).

Client readiness: **Partial — refactor wired, release validation pending Flutter SDK**. The chat path is grep-verified to contain zero `api.openai.com` references. Full `flutter analyze` / `flutter test` / release builds (android/ios) are tracked in feature 002 tasks T095-T097 and remain pending pubspec dep additions (T087) + `flutter pub get` (T088).

## Current Capabilities

### Detected stacks

- Flutter (Dart 3.0+ per `pubspec.yaml:8-9` — same SDK constraint as Pro)
- Android (Kotlin + Gradle per `android/app/build.gradle`)
- iOS (Swift + Xcode project per `ios/Runner.xcodeproj/`)
- `google_mobile_ads ^5.3.1` (ad-supported tier vs Pro's clean UX)

### Manifest evidence

- `community/pubspec.yaml` (app version `2.2.9+74`, Flutter SDK ≥ 3.0.0 < 4.0.0)
- `community/android/app/build.gradle`, `community/android/build.gradle`, `community/android/settings.gradle`
- `community/ios/Runner.xcodeproj/project.pbxproj`

### Source roots

- `lib/` — application source (chat client, providers, screens, l10n)
- `lib/chat_gpt/` — BFF chat client (refactored under feature 002, see Integration Boundaries below)
- `lib/generated/bff/` — **generated** Dart wire types from `contracts/bff.openapi.yaml` (27 files, `DO NOT EDIT`)
- `lib/l10n/` — Flutter intl localizations
- `test/` — **empty** (no unit tests in canonical clone as of 2026-05-19)

### Platform targets

2 platforms: android, ios. (No web/macos/linux/windows surfaces vs Pro's 6.)

## Architecture and Source Map

- Repository: `CAPDESIS/formulaeapps` (canonical monorepo)
- Working tree: `~/Code/formulaeapps/community/`
- Git remote: `git@github.com:CAPDESIS/formulaeapps.git`
- Sibling apps: `pro/` (Flutter, paid), `landing/` (Astro), `bff/` (Bun/Hono BFF) — see workspace `ARCHITECTURE.md`
- Feature audit: `specs/002-formulae-fe-be-sync/`

## Key Workflows

- Local development: `cd community && flutter run -d <device> --dart-define=JWT_SHARED_SECRET=<hex32> --dart-define=FORMULAE_BFF_CHAT_URL=http://localhost:3000`
- Codegen refresh: `cd .. && bash scripts/generate-bff-types.sh`
- Parity check (CI gate): `cd .. && bash scripts/verify-parity.sh`
- Release build (Android): `flutter build apk --release --dart-define=JWT_SHARED_SECRET=<real> --dart-define=FORMULAE_BFF_CHAT_URL=https://api.formulaeapps.com --dart-define=FORMULAE_BUILD_NONCE=<hex32>`

## Integration Boundaries

### BFF (api.formulaeapps.com)

| Route | Method | Client file | Evidence |
|-------|--------|-------------|----------|
| `/auth/token` | POST | `lib/chat_gpt/auth_service.dart` | Mints session JWT; HMAC-SHA256 `client_proof`. Community variant uses `defaultTargetPlatform` heuristic + `FORMULAE_PLATFORM_OVERRIDE` dart-define (no `universal_io`/`universal_platform` deps to keep the package surface minimal). Evidence: `audit/us2-narrow-2026-05-18.md § Community`. |
| `/openai/chat` | POST | `lib/chat_gpt/api_service.dart` | Sends `{ message, model_id }`; same shape as Pro. Bearer auth via `AuthService.getToken()`. Adopts rotated tokens from `X-Auth-Refresh`. |
| `/iap/validate` | POST | _not consumed (Community is ad-supported, no IAP)_ | Documented intentional orphan in `audit/route-coverage-post.md`. |
| `/health` | GET | _infrastructure (Docker healthcheck)_ | Exempt per `data-model.md § E12`. |

### Client constants

- `lib/chat_gpt/api_consts.dart` — `--dart-define` driven, no hardcoded secrets. Same env-var names as Pro: `FORMULAE_BFF_BASE_URL`, `FORMULAE_BFF_CHAT_URL`, `JWT_SHARED_SECRET`, `FORMULAE_BUILD_NONCE`, `FORMULAE_APP_VERSION`.

### Release-mode placeholder guard

`lib/main.dart` top-of-`main()` placeholder guard rejects insecure JWT secrets in `--release` mode — spec FR-006. Evidence in `audit/us2-narrow-2026-05-18.md § T094`. (Variant: Community doesn't use Pro's flavor-`bootstrap()` pattern.)

## Data, Storage, and Deployment

### Local storage

- SharedPreferences (`shared_preferences ^2.2.0`) — stores BFF `client_id` and user prefs.
- **No persistent BFF session tokens** (in-memory only).
- **No SQLite favorites** (this is a Pro-only feature).

### Deployment

- Android: Play Store / direct APK (`flutter build apk --release`).
- iOS: App Store via `flutter build ipa --release`.
- No web/desktop targets.

## Validation Evidence

| scope | command | status | reason | next_action |
|-------|---------|--------|--------|-------------|
| docs | `manual-review` | pass | This file traces every claim to source. | none |
| flutter | `flutter pub get` | skipped | T088 pending — depends on T087 pubspec deps. | Run during US2 full per `specs/002-formulae-fe-be-sync/tasks.md`. |
| flutter | `flutter analyze --no-pub --fatal-infos --fatal-warnings` | skipped | T095 pending. Known-debt baseline (if any) acknowledged on first run. | Run during US2 full. |
| flutter | `flutter test` | skipped | T096 pending. **No tests in `test/` yet** — running the command will succeed with `No tests ran`. Future: add at least one widget test for the chat screen. | Run during US2 full + add test coverage. |
| flutter-android | `flutter build apk --release` | skipped | T097 pending. | Run during US2 full. |
| flutter-ios | `flutter build ipa --release --no-codesign` | skipped | T097 pending. | Run during US2 full. |
| codegen | `bash ../scripts/verify-parity.sh` | **pass** | Generated `lib/generated/bff/` matches `contracts/bff.openapi.yaml`; drift gated by CI. | Wired in `.github/workflows/ci.yml`. |
| chat-grep | `grep -rn "api.openai.com" lib/` | **pass** | Zero matches per spec FR-004; verified `audit/us2-narrow-2026-05-18.md § T100`. | Re-run on any chat-client edit. |

## Documentation Drift Findings

### Resolved by feature 002

- Old `lib/chat_gpt/jwt_service.dart` deleted; replaced by `lib/chat_gpt/auth_service.dart` (BFF-issued JWT).
- Old `lib/chat_gpt/api_service.dart` direct-OpenAI client rewritten to call the BFF; prompts moved server-side per FR-019.

### US2 closeout (post-R13 2026-05-19)

- `lib/chat_gpt/chat_model.dart` and `lib/chat_gpt/models_model.dart` were **deleted in R13** (T089 done). Types inlined into `lib/chat_gpt/api_service.dart`, mirror of Pro T074/T075. Same consumers reach them through `export_chat_gpt.dart`'s re-export chain. Commit `e5a4bdd`. flutter analyze green (2998 infos unchanged from R12 baseline, 0 errors / 0 warnings); flutter test not runnable (no `test/` directory, acceptable per T096).
- `pubspec.yaml` consumes the path-dep `packages/formulaeapps_bff_client` (T109 landed).
- Empty `test/` directory remains; chat-flow coverage lives at the BFF integration-test layer (`bff/tests/integration/chat-flow.test.ts`). Adding Community-side `AuthService` HMAC tests is an optional follow-up.

## Known Limits and Risks

- Release builds untested in this session (Flutter SDK not invoked).
- Dart-2 compatibility footprint: per research §R3, Community was originally on older Dart. Current `pubspec.yaml:8-9` declares Dart 3.0+, so the compatibility risk is *probably* moot — but `flutter analyze` against the refactored code is the only way to confirm no pre-existing analyzer warnings broke.
- `lib/generated/bff/` consumption identical to Pro — `package:formulaeapps_bff_client/...` imports require T087 pubspec changes before they resolve.
- Ad-supported tier means `google_mobile_ads ^5.3.1` is on the build path; release builds may emit warnings around ad-unit IDs (verify on first analyze run).
- No tests means a chat-flow regression won't be caught by this app's `flutter test`.

## Client Readiness

Readiness label: **Partial — refactor verified by code review and grep, runtime validation pending**.

Suitable for:

- Internal demos against a local BFF (`docker compose up -d bff` then `flutter run --dart-define=FORMULAE_BFF_CHAT_URL=http://localhost:3000`).

Not yet suitable for:

- Production claim about chat reliability (no perf test against `api.formulaeapps.com` yet).
- Play Store release (T097 release build untested).

## Next Steps

1. **Unblock US2 full**: install Flutter SDK locally, run `cd ~/Code/formulaeapps/community && flutter pub get && flutter analyze && flutter test`.
2. **Add codegen path dep**: T087 — analogous to Pro's T072.
3. **Wire generated `ChatApi`**: T109 — analogous to Pro's T108.
4. **Add baseline test coverage**: optional follow-up — at least one widget test for the chat screen + a unit test for `AuthService._clientProof()` (the HMAC helper).

## Superseded or Historical Documentation

Markdown files reviewed for ownership and drift:

- `community/README.md` (kept — minimal user-facing description; could be expanded but out of scope here)
- (zombie clone) `~/Documents/Apps/FormulaeApps/FormulaeCommunity/README.md` — pending T013 disposition; tracked in `audit/working-trees-2026-05-18.md`.

## Cross-references

- Feature 002 spec: [`../specs/002-formulae-fe-be-sync/spec.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/spec.md)
- US2 narrow audit: [`../specs/002-formulae-fe-be-sync/audit/us2-narrow-2026-05-18.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/audit/us2-narrow-2026-05-18.md)
- Codegen pipeline audit: [`../specs/002-formulae-fe-be-sync/audit/codegen-pipeline-verified.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/audit/codegen-pipeline-verified.md)
- Route-coverage post-refactor: [`../specs/002-formulae-fe-be-sync/audit/route-coverage-post.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/audit/route-coverage-post.md)
- Workspace MASTER_SPEC: [`../../../Documents/Apps/FormulaeApps/MASTER_SPEC.md`](../../../Documents/Apps/FormulaeApps/MASTER_SPEC.md)
- Sibling app: [`../pro/MASTER_SPEC.md`](../pro/MASTER_SPEC.md)
