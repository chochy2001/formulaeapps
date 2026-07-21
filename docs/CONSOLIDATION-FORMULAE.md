# Formulae Consolidation & Decommission Record

> **Live status:** [`STATUS.md`](STATUS.md). This consolidation record is a
> 2026-07-15 decision log; SHAs/test counts inside may be outdated.

**Document:** `docs/CONSOLIDATION-FORMULAE.md`
**Repo:** `CAPDESIS/formulaeapps` (monorepo, canonical)
**Date:** 2026-07-15
**Status:** Pro — DELETE AFTER FINAL APK DIFF · Community — DO NOT DELETE YET

---

## 1. Purpose & scope

This record documents the consolidation of the two standalone Flutter apps —
`CAPDESIS/FormulaePro` and `CAPDESIS/FormulaeCommunity` — into the
`CAPDESIS/formulaeapps` monorepo (`pro/`, `community/`, `landing/`, `bff/`,
`contracts/`, `resueltos/`), and the go/no-go decision on deleting the two
standalone GitHub repositories.

Verification was **read-only**: all git inspection ran against fetched
`origin/main` refs; all builds ran in isolated detached `git worktree`
checkouts under a scratchpad and were removed afterward. No standalone repo was
pushed to, no branch deleted, no `main` modified.

---

## 2. Decision summary

| Repo | Verdict | Gate before deletion |
|------|---------|----------------------|
| `CAPDESIS/FormulaePro` | **DELETE_AFTER_FIX** | One signed-APK diff vs last Play Store upload; build prod with `--flavor pro`; refresh 3 stale doc/ops refs |
| `CAPDESIS/FormulaeCommunity` | **DO_NOT_DELETE** | Stand up CI mobile release pipeline in monorepo; port IAP entitlement-cache hardening; update 'no tocar' doc + secrets-rotation refs |

Monorepo `origin/main` validated at `6c2bbfb`.

---

## 3. What was unified

### 3.1 Pro (`FormulaePro` → `formulaeapps/pro`)
- **Complete superset.** Standalone `origin/main` @ `5ac6552` (2026-04-16);
  monorepo @ `6c2bbfb` (2026-07-15). Every `lib/` and `assets/` file from the
  standalone app exists in the monorepo. The only two standalone-unique files —
  `lib/chat_gpt/chat_model.dart` and `lib/chat_gpt/models_model.dart` — were
  merged as inline classes into `pro/lib/chat_gpt/api_service.dart` (confirmed
  via `git grep "class ChatModel" / "class ModelsModel"`); nothing lost.
- Monorepo adds ~155 files (new math/physics sections, favorites,
  observability, responsive widgets) and richer assets.
- `pubspec.yaml` version identical (`1.0.0+1`); dependency set is a strict
  superset (adds dio, crypto, firebase_core/crashlytics, posthog_flutter,
  `formulaeapps_bff_client`, in_app_purchase_platform_interface; shared deps
  equal-or-newer; font_awesome_flutter and google_fonts upgraded).
- **Store identity identical:** Android applicationId
  `com.capdesis.formulae_pro.formulae_calculo_pro`, versionCode `59`,
  versionName `3.3.8`, minSdk/targetSdk, and keystore-driven release
  `signingConfigs` are byte-identical; the `pro` productFlavor re-asserts the
  same applicationId. iOS `PRODUCT_BUNDLE_IDENTIFIER = com.capdesis.formulaepro.3`
  matches. l10n (`app_en.arb`/`app_es.arb`, `l10n.yaml`) identical.
- **Branches:** all 18 non-main branches are merged/empty (0 ahead) or contain
  only superseded trivia. Both `security/*` branches are fully merged. The two
  branches with unmerged diffs (`868em0m05-…-Android`: targetSdk 34→35 —
  monorepo is already at 36; in_app_purchase ^3.2.3; and
  `PROY-174_Cambiar-Colores`: 2-line static color change — monorepo already
  implements theme-aware color logic) are obsolete/superseded.

### 3.2 Community (`FormulaeCommunity` → `formulaeapps/community`)
- **Functionally current, architecturally ahead, but NOT a literal superset.**
  Standalone `origin/main` @ `1d4bc58` (2026-07-14); monorepo community @
  `8421d7d` (2026-07-14). The monorepo forked from standalone on 2026-04-30
  (`56973d6`) into an independent BFF (backend-for-frontend) architecture and
  evolved separately.
- **Confirmed matches:** app identity (Android + iOS both `capdesis.formulae`,
  same signingConfigs shape), pubspec version `2.2.9+74`, l10n keys (monorepo is
  a strict superset, +9 keys), and the critical 2026-07-14 Flutter-3.44
  IconData-final fix (font_awesome_flutter → 11.0.0 / google_fonts → 8.1.0),
  applied same-day in both (standalone PR #24 = `1d4bc58`; monorepo PR #89 =
  `8421d7d`).
- **15 standalone files absent from the monorepo:** 4 legacy `lib/chat_gpt/*`
  helpers (superseded by `auth_service.dart` + the generated
  `formulaeapps_bff_client`), 9 test files (superseded by the monorepo's own
  larger community suite), `AGENTS.md` (capdesis-ui pointer), and
  `.github/actionlint.yaml`. Most are non-load-bearing — **except one (see §5).**

### 3.3 Landing & BFF
- `landing/` (Astro 6 static site) and `bff/` (Bun + hono/zod-openapi) are
  monorepo-native and already own the web deploy path (`deploy-web.yml`), with
  no standalone-repo references.

---

## 4. Verification evidence

### 4.1 Build/analyze health (isolated worktrees, `origin/main` @ 6c2bbfb)
| Subproject | pub/install | analyze/typecheck | build | Status |
|-----------|-------------|-------------------|-------|--------|
| pro | OK | `No issues found!` | `flutter build web` OK | **CLEAN** |
| community | OK | `No issues found!` | web N/A (no `web/` scaffold) | **CLEAN** (web N/A) |
| landing | `bun install --frozen-lockfile` OK | (astro type-gen) | `astro build` 13 pages + sitemap, exit 0 | **CLEAN** |
| bff | `bun install` OK | `tsc --noEmit` OK; `bun build` OK | — | **WARNINGS** (tests, see §7) |

### 4.2 Wiki / releases / meta
- Both repos: `has_wiki=true` but the `.wiki.git` was never materialized
  (3 authenticated clone attempts → "Repository not found") — no wiki content
  exists. Zero releases, tags, open PRs, open issues, webhooks. FormulaePro has
  no environments; FormulaeCommunity has one auto-provisioned `copilot`
  environment (no rules/secrets). Only committed workflow is
  `dart-format-check.yml` (superseded by monorepo CI).

### 4.3 Security branch (community)
- `security/remove-hardcoded-openai-key` is genuinely unmerged (NOT an ancestor
  of main, 1 ahead / 19 behind) **but moot**: `git grep -n 'sk-' origin/main --
  '*.dart'` returns zero hits; `api_consts.dart` was rewritten to a
  dart-define-driven BFF proxy (`api.formulaeapps.com`, JWT shared secret) with a
  'no hardcoded secrets' header. No live key to leak.

---

## 5. Blockers (Community) — why DO_NOT_DELETE

### 5.1 Live Play Store source, not archived, active CI
- `gh repo view CAPDESIS/FormulaeCommunity` → `isArchived:false`,
  `pushedAt:2026-07-14T18:37:01Z`.
- A scheduled **"Formulae Flutter CI"** run completed successfully
  **2026-07-15T10:17:05Z** — the repo is under live daily automation, not a
  stale artifact.
- `pro/docs/BACKLOG_REDISENO_PRO.md` (dated 2026-07-13, current) states
  verbatim: **"FormulaeCommunity standalone = app de Play Store (no tocar)."**
- `deploy-stores.yml` now exists in `.github/workflows/` but is delivered
  **DESARMADO** (its `guard` job aborts until `STORE_AUTODEPLOY='true'`). No
  validated mobile release has been cut from the monorepo yet, so
  `community/MASTER_SPEC.md` still marks the release build untested (T097).
- **Deleting now removes the only documented source of the shipping Community
  binary with no validated replacement pipeline.**

### 5.2 CONFIRMED functional regression — IAP entitlement cache
- Standalone `lib/chat_gpt/purchase_entitlement_cache.dart` (PR #15, 2026-06-10,
  "Harden chat purchase validation: TTL, memoized future, stream-leak fix")
  implements a **24-hour TTL, SharedPreferences-backed entitlement cache**
  (`isCachedEntitlementFresh`) that prevents a lapsed/refunded subscription from
  unlocking premium chat indefinitely (and burning BFF/OpenRouter spend), while
  still working offline.
- The monorepo replacement `community/lib/chat_gpt/in_app_purchase_manager.dart`
  had **no equivalent**: `_hasValidPurchase` was a plain in-memory bool — zero
  persistence, zero timestamp, zero TTL, zero forced re-validation.
- **2026-07-21:** the TTL/persistence hardening has been ported into the
  monorepo:
  - `community/lib/chat_gpt/purchase_entitlement_cache.dart` (24h TTL helper,
    future-dated timestamp guard).
  - `community/lib/chat_gpt/in_app_purchase_manager.dart` now persists
    `hasValidPurchase` + `hasValidPurchaseCheckedAt` to SharedPreferences,
    trusts only fresh cached entitlements, refreshes the timestamp only after a
    successful store validation, and falls back to the cached value on store
    errors without extending the TTL.
  - `community/test/chat_gpt/purchase_entitlement_cache_test.dart` and updates
    to `community/test/in_app_purchase_manager_test.dart` cover the behavior.
  - `flutter analyze --no-pub --fatal-infos --fatal-warnings` and
    `flutter test --no-pub` pass in `community/`.

### 5.3 Ops references that break on rename/delete
- `CAPDESIS/secrets-rotation/schedule.toml` names `FormulaeCommunity` as a hard
  dependency for `formulae-bff-hmac` rotation ("Requires coordinated client
  release (FormulaeCommunity); blocks if no recent client release."). Must be
  repointed at `formulaeapps/community`.

---

## 6. Preconditions to clear before each deletion

**FormulaePro (DELETE_AFTER_FIX):**
1. Signed build from `formulaeapps/pro` with `--flavor pro`; diff
   applicationId + versionCode(59) + signing SHA-256 vs last Play Store upload.
2. Confirm prod pipeline targets `--flavor pro` (community flavor id differs).
3. Update `ARCHITECTURE.md` 'zombie repos' section,
   `CAPDESIS/.github` repo-runner-matrix.md, and resolve the FormulaePro OpenAI
   key entry in `secrets-rotation/inventory.toml`.

**FormulaeCommunity (DO_NOT_DELETE → revisit only after):**
1. Arm the existing `deploy-stores.yml` pipeline (remove the `STORE_AUTODEPLOY`
   guard), validate it produces signed apk/aab/ipa, and cut the Play Store
   release over to the monorepo (community T097).
2. Port `purchase_entitlement_cache.dart` TTL/persistence hardening into
   `in_app_purchase_manager.dart` (or obtain explicit team sign-off to accept
   the regression).
3. Retract the "no tocar" designation in `BACKLOG_REDISENO_PRO.md`.
4. Repoint `secrets-rotation/schedule.toml` at `formulaeapps/community`.

---

## 7. Known pre-existing issues (independent of deletion)

These issues are now resolved or superseded as of 2026-07-21:

- **bff test harness bug (CI-breaking, not Windows-specific):** `tests/setup.ts`
  handled `JWT_LEGACY_VERIFY_START`/`CUTOFF` in a way that coerced `undefined` to
  the string `'undefined'`, failing `env.ts` validation. **Resolved** by aligning
  the test harness cleanup with `env.ts` expectations; the IAP isolation work in
  `e9d8a13` hardened the overall BFF test setup against shared-state
  contamination.
- **deploy-web.yml FTP promotion disabled:** Superseded by the active FTPS
  promotion job in `.github/workflows/deploy-web.yml` (see
  `docs/DEPLOY_CI_WEB.md`). It runs on a dedicated `deploy-only` runner inside a
  protected `production` environment, connects to Hostinger IP
  `31.170.161.105`, and includes a post-deploy smoke. The interim
  `ssl:check-hostname false` configuration still needs to be replaced with a
  hostname-verified endpoint once the real hostname is provisioned.
- **No CI mobile store pipeline for either app in formulaeapps:** Superseded by
  `.github/workflows/deploy-stores.yml`, which is delivered but **DESARMADO**
  (its `guard` job aborts until the repository variable `STORE_AUTODEPLOY` is
  set to `'true'`). The pipeline exists; activating it requires provisioning
  the keystore, Play service account, App Store Connect, and Match secrets
  documented in the workflow header.

---

## 8. Confirmed non-issues (crossed off)

- `IngenieriaTrackerFree` / `IngenieriaTrackerPro` `lib/constants.dart` matches
  for "FormulaePro"/"FormulaeCommunity" are just `kFormulaeProLogo` /
  `kFormulaeCommunityLogo` cross-promo CDN image URLs — not repo dependencies.
- Wikis empty; no releases/tags/open-PRs/issues/webhooks to export.
- The community `security/remove-hardcoded-openai-key` branch is unmerged but the
  vulnerability is dead (BFF rewrite; no `sk-` key in main).

---

## 9. Operator steps (assistant will NOT delete)

All deletions are irreversible and must be performed by the operator.

1. **Safety mirror (both):**
   `git clone --mirror git@github-ohcho:CAPDESIS/FormulaePro.git` and
   `…/FormulaeCommunity.git`; store the mirrors durably.
2. **FormulaePro:** clear §6 preconditions → (unarchive if needed:
   `gh api -X PATCH repos/CAPDESIS/FormulaePro -f archived=false`) →
   `gh repo delete CAPDESIS/FormulaePro --yes`
   (or Settings → Danger Zone → Delete). Requires `delete_repo` scope:
   `gh auth refresh -h github.com -s delete_repo`.
3. **FormulaeCommunity:** **do not delete.** Revisit only after all §6 Community
   preconditions are met and the team confirms the Play Store cutover is live.
4. **Post-deletion:** commit this file; org-wide grep for dangling references
   (`gh api search/code -X GET -f q='FormulaePro org:CAPDESIS'` and the same for
   FormulaeCommunity).

---

*Consolidation verification performed read-only against `origin/main` (monorepo
@ `6c2bbfb`); isolated build worktrees created under scratchpad and removed.
No standalone repo pushed, no branch deleted, no `main` modified.*