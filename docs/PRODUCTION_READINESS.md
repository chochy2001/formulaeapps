# Formulae — production readiness checklist

**Verdict (2026-07-22): NOT production-ready for full ship.**

Code on GitHub `main` is healthy for unit/contract evidence and Play Store SoT
coverage, but **FTPS hostname, Contabo/VPS cutover, image promotion,
production controls, and store secrets** are still user/ops blockers. Public
staging/preview is retired and is not a prerequisite. Do **not** claim
production ready while T04 / #9 / #13 / FML-101 remain open.

Companion live index: [`STATUS.md`](STATUS.md). Re-check SHAs with
`git rev-parse origin/main` in each repo — tips below were verified this date.

| Repo | `origin/main` tip (this checklist) |
| --- | --- |
| [`CAPDESIS/formulaeapps`](https://github.com/CAPDESIS/formulaeapps) | `b26e49a` (**#145** tip; prior **#144**/#141) |
| [`CAPDESIS/FormulaeCommunity`](https://github.com/CAPDESIS/FormulaeCommunity) | `99708a9` (**#39** README tip; prior **#38**/#37) |

---

## Green — local / GitHub code evidence

| Item | Evidence | Notes |
| --- | --- | --- |
| BFF unit/integration | **186/186** tests; TypeScript in CI | Account auth flag-gated off by default |
| Landing | **64/64** tests; Astro **7** / Vite **8** / Tailwind **4.3** | Dual lockfile cleared (`landing/bun.lock` only) |
| Contract gates | `verify-parity.sh` + `route-coverage.sh` PASS on `main` | Prefer these over heavy Flutter locally |
| Pro analyze + suite | 0 issues strict; **215/215**; local RAW **87.18%** (#120) | Runner remasure **UNKNOWN** |
| Community monorepo copy | analyze 0; **115/115** | Vendored; not Play Store SoT |
| Community Play Store SoT | FormulaeCommunity **#37** CI RAW **85.31%** / NO_GENERATED **85.11%**; issue **#34** closed; tip **#38** | Workflow name `Formulae Flutter CI` restored |
| Store kill-switch UX | Soft-skip when `STORE_AUTODEPLOY` ≠ `true` (**#130**/#137) | Red while disarmed = **expected**, not a merge blocker |
| Historical staging role/network code | Accepts `staging`/`staging-node`; compose → `staging_proxy` (**#129**) | Archived; not part of the production release path |
| CI label routing | Pro/Community/parity soft-report → `test-light` (**#141**) | APK/Docker remain `build-heavy` |
| Prod BFF health | `api.formulaeapps.com/health` **200** | Live OpenAPI still **1.0.0** (not git **2.1.0**) |

---

## Blocked on CI runners (do not poll for hours)

| Item | Status | Agent rule |
| --- | --- | --- |
| Monorepo Pro / Community / BFF / Landing soft-report floors on HEAD | **UNKNOWN** | Labels fixed in **#141**; self-hosted queue/cancel bottleneck remains. **Do not invent %**. Prefer recovered runner evidence later |
| Exact-SHA green on current HEAD (FML-127) | **PENDING** | Schedule CI green on older SHA (`26c97ba`) is not promote proof |
| `build-heavy` APK/Docker store builds | Offline / not required for docs | Leave store kill switch disarmed |

Skip runner-dependent validation in agent sessions. Update this table only when
a **terminal** job summary exists for the SHA under discussion.

---

## Blocked on user / ops (required to ship prod)

| ID | Blocker | What user must do |
| --- | --- | --- |
| **T04** | FTPS uses IP `31.170.161.105` + `ssl:check-hostname false` | Provide real FTPS hostname → set hostname verify `true` in `deploy-web.yml` |
| **FML-101** | Public `/imagenes/` still 404 (`text/html`) | Authorized FTPS promote of `landing/public/imagenes/` + remote smoke |
| **#9** | Prod BFF cutover (Spec Kit US6) | Contabo/VPS deploy of monorepo BFF contract **2.1.0**; today live is **1.0.0** |
| **#13** | Multi-app infra E2E (Spec Kit US5) | Validate Traefik/shared networks/certs against target VPS |
| **Historical staging BFF** | Public staging/preview retired | No DNS, host tree, `.env.staging`, or staging GitHub secrets should be provisioned |
| **FML-116** | Promotion controls | Protected production env, required checks, exact-main SHA, FTPS/VPS backup/rollback evidence |
| **FML-129** | Historical OpenAI credential | Rotate in secret manager; clean old clones |
| **FML-117** | IAP entitlement authority | Product decision + Apple/Google sandbox validators |
| **T40–T42** | AdMob/OAuth/OpenAI, VPS volumes/backups, Polar/PDFs, `STORE_AUTODEPLOY` | Console access + product decisions; arm `STORE_AUTODEPLOY=true` only after secrets exist |
| Auth accounts on prod | `/auth/register`/`/login` **404** on live | Comes with BFF **2.1.0** cutover; keep `ENABLE_USER_ACCOUNT_AUTH` off until production cutover evidence |

---

## Intentional non-bugs (do not “fix”)

- Deploy-to-stores red while `STORE_AUTODEPLOY` unset — kill switch by design.
- OAuth stub / IAP fail-closed when secrets are placeholders — deliberate.
- Account UI off until product + production cutover evidence.
- Monorepo `community/` drift vs FormulaeCommunity — vendored copy; Play Store SoT is the standalone repo.

---

## User-only ship checklist (ordered)

1. T04 FTPS hostname + enable `ssl:check-hostname true`.
2. FML-101 image promote + remote smoke (no 404 HTML).
3. Close **#9** / **#13** with direct Contabo cutover evidence (live OpenAPI → **2.1.0**).
4. FML-116 protected production envs + exact-SHA green (FML-127) when runners recover.
5. FML-129 key rotation; FML-117 IAP sandbox decision.
6. Provision store secrets; only then set `STORE_AUTODEPLOY=true` during the weekly release window.

Until steps 1–4 land, treat Formulae as **code-ready / ops-blocked**, not
production-shipped.
