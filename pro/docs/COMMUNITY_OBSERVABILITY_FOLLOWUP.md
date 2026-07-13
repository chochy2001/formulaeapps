# Formulae Community observability — deferred follow-up

**Status (2026-07-13):** Formulae **Pro** (`monorepo/pro`) now has CapGym#79-style
env-gated Crashlytics + PostHog bootstrap (`lib/core/observability/observability_bootstrap.dart`).
Flags default **off** (`ENABLE_CRASHLYTICS` / `ENABLE_POSTHOG`); credentials via
`FIREBASE_*` / `POSTHOG_API_KEY` dart-defines only — no hardcoded project IDs.

## Why Community is still open

1. **Standalone Play Store app** (`community-app/`) is a separate git repo and
   does **not** share `monorepo/pro`'s pubspec. It still needs the same deps +
   bootstrap wire (or a shared package extract).
2. **Gradle scaffolding** in Community still has
   `com.google.gms.google-services` declared `apply false` with a stray
   `google-services.json` and no `firebase_core`/`firebase_crashlytics` pubspec
   deps — reconcile before turning Crashlytics on for that binary.
3. **dart-define naming drift** between `community-app/`
   (`BFF_BASE_URL` / `BUILD_NONCE` / `APP_VERSION`) and `monorepo/community/`
   (`FORMULAE_BFF_BASE_URL` / …) should be aligned before relying on one shared
   PostHog `app` property schema across both Community trees.

## Already covered in monorepo/pro

Calling `main_community.dart` → `bootstrap(FormulaeConfig.community)` already
passes `app: formulae-community` into the Pro package's observability
bootstrap. That path is **off by default** until dart-defines are set; it does
**not** activate Crashlytics/PostHog for the standalone `community-app/` binary.

## Suggested next PR

Mirror CapGym#79 / Pro bootstrap into `community-app/` after dart-define
alignment; keep flags default-off until a real Firebase project exists.
