# Formulae Session Status

## 2026-07-21 (health-audit follow-up)

- Community standalone (`FormulaeCommunity`) PR **#29** merged: strict
  `flutter analyze --fatal-infos --fatal-warnings` is clean; `flutter_lints`
  aligned to `^4.0.0`; tests **89/89**. `main` = `b133e55`.
- Monorepo docs refreshed (this file + parent `Formulae/README.md` local map).
- T10–T14 hotspot metas remain **HECHO** (PR #116/#117). Global Pro raw coverage
  after shell/formula behavior tests: **82.60%** (**23 548 / 28 507**), command:
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter compact`
  with `JWT_SHARED_SECRET=test-shared-secret`,
  `FORMULAE_BUILD_NONCE=ci-test-build-nonce`,
  `FORMULAE_APP_VERSION=0.0.0-ci`. Suite **214/214**; analyze 0. Fleet 85% still
  open (~682 lines). Do **not** claim 85% until measured ≥85%.
- T31: bun **1.3.14**, Node **24**, Astro **7** already on `main`. Residual fixed
  this session: removed dual `landing/package-lock.json` (CI uses Bun
  `--frozen-lockfile` only; `landing/bun.lock` remains).
- Worktrees `formulae-pr-hosted` / `formulae-preload-failclosed` removed after
  confirming squash-superseded (PR #118 / #111) and clean trees. No force-push.
- Still **BLOCKED** without user secrets/hostnames: T04 FTPS, VPS #9/#13,
  FML-101 images, FML-129 OpenAI rotation, AdMob/OAuth.

## 2026-07-21

- PRs #98 through #111 merged since 2026-07-17.
- Toolchain upgrades pinned across the repo:
  - Flutter `3.44.7` / Dart `3.12.2`.
  - Astro `7` + Vite `8` + Tailwind `4.3` in `landing/`.
  - BFF on Hono + `@hono/zod-openapi` + TypeScript `7`.
  - CI pinned to Node `24` and Bun `1.3.14`.
- New local baselines (all passing):
  - BFF: **186/186** tests.
  - Pro: **164/164** tests; raw line coverage **81.65%** (**23,270 / 28,499**
    lines).
  - Community (monorepo): **107/107** tests.
  - Landing: **64/64** tests.
  - Contract parity (`scripts/verify-parity.sh`) and route coverage
    (`scripts/route-coverage.sh`) PASS.
- Ported the standalone Community entitlement-cache hardening into
  `monorepo/community/`: `purchase_entitlement_cache.dart` (24h TTL),
  `in_app_purchase_manager.dart` cache integration + SharedPreferences
  persistence, and regression tests.
- Fixed a nullability mismatch in `community/lib/chat_gpt/api_service.dart`
  caused by the regenerated BFF client (`ChatRequestBuilder` typed explicitly).
- Added `build/**` to `analysis_options.yaml` exclusions for Pro and Community
  (and created one for the standalone `community-app`) so local iOS plugin
  artifacts do not break `flutter analyze`.
- This is local branch evidence, not a staging or production claim.

## 2026-07-17

- Pro line coverage: **81.44%** (23,072 / 28,330 lines), measured with:
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter compact`
  plus `--dart-define=JWT_SHARED_SECRET=test-shared-secret`,
  `--dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce`, and
  `--dart-define=FORMULAE_APP_VERSION=0.0.0-ci`.
- PR #96 merged the create-folder dialog controller lifetime fix and five PDF,
  export, navigation, and favorites behavior tests.
- PR #97 merged behavior coverage for multi-page PDF previews, destructive task
  and favorites confirmations, and the no-destination move path.
- This increment adds state-transition tests for task completion/details,
  destructive favorite and folder actions, folder moves, PDF retry behavior,
  and drawer navigation. The 85% fleet target remains unmet; the remaining
  listed hotspots are `tasks_list.dart` (61/193), `ver_pdf.dart` (128/262),
  `drawer_personalizado.dart` (123/231), and `favorites_screen.dart` (247/320).
- The latest increment adds behavior tests for skipping optional task dates,
  locale-specific video URL resolution, and compact navigation between task and
  favorites tabs. It raised raw line coverage by 76 lines (0.27 percentage
  points). The 85% target remains 1,009 covered lines away at the current
  denominator; the highest-return remaining user-flow hotspots are
  `tasks_list.dart`, `drawer_personalizado.dart`, `ver_pdf.dart`, and
  `tasks_screen.dart`.
- The latest measured Pro coverage is **81.60%** (23,125 / 28,330 lines),
  from `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter
  compact` with the three CI Dart defines above. Four behavior tests now cover
  task slide-to-edit, iOS drawer navigation, folder switching/formula-size
  persistence, and disabled empty-folder actions. The edit flow exposed and
  fixed a real dialog lifecycle defect: saving previously attempted to read
  `TaskData` from the dialog route and disposed its text controller before the
  closing frame completed. The 85% target remains **956 lines** away at the
  current denominator; continue with PDF/extraction paths and task reminders.
- The latest increment adds PDF preview/render-size behavior tests and a
  reminder/due-date persistence regression. It fixes reminder state being
  changed in-place without being persisted or notifying the UI, and prevents
  the empty reminder dialog from dereferencing a null selection. Measured
  coverage is **81.70% raw line coverage** (23,134 / 28,331), using
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter
  compact` with `JWT_SHARED_SECRET=test-shared-secret`,
  `FORMULAE_BUILD_NONCE=ci-test-build-nonce`, and
  `FORMULAE_APP_VERSION=0.0.0-ci`; **948 lines** remain to reach 85% at this
  denominator. The full suite passed 151 tests; strict analysis and
  `scripts/verify-parity.sh` passed locally. This is local branch evidence,
  not a staging or production claim.
- The latest coverage increment adds destructive task-delete confirmation,
  empty-reminder dismissal, due-date persistence, and desktop drawer-route
  behavior tests. It also fixes task editing so an already-completed task
  remains completed after its name is changed. Measured raw Pro line coverage
  is **82.09%** (**23,259 / 28,332**), using
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter
  compact` with `JWT_SHARED_SECRET=test-shared-secret`,
  `FORMULAE_BUILD_NONCE=ci-test-build-nonce`, and
  `FORMULAE_APP_VERSION=0.0.0-ci`; **824 lines** remain to reach 85% at this
  denominator. The full suite passed **155 tests**; strict analysis and
  `scripts/verify-parity.sh` passed locally. This is local code-validation
  evidence, not a staging or production claim. Highest-return residual
  hotspots remain PDF generation/preview (`ver_pdf.dart`,
  `favorites_pdf_generator.dart`), chat UI (`chat_screen.dart`), and
  task-list/task-screen flows.
- The latest increment adds behavior coverage for cached subscriptions sending
  chat messages, failed PDF resize recovery, task clear-all confirmation, and
  opening the add-task sheet. It fixes cached valid subscriptions being treated
  as invalid by the send handler and avoids starting a fresh purchase-validation
  future on every chat rebuild. Measured raw Pro line coverage is **82.33%**
  (**23,328 / 28,334**), using
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter
  compact` with `JWT_SHARED_SECRET=test-shared-secret`,
  `FORMULAE_BUILD_NONCE=ci-test-build-nonce`, and
  `FORMULAE_APP_VERSION=0.0.0-ci`; **756 lines** remain to reach 85% at this
  denominator. The full suite passed **160 tests**. This is local
  code-validation evidence, not a staging or production claim. Remaining
  high-return hotspots include PDF generation/preview
  (`favorites_pdf_generator.dart`, `ver_pdf.dart`), chat UI
  (`chat_screen.dart`), and task-list/task-screen flows.
- The latest increment adds behavior tests for disposing chat while an answer is
  pending, multi-page PDF preview rendering, unavailable PDF-size controls, and
  creating a task while skipping both optional dates. It fixes a real chat
  lifecycle defect: completing an in-flight reply after navigation called
  `setState` on a disposed screen. Measured raw Pro line coverage is
  **82.30%** (**23,330 / 28,336**), using
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter
  compact` with `JWT_SHARED_SECRET=test-shared-secret`,
  `FORMULAE_BUILD_NONCE=ci-test-build-nonce`, and
  `FORMULAE_APP_VERSION=0.0.0-ci`. The full suite passed **164 tests**;
  strict analysis and `scripts/verify-parity.sh` passed locally. The target
  remains unmet: **756 lines** are required to reach 85% at this denominator.
  This is local code-validation evidence, not a staging or production claim.
  Residual high-return hotspots remain `ver_pdf.dart` (69.1%, 262 lines),
  `tasks_screen.dart` (73.6%, 148 lines),
  `favorites_pdf_generator.dart` (76.5%, 319 lines),
  `tasks_list.dart` (80.6%, 191 lines), and `chat_screen.dart` (81.0%, 163
  lines).
