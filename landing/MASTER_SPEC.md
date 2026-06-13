# Formulae Landing — MASTER_SPEC

**Scope**: This document records source-verified evidence for the `landing/` sub-app inside `CAPDESIS/formulaeapps`. Every capability and integration boundary points to a file under `~/Code/formulaeapps/landing/`. The landing app is intentionally OUT of the BFF integration boundary — it does not call `api.formulaeapps.com` and does not consume any FE↔BFF wire types. It is the bilingual marketing site at `formulaeapps.com` / `www.formulaeapps.com` and the static container for Pro Web at `app.formulaeapps.com`.

## Executive Summary

Formulae Landing is a static, bilingual (Spanish default + English) Astro site that serves as the public marketing surface for Formulae Pro and Formulae Community. Built with Astro 5.7 + Tailwind 4.1, deployed to Hostinger LiteSpeed (apex + `www`). The landing app does not participate in feature 002 (FE↔BE sync) — it has no chat client, no JWT, no IAP, and no BFF dependency. It is listed in this monorepo as a sibling sub-app for deployment-process unification, not for code-sharing.

Client readiness: **Operational — production-live at `https://formulaeapps.com` and `https://www.formulaeapps.com`** with valid Let's Encrypt TLS (verified by `audit/infra-validate-pre.md` 2026-05-19; expires 2026-07-30). No production changes pending from feature 002.

## Current Capabilities

### Detected stacks

- Astro ^5.7.0 (static site generator)
- TypeScript ^5.7
- Tailwind ^4.1 (via `@tailwindcss/vite` Vite plugin — Tailwind v4 syntax)
- Bun (build runner — `bun run build`)
- LiteSpeed (deployment target, Hostinger shared hosting)

### Manifest evidence

- `landing/package.json` (private package, version `1.0.0`, scripts: `dev`, `build`, `preview`, `check`, `og`, `favicons`, `lint`)
- `landing/astro.config.mjs` (site `https://formulaeapps.com`, i18n defaultLocale `es`, locales `[es, en]`, no fallback — each locale has its own page tree)
- `landing/Dockerfile` (multi-stage for nginx container deployment alternative path)
- `landing/nginx.conf` (containerized serve config)

### Source roots

- `src/` — Astro components + pages + content (bilingual page trees)
- `src/components/` — Reusable components (home/, layout/)
- `src/pages/` — `/index.astro` (ES) + `/en/index.astro` (EN) + nested pages (`gratuita`, `pro`, `support`, `privacidad`, etc.)
- `src/layouts/BaseLayout.astro` — shared HTML layout
- `src/styles/global.css` — Tailwind v4 entry + custom CSS
- `public/` — static assets (including `.htaccess` for LiteSpeed routing)
- `scripts/` — build helpers (`generate-og.mjs`, `generate-favicons.mjs`)

### Test roots

- None — no test directory. Visual QA is manual against the production site.

## Architecture and Source Map

- Repository: `CAPDESIS/formulaeapps` (canonical monorepo)
- Working tree: `~/Code/formulaeapps/landing/`
- Sibling apps: `pro/`, `community/` (Flutter), `bff/` (Bun/Hono — not consumed by landing)
- Deployment: Hostinger LiteSpeed
  - `formulaeapps.com` (apex) → `public_html/`
  - `www.formulaeapps.com` → same host
  - `app.formulaeapps.com` → `public_html/app/` (Pro Web build output, deployed separately)
- DNS: Cloudflare-proxied to Hostinger `31.170.161.105`. TLS via Let's Encrypt (Hostinger-managed).

## Key Workflows

- Local development: `cd landing && bun install && bun run dev` — Astro dev server at `http://localhost:4321`
- Type/lint check: `bun run check && bun run lint` (Astro check + Prettier)
- Production build: `bun run build` → `dist/` (static HTML/CSS/JS)
- Deploy (manual FTP fallback per workspace convention): `lftp` script to Hostinger `public_html/`
- OG image regeneration: `bun run og`
- Favicon regeneration: `bun run favicons`

## Integration Boundaries

### Out of scope for feature 002

Landing does NOT have:

- A chat client
- A JWT auth flow
- An IAP integration
- A BFF dependency
- Any `lib/generated/bff/` directory or codegen path

**Verification**: `grep -rE "api.formulaeapps.com|api.openai.com|formulaeapps_bff_client" ~/Code/formulaeapps/landing/src/` returns no matches (per `audit/route-coverage-post.md` — landing is excluded from the coverage scan because it has zero contract consumers).

### External integrations

- **Cloudflare** (DNS + proxy) for `formulaeapps.com`, `www.`, `app.` — managed via Cloudflare dashboard, not via the landing repo.
- **Hostinger** (origin host) — FTP deploy path documented in workspace ARCHITECTURE.md.
- **Astro Sitemap** (`@astrojs/sitemap`) — generates `sitemap-index.xml` + `sitemap-0.xml` at build time per the i18n config.

## Data, Storage, and Deployment

### Local storage

- N/A — landing is static. No client-side persistence, no cookies set by the landing itself (Cloudflare may set its own).

### Deployment

- Production: Hostinger LiteSpeed at `formulaeapps.com` + `www.formulaeapps.com` + `app.formulaeapps.com`
- TLS: Let's Encrypt issued via Hostinger, currently valid through 2026-07-30 (per `audit/infra-validate-pre.md`)
- Cache: Cloudflare proxy enabled (verified `cloudflare_proxied: true` in `audit/infra-validate-pre.md`)

## Validation Evidence

| scope | command                                 | status               | reason                                                                                                               | next_action                    |
| ----- | --------------------------------------- | -------------------- | -------------------------------------------------------------------------------------------------------------------- | ------------------------------ |
| docs  | `manual-review`                         | pass                 | This file traces every claim to source.                                                                              | none                           |
| astro | `bun install`                           | not-run-this-session | Last verified in `audit/baseline-before.md` (2026-05-18).                                                            | Re-run on next landing change. |
| astro | `bun run build`                         | not-run-this-session | Last verified clean in `audit/baseline-before.md`.                                                                   | Re-run on next landing change. |
| astro | `bun run check && bun run lint`         | not-run-this-session | Astro type-check + Prettier.                                                                                         | Re-run on next landing change. |
| infra | `curl -I https://formulaeapps.com/`     | **pass**             | HTTP 200, valid LE TLS (expires 2026-07-30), Cloudflare-proxied. Evidence: `audit/infra-validate-pre.md` 2026-05-19. | Monitored continuously.        |
| infra | `curl -I https://www.formulaeapps.com/` | **pass**             | Same as above.                                                                                                       | Same.                          |
| infra | `curl -I https://app.formulaeapps.com/` | **pass**             | Same — Pro Web served from `/app/` path.                                                                             | Same.                          |

## Documentation Drift Findings

### Resolved

- Zombie `~/Documents/Apps/FormulaeApps/formulae-landing/` carries a unique 114-line `MASTER_SPEC.md` (older audit snapshot). This canonical `landing/MASTER_SPEC.md` supersedes it; the zombie's copy is `discarded` per `audit/working-trees-2026-05-18.md` § T014.
- 17 small file diffs vs zombie are mostly cosmetic punctuation (em-dash vs comma); zombie content does not add value over canonical.

### Open items

- Empty asset stub directories in zombie (`src/assets/images/{features,hero,store-badges}/` and `src/content/`) — confirmed empty, discardable.
- Canonical-only `public/.htaccess` — Hostinger LiteSpeed routing config; verified present in canonical.

## Known Limits and Risks

- **No automated test coverage**: Landing has no test directory. Visual / functional QA is manual against the production site.
- **Hostinger deploy is FTP-based**: GitHub Actions CI/CD for landing is intentionally NOT in this repo (per workspace pattern — Hostinger billing issues drove manual `lftp` deploy). A future workflow could automate this if Hostinger stabilizes.
- **i18n routing is path-based**: `/` (ES) ↔ `/en/` (EN) with manual mapping in `LanguageSwitcher`. Misalignment of a localized path requires updating the switcher manually.

## Client Readiness

Readiness label: **Operational — production-ready**.

Suitable for:

- Public-facing marketing (already production-live).
- Pro Web hosting at `app.formulaeapps.com`.

Not yet suitable for:

- (No outstanding gaps. Feature 002 introduces no requirements that touch this app.)

## Next Steps

- No feature-002 work outstanding for landing.
- Future enhancement candidates (out of feature 002 scope): automated FTP deploy workflow, Lighthouse CI for performance regression, screenshot diffing for visual QA.

## Superseded or Historical Documentation

- `landing/README.md` (kept — minimal Astro starter description)
- (zombie clone) `~/Documents/Apps/FormulaeApps/formulae-landing/MASTER_SPEC.md` — `discarded` per `audit/working-trees-2026-05-18.md` § T014.

## Cross-references

- Feature 002 spec: [`../specs/002-formulae-fe-be-sync/spec.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/spec.md)
- Infra-validate report: [`../specs/002-formulae-fe-be-sync/audit/infra-validate-pre.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/audit/infra-validate-pre.md)
- Working-trees audit (landing row): [`../specs/002-formulae-fe-be-sync/audit/working-trees-2026-05-18.md`](../../../Documents/Apps/specs/002-formulae-fe-be-sync/audit/working-trees-2026-05-18.md)
- Workspace MASTER_SPEC: [`../../../Documents/Apps/FormulaeApps/MASTER_SPEC.md`](../../../Documents/Apps/FormulaeApps/MASTER_SPEC.md)
- Sibling apps: [`../pro/MASTER_SPEC.md`](../pro/MASTER_SPEC.md), [`../community/MASTER_SPEC.md`](../community/MASTER_SPEC.md), [`../bff/README.md`](../bff/README.md)
