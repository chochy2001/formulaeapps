# Formulae — canonical status (LLM index)

**Single source of truth for “what’s done / blocked / how to validate.”**
Verified against `origin/main` + GitHub on **2026-07-21** (triage refresh). Prefer
this file over scattered READMEs, old SESSION_STATUS sections, or audit notes
that may lag.

| Surface | Canonical doc |
| --- | --- |
| Live status (this file) | `docs/STATUS.md` |
| Ticket board (FML-*) | [`docs/TICKETS.md`](TICKETS.md) |
| Improvement roadmap (features + CI plan) | [`docs/IMPROVEMENT_ROADMAP.md`](IMPROVEMENT_ROADMAP.md) |
| Web deploy / FTPS | [`docs/DEPLOY_CI_WEB.md`](DEPLOY_CI_WEB.md) |
| Session changelog (append-only) | [`../SESSION_STATUS.md`](../SESSION_STATUS.md) |
| Local audit handoff (not in git) | `Formulae/audits/2026-07-21-revision-integral/` |
| Local improvement plans (not in git) | `Formulae/audits/2026-07-21-mejora-continua/` |
| Folder map (outside monorepo git) | `Formulae/README.md` |

Audit tickets T\* live only under `/Apps/Formulae/audits/` (not pushed to
GitHub). Critical status is **mirrored here**.

---

## Current SHAs (2026-07-21)

| Repo | `main` SHA | Notes |
| --- | --- | --- |
| [`CAPDESIS/formulaeapps`](https://github.com/CAPDESIS/formulaeapps) | `4a01e40` | Tip after staging-DNS docs **#127**; re-check: `git rev-parse origin/main`. |
| [`CAPDESIS/FormulaeCommunity`](https://github.com/CAPDESIS/FormulaeCommunity) | `df8d022` | Analyze **#29**; README→STATUS **#30**/#31. CI still missing `flutter test` step (follow-up PR). |

Open monorepo issues (deploy/infra Spec Kit): **#9**, **#13**. FormulaeCommunity:
**0** open issues.

---

## CI health on `main` (remote evidence)

| Workflow | Latest signal | Verdict |
| --- | --- | --- |
| formulaeapps **CI** (schedule) | [29822650313](https://github.com/CAPDESIS/formulaeapps/actions/runs/29822650313) **success** on `26c97ba` (all 6 jobs) | Code gates healthy on that SHA |
| formulaeapps **CI** on HEAD | Prefer `git rev-parse origin/main` + Actions for tip | Do not promote from stale schedule SHA alone |
| formulaeapps **Deploy to stores** | Failures on recent pushes ([29865725314](https://github.com/CAPDESIS/formulaeapps/actions/runs/29865725314), [29865190240](https://github.com/CAPDESIS/formulaeapps/actions/runs/29865190240)) | **Expected**: kill switch `STORE_AUTODEPLOY` unset / ≠ `true` — guard aborts before any store publish |
| FormulaeCommunity **Formulae Flutter CI** | Schedule **success**; historically analyze + debug APK only | Line-coverage PR adds `flutter test --coverage` + soft LF/LH summary + `community-app-lcov` artifact |
| Older CI failures (Jul 18–19) | BFF staging-hardening timeout / shellcheck | Superseded by Jul 21 schedule green |
| formulaeapps **line coverage** (this change) | Soft-report RAW LF/LH in job summary; artifacts `pro-lcov`, `community-monorepo-lcov`, `bff-lcov`, `landing-lcov` | Informational — no hard 85% gate until runner confirms floors |

`gh variable list` showed **no** repo variables (including `STORE_AUTODEPLOY`) —
disarmed by design until store secrets are provisioned and the var is set to
`true`.

---

## Done (code / CI evidence on `main`)

| Item | Evidence |
| --- | --- |
| BFF | **186/186** tests; TypeScript checks in CI |
| Landing | **64/64** tests; Astro **7** + Vite **8** + Tailwind **4.3**; Bun **1.3.14** + Node **24** |
| Contract gates | `scripts/verify-parity.sh` + `scripts/route-coverage.sh` PASS on `main` |
| Pro analyze | 0 issues (`--fatal-infos --fatal-warnings`) |
| Pro tests + coverage | Suite **215/215**; raw lcov **87.18%** (**24 851 / 28 507**) — PR **#120**. Local ≥85% met; CI soft-reports RAW + uploads `pro-lcov` for runner remasure |
| Community (monorepo copy) | analyze 0; **115/115** tests; last local RAW **85.44%** (2026-07-17, stale) — CI soft-reports + `community-monorepo-lcov` |
| Community standalone | analyze 0 strict; **89/89** tests (local/session); CI test+coverage in FormulaeCommunity PR (Play Store SoT; % UNKNOWN until runner) |
| BFF coverage | Soft-report `bun test --coverage` → `bff-lcov`; last fleet measure **93.54%** on `src/` (2026-07-03) |
| Landing coverage | Soft-report `bun run test:coverage` → `landing-lcov`; include = consts + i18n only (not full Astro UI) |
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

## Auth / user-password path (findings)

| Layer | Behavior | CI / prod |
| --- | --- | --- |
| Device JWT | `POST /auth/token` (HMAC `client_proof` + build nonce) | Staging smoke mints **ephemeral** device tokens from staging `.env` secrets — **does not** create email/password users |
| Account register/login | Implemented behind `ENABLE_USER_ACCOUNT_AUTH` (default **off** → **403** in current monorepo code) | Unit/integration tests create users **in-process SQLite only** (`account-auth-stub.test.ts`, `users-store.test.ts`). **No workflow seeds prod/staging accounts** |
| Production `api.formulaeapps.com` | OpenAPI **1.0.0** exposes only `/health`, `/auth/token`, `/openai/chat`, `/iap/validate` | `POST /auth/register` / `/auth/login` → **404** (routes not on live build). Contract in git is **2.1.0**. Health **200**. Drift = blocked VPS cutover (**#9**), not a missing CI user |
| Flutter apps | Account UI / flag remain off until product + staging evidence | Do not invent production credentials |

---

## Pending vs blocked matrix

| ID | Class | Status | Needs from user |
| --- | --- | --- | --- |
| **T04** / deploy FTPS | Ops / security | **BLOCKED** | Real FTPS hostname → replace IP `31.170.161.105`, set `ssl:check-hostname true` |
| GitHub **#9** / **#13** | Ops / Spec Kit | **BLOCKED** | Contabo/VPS deploy + multi-app infra validation (prod BFF still contract **1.0.0**) |
| **FML-101** | Ops | **BLOCKED** | FTPS promote of `landing/public/imagenes/` — sample remote smoke still **404** `text/html` |
| **FML-129** | Security ops | **BLOCKED** | Rotate historical OpenAI key in secret manager; clean old clones |
| **FML-116** | Ops / GitHub | **BLOCKED** | Protected envs, required checks, staging SHA, FTPS/VPS backup/rollback evidence |
| **Staging BFF DNS** | Ops / DNS | **BLOCKED** | Cloudflare A `staging.api` → `144.126.159.214` (DNS only) + Traefik/`staging_web_proxy` + `/opt/staging/apps/formulaeapps` bootstrap — hoy **NXDOMAIN** (2026-07-21); prod `api.formulaeapps.com/health` = 200 |
| **FML-117** | Product | **BLOCKED** | Entitlement authority + Apple/Google sandbox validators |
| **FML-127** | CI exact-SHA | **PENDING** (partial) | Latest schedule CI green on older SHA; need terminal green on exact HEAD before promote |
| **T40–T42** | Ops / product | **BLOCKED** | AdMob/OAuth secrets, VPS volume/backups, `STORE_AUTODEPLOY` arm decision, Polar/PDFs |
| Store auto-deploy failures | Expected guard | **Not a bug** | Keep disarmed until secrets exist; then set `STORE_AUTODEPLOY=true` |

---

## Blocked — needs user / external access

Do **not** mark these HECHO. They require secrets, hostnames, VPS, or product decisions.

| ID | Blocker | Needs from user |
| --- | --- | --- |
| **T04** / deploy FTPS | `deploy-web.yml` still uses IP `31.170.161.105` + `ssl:check-hostname false` | Real FTPS hostname → set hostname verify `true` |
| GitHub **#9** / **#13** | Spec Kit VPS / multi-app infra issues still OPEN | Contabo/VPS + deploy validation |
| **FML-101** | 176 public `/imagenes/` URLs still 404 | Authorized FTPS promote + remote smoke |
| **FML-129** | Historical OpenAI credential rotation | Secret-manager rotation + old clone cleanup |
| **FML-116** | Runners / promotion / staging controls | Staging + protected production env + FTPS/VPS evidence |
| **Staging BFF host** | `staging.api.formulaeapps.com` NXDOMAIN; no app tree on `staging-node` | Create CF A (DNS only) → `144.126.159.214`; provision Traefik network + `.env.staging` + `STAGING_SSH_*`; then smoke `/health` |
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
6. Treat **Deploy to stores** red as expected while `STORE_AUTODEPLOY` ≠ `true`.

---

## Known drift (not “done”)

- `monorepo/community/` is a **vendored copy**, not a submodule. Play Store source of truth is **`FormulaeCommunity`** (`community-app/`). Layout/release pipelines may diverge; do not assume sync.
- Live BFF OpenAPI **1.0.0** vs monorepo contract **2.1.0** (missing account + entitlement routes on prod).
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
| Deploy-to-stores red = release broken | Kill switch disarmed (`STORE_AUTODEPLOY`); expected until armed |
| Prod account login available | Live BFF lacks `/auth/register|login` (404); flag-off 403 only exists after cutover |
