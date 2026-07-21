# Formulae — canonical status (LLM index)

**Single source of truth for “what’s done / blocked / how to validate.”**
Verified against `origin/main` + GitHub on **2026-07-21**. Prefer this file over
scattered READMEs, old SESSION_STATUS sections, or audit notes that may lag.

| Surface | Canonical doc |
| --- | --- |
| Live status (this file) | `docs/STATUS.md` |
| Ticket board (FML-*) | [`docs/TICKETS.md`](TICKETS.md) |
| Web deploy / FTPS | [`docs/DEPLOY_CI_WEB.md`](DEPLOY_CI_WEB.md) |
| Session changelog (append-only) | [`../SESSION_STATUS.md`](../SESSION_STATUS.md) |
| Local audit handoff (not in git) | `Formulae/audits/2026-07-21-revision-integral/` |
| Folder map (outside monorepo git) | `Formulae/README.md` |

Audit tickets T\* live only under `/Apps/Formulae/audits/` (not pushed to
GitHub). Critical status is **mirrored here**.

---

## Current SHAs (2026-07-21)

| Repo | `main` SHA | Notes |
| --- | --- | --- |
| [`CAPDESIS/formulaeapps`](https://github.com/CAPDESIS/formulaeapps) | `1f8cceb` | Includes Pro coverage PR **#120** (`9f84046`) + docs note **#121** |
| [`CAPDESIS/FormulaeCommunity`](https://github.com/CAPDESIS/FormulaeCommunity) | `b133e55` | Strict analyze via PR **#29** |

Open monorepo issues (deploy/infra Spec Kit): **#9**, **#13**. No open monorepo PRs at verification time.

---

## Done (code / CI evidence on `main`)

| Item | Evidence |
| --- | --- |
| BFF | **186/186** tests; TypeScript checks in CI |
| Landing | **64/64** tests; Astro **7** + Vite **8** + Tailwind **4.3**; Bun **1.3.14** + Node **24** |
| Contract gates | `scripts/verify-parity.sh` + `scripts/route-coverage.sh` PASS on `main` |
| Pro analyze | 0 issues (`--fatal-infos --fatal-warnings`) |
| Pro tests + coverage | Suite **215/215**; raw lcov **87.18%** (**24 851 / 28 507**) — PR **#120**. Fleet **≥85% met**. Hotspots T10–T14 met earlier (#116/#117) |
| Community (monorepo copy) | analyze 0; **115/115** tests |
| Community standalone | analyze 0 strict; **89/89** tests; `flutter_lints ^4.0.0` |
| T31 toolchain | Bun **1.3.14**, Node **24**, Astro **7** on `main`. Dual lockfile cleared: only `landing/bun.lock` (no `package-lock.json`) |
| Audit T02/T03/T05/T10–T14/T20–T25/T30/T31 | Done (see audit README / HANDOFF locally) |

Coverage command (CI / agent; avoid heavy local re-runs unless needed):

```bash
cd pro
FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter compact \
  --dart-define=JWT_SHARED_SECRET=test-shared-secret \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci
```

---

## Blocked — needs user / external access

Do **not** mark these HECHO. They require secrets, hostnames, VPS, or product decisions.

| ID | Blocker | Needs from user |
| --- | --- | --- |
| **T04** / deploy FTPS | `deploy-web.yml` still uses IP `31.170.161.105` + `ssl:check-hostname false` | Real FTPS hostname → set hostname verify `true` |
| GitHub **#9** / **#13** | Spec Kit VPS / multi-app infra issues still OPEN | Contabo/VPS + deploy validation |
| **FML-101** | 176 public `/imagenes/` URLs still 404 | Authorized FTPS promote + remote smoke |
| **FML-129** | Historical OpenAI credential rotation | Secret-manager rotation + old clone cleanup |
| **FML-116** | Runners / promotion / staging controls | Authorized `ci-builds` capacity + terminal CI on exact `main` SHA |
| **FML-117** | IAP entitlement / account-device product decision | Product + Apple/Google sandbox validators |
| **T40** | AdMob / OAuth / OpenAI ops | Console access |
| **T41** | Staging, VPS volume, backups, image hosting | VPS / GitHub settings |
| **T42** | Community drift, Polar, `STORE_AUTODEPLOY`, historical PDFs | Product decisions |

---

## How to validate (prefer CI, not heavy local)

1. Confirm SHAs: `git fetch && git rev-parse origin/main` in each repo.
2. Prefer GitHub Actions on `main` / PR checks over re-running full Flutter coverage locally.
3. Ticket tracker: `make verify-tickets` (validates `docs/TICKETS.md` shape).
4. Light local gates when editing contracts: `bash scripts/verify-parity.sh` and
   `bash scripts/route-coverage.sh`.
5. Do **not** treat green unit tests as production deploy proof — see FML-101 / FML-116 / T04.

---

## Known drift (not “done”)

- `monorepo/community/` is a **vendored copy**, not a submodule. Play Store source of truth is **`FormulaeCommunity`** (`community-app/`). Layout/release pipelines may diverge; do not assume sync.
- Historical docs (`docs/AUDITORIA_FUNCIONAL_2026-07-13.md`, older `SESSION_STATUS` entries, `ARCHITECTURE.md` backlog) may quote older test/coverage counts — **this file wins**.

---

## False “done” claims corrected (2026-07-21)

| Claim that was wrong | Reality |
| --- | --- |
| Pro raw coverage still ~82.6% / fleet 85% open | **87.18%** on `main` via #120; fleet ≥85% **met** |
| Pro suite still 164 or 214 tests | **215/215** |
| T04 / images / VPS “terminado” | Still **blocked** (#9/#13, FML-101, T04) |
| T31 dual lockfile still open | **Cleared** — only `landing/bun.lock` |
| Community standalone analyze broken | Fixed in **#29** (`b133e55`) |
| T10–T14 still pending | **Done** (#116/#117); next work is blocked externals, not those hotspots |
