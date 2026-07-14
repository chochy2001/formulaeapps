# Formulae web release candidates

The workflow `.github/workflows/deploy-web.yml` builds the landing and Pro web
artifacts manually from the exact current `main` SHA. It does **not** deploy to
production.

## Current status

Two automatic runs failed before upload, and neither changed production:

- run `29265090762` used an unsupported Node version for the landing and did
  not have the required Pro build configuration;
- run `29267520787` could not write Node 22 to the test runner tool cache and
  did not have `FORMULAE_JWT_SHARED_SECRET` configured;
- both production upload jobs were skipped.

The FTP job is disabled because the attempted promotion path still lacked an
authenticated FTPS endpoint, a protected `production` environment, a dedicated
deploy runner, an atomic landing/Pro release, a release-specific smoke, and an
executable rollback. A failed build must never become a partial production
update.

## What the workflow does

1. Verifies that the selected workflow ref is the exact current `origin/main`
   40-character SHA.
2. Builds, lints, and tests the Astro landing with Node 22 and Bun.
3. Builds the Pro web application only when the required build configuration is
   present.
4. Uploads SHA-named GitHub artifacts with a 14-day retention period.

The two build jobs may run in parallel after the exact-main preflight. Neither
job receives production FTP credentials.

## Current build blockers

- Correct ownership of the `test-light` runner tool cache before relying on
  `actions/setup-node` there.
- Provision `FORMULAE_JWT_SHARED_SECRET` through the approved secret store and
  scope it only to the build that requires it. Never record the value in this
  repository or in workflow logs.

## Required before production deployment is re-enabled

- Create a protected `production` GitHub environment with an explicit reviewer
  and production-scoped credentials.
- Use a dedicated `deploy-only` runner. Build and policy runners must not
  receive production credentials.
- Require FTPS with a hostname whose certificate and hostname both validate.
  Do not connect by IP with hostname verification disabled or allow plaintext
  fallback.
- Promote the already-built SHA-named artifacts; do not rebuild during deploy.
- Capture a restorable remote snapshot before mutation.
- Make landing and Pro promotion recoverable as one release decision.
- Publish a release marker and use cache-bypassed HTTP/content smokes to prove
  that the requested SHA is live.
- Restore the prior release automatically when upload or smoke fails.
- Record the release SHA, artifact digests, deployment run, smoke result, and
  rollback point.
- Require the relevant CI and release-policy checks before promotion.

Until those controls have executable evidence, production remains a separate
manual operator procedure and this workflow is build-only.

## Formulae image asset promotion

The Formulae applications consume 176 language-neutral routes under
`https://formulaeapps.com/imagenes/`. The asset source of truth is
`landing/public/imagenes/`, together with the compatibility redirects in
`landing/public/.htaccess` and `landing/nginx.conf`.

Before an authorized promotion, run:

```bash
cd landing
bun install --frozen-lockfile
bun run lint
bun run test
bun run build
bun run check:formulae-images
```

After the promoted artifact is live and cache bypass is available, run:

```bash
bun run check:formulae-images:remote
```

This is a post-promotion smoke, not a CI gate. As of 2026-07-13 it fails 176
of 176 routes because the current host returns 404; do not mark the asset
promotion complete until it passes. See
[`AUDITORIA_FUNCIONAL_2026-07-13.md`](AUDITORIA_FUNCIONAL_2026-07-13.md) for
the verified scope and remaining PDF/runtime blockers.
