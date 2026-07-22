# Formulae Session Status

> **Canonical live status:** [`docs/STATUS.md`](docs/STATUS.md)  
> This file is an **append-only session log**. Older dated sections are historical
> and may contradict current SHAs/coverage — **STATUS.md wins**.

---

## 2026-07-22 (Markdown audit — tip SHAs + false claims)

- Exhaustive MD audit: tip SHAs → formulaeapps **`0065da7`** (#141 merged),
  FormulaeCommunity **`81b732e`** (#38). Play Store SoT CI **RAW 85.31%** (#37);
  issue **#34** closed. Pro local **87.18%** (#120) unchanged.
- Corrected stale claims that Community coverage was still **3.08%** / #34 open
  (HANDOFF / scattered READMEs). Pending-for-production stays centralized in
  `docs/STATUS.md` (T04, #9/#13, FML-101/116/117/129, T40–T42, staging DNS,
  monorepo runner remasure UNKNOWN).
- Do **not** wait on self-hosted remasure; do **not** invent monorepo CI %.

## 2026-07-21 (docs reorganization + coverage on main)

- Canonical LLM index added: `docs/STATUS.md` (SHAs, done vs blocked, CI-first
  validation, false-claim corrections).
- Pro raw coverage **87.18%** (**24 851 / 28 507**), suite **215/215**, analyze 0 —
  PR **#120** (`9f84046`); docs SHA note PR **#121**. Fleet **≥85% met**.
- T10–T14 hotspot metas remain **HECHO** (#116/#117).
- Community standalone PR **#29**: strict analyze clean; **89/89**; STATUS
  pointer **#30**; `main` = `83f3f7f`.
- Monorepo STATUS index merged as **#122**; `main` = `9facda3`.
- T31: Bun **1.3.14**, Node **24**, Astro **7**; dual `landing/package-lock.json`
  removed — only `landing/bun.lock`.
- Still **BLOCKED** (needs user): T04 FTPS, VPS issues **#9**/**#13**, FML-101,
  FML-129, FML-116, FML-117, AdMob/OAuth (T40–T42). See STATUS.md.

## 2026-07-21 (health-audit follow-up — superseded numbers kept for history)

- Community standalone (`FormulaeCommunity`) PR **#29** merged: strict
  `flutter analyze --fatal-infos --fatal-warnings` is clean; `flutter_lints`
  aligned to `^4.0.0`; tests **89/89**. `main` = `b133e55`.
- Monorepo docs refreshed (this file + parent `Formulae/README.md` local map).
- T10–T14 hotspot metas remain **HECHO** (PR #116/#117). Global Pro raw coverage
  raised to **≥85%**: **87.18%** (**24 851 / 28 507**) via favorite add/remove
  behavior tests across electricidad + related formula screens
  (`pro/test/formula_favorite_toggle_coverage_test.dart`). Command:
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter compact`
  with `JWT_SHARED_SECRET=test-shared-secret`,
  `FORMULAE_BUILD_NONCE=ci-test-build-nonce`,
  `FORMULAE_APP_VERSION=0.0.0-ci`. Suite **215/215**; analyze 0 issues.
  Prior baseline was **82.60%** (**23 548 / 28 507**). Merged as PR **#120**
  (`9f84046` on `main`).
- T31: bun **1.3.14**, Node **24**, Astro **7** already on `main`. Residual fixed
  this session: removed dual `landing/package-lock.json` (CI uses Bun
  `--frozen-lockfile` only; `landing/bun.lock` remains).
- Worktrees `formulae-pr-hosted` / `formulae-preload-failclosed` removed after
  confirming squash-superseded (PR #118 / #111) and clean trees. No force-push.
- Still **BLOCKED** without user secrets/hostnames: T04 FTPS, VPS #9/#13,
  FML-101 images, FML-129 OpenAI rotation, AdMob/OAuth.

## 2026-07-21 (earlier same day — historical baselines)

> Historical. Superseded by #120 coverage and `docs/STATUS.md`.

- PRs #98 through #111 merged since 2026-07-17.
- Toolchain upgrades pinned across the repo:
  - Flutter `3.44.7` / Dart `3.12.2`.
  - Astro `7` + Vite `8` + Tailwind `4.3` in `landing/`.
  - BFF on Hono + `@hono/zod-openapi` + TypeScript `7`.
  - CI pinned to Node `24` and Bun `1.3.14`.
- New local baselines (all passing at that moment):
  - BFF: **186/186** tests.
  - Pro: **164/164** tests; raw line coverage **81.65%** (**23,270 / 28,499**
    lines). *(Later raised; see #120 / STATUS.md.)*
  - Community (monorepo): **107/107** tests. *(Later **115/115**.)*
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

## 2026-07-17 (historical coverage diary)

> Historical increments toward 85%. Final state is STATUS.md / PR #120.

- Pro line coverage progressed through the day from ~81.44% toward ~82.3% with
  behavior tests on tasks, PDF, favorites, chat lifecycle, and drawer flows.
  Suite size grew from ~151 toward **164** tests. Claims that “85% remains unmet”
  in this section are **obsolete** as of PR #120 (**87.18%**).
- See git history of this file before the STATUS.md reorganization for the
  full per-increment narrative if needed.
