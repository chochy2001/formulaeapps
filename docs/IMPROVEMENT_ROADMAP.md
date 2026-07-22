# Formulae — improvement roadmap (planning index)

**Planning-only index** for continuous product and CI/CD improvement.
Verified against code + `docs/STATUS.md` on **2026-07-22**. Does **not**
authorize deploys, flag flips, store publishes, or VPS changes.

| Doc | Role |
| --- | --- |
| [`STATUS.md`](STATUS.md) | Live done / blocked / SHAs / how to validate |
| [`TICKETS.md`](TICKETS.md) | Operational `FML-*` board |
| This file | Next features + CI plan summary (GitHub-visible) |
| Local deep dive (not in git) | `/Apps/Formulae/audits/2026-07-21-mejora-continua/` |

Full capability map, ranked features, CI pyramid, and blocked-ticket tie-in live
in the local audit folder (mirrors critical conclusions here).

---

## What the product already does (confirmed)

| Surface | Capabilities (short) |
| --- | --- |
| **Pro** | Bilingual formula catalog (math + physics sections), favorites/folders, local PDF, tasks, FAQ, AI chat via BFF, responsive shell; no ads; IAP fail-closed until sandbox |
| **Community** | Same domain + AdMob; local study-sheet PDF (no historic remote PDFs); Play Store SoT = `FormulaeCommunity` repo (monorepo `community/` is vendored) |
| **BFF (git 2.1.0)** | `/health`, `/auth/token`, `/openai/chat`, `/iap/validate`, `/entitlement`, account register/login/oauth **flag-gated** (default off) |
| **BFF (prod live)** | OpenAPI **1.0.0**: health + token + chat + iap only — account/entitlement routes **absent** (cutover blocked) |
| **Landing** | Astro marketing ES/EN; canonical 176 image assets; FTPS deploy path exists |

Unknowns (do not invent): exact prod Flutter web SHA vs `main`. Community
Play Store SoT coverage is **measured**: CI **RAW 85.31%** / NO_GENERATED
**85.11%** on FormulaeCommunity **#37** (issue **#34** closed). Monorepo Pro
CI remasure still **UNKNOWN** on runners (**#141** merged → soft-report on
`test-light`; do not invent %).

---

## Top recommended next features

1. **Publish canonical images + secure FTPS (T04 / FML-101)** — unblock diagrams in prod.
2. **Staging → prod BFF cutover to contract 2.1.0 (#9 / #13 / FML-116)** — enable entitlement/accounts behind flags with evidence.
3. **IAP sandbox + entitlement authority (FML-117)** — real monetization path.
4. **Ship P0 content specs** (`pro/docs/roadmap/`: chemistry / statics / circuits — human gate first).
5. **Pro UX affordances** — wide LaTeX scroll cue, To-Do swipe hint, favorites folder feedback, contrast (high ROI on existing flows).
6. **Graphics backlog + FAQ missing diagrams** — after license-approved assets.
7. **Accounts UI / device pairing / Polar** — only after staging + product decisions (T42); keep flags off.
8. **Community sync policy** — declare Play Store SoT; avoid silent dual-edit.

Parallel without waiting on VPS: UX PRs, content review branch, docs, soft
coverage hygiene. **Do not** flip account/IAP flags or arm `STORE_AUTODEPLOY`
until blockers clear.

---

## CI/CD improvement plan (summary)

| Phase | Goal |
| --- | --- |
| **0** | User: T04 hostname, FML-101 promote, FML-129 key rotate, runners (FML-116) |
| **1** | Required branch checks; exact-SHA green (FML-127); post-FTPS remote image smoke |
| **2** | Staging BFF continuous (`staging.api` + Traefik + JWT smoke runbook) |
| **3** | Runner-confirmed LCOV floors → honest hard gates (Pro ≥85% local; Community SoT ≥85% CI) |
| **4** | Store secrets + optional `STORE_AUTODEPLOY` after staging + IAP policy |

**Always:** `verify-parity.sh` + `route-coverage.sh` on contract/route changes;
prefer remote CI over heavy local coverage; never treat store-guard red or
schedule-on-old-SHA as production proof.

Regression classes: new formula screens → route/l10n guards; assets → local
image check + URL parity; OpenAPI → regenerate Dart; auth/IAP → isolation +
fail-closed tests; PDF → `%PDF-` local, no historic URL fetch.

---

## Tie-in to remaining blocked work

```
T04 FTPS hostname ──► FML-101 image 200s ──► users see diagrams
FML-116 runners/staging ──► FML-127 exact SHA ──► #9/#13 VPS cutover ──► BFF 2.1.0
FML-129 rotate key ──► safe chat release
FML-117 (+ T40 secrets) ──► IAP/accounts go-live decisions
T41 / T42 ──► staging host, Polar, Community drift, STORE_AUTODEPLOY, historic PDFs
```

Critical path detail (local): 
`Formulae/audits/2026-07-21-mejora-continua/BLOCKED_TICKETS_TIE_IN.md`.

---

## Agent rules for auto-improvement

1. Implement features only behind existing flags until staging evidence exists.
2. Update `STATUS.md` + `TICKETS.md` when blocker state changes; do not mark
   T04 / FML-101 / #9 / #13 / FML-116 / FML-117 / FML-129 / T40–T42 HECHO without
   external evidence.
3. Prefer small PRs: one UX affordance or one content domain per PR.
4. Code and contracts beat historical Markdown (`ARCHITECTURE.md`, old backlog).
