# Formulae web release candidates

The workflow `.github/workflows/deploy-web.yml` builds the landing and Pro web
artifacts manually from the exact current `main` SHA. It does **not** deploy to
production.

## Current status

The first automatic run (`29265090762`) failed before upload:

- the landing runner used Node 20 while Astro requires Node 22.12 or newer;
- the Pro build did not have `FORMULAE_JWT_SHARED_SECRET` configured;
- the production upload job was skipped, so the live sites were not changed.

The former FTP job was removed because it disabled certificate verification,
ran on a build runner, had no protected environment, and had no exact-main,
backup, smoke, or rollback gate. A failed build must never become a partial
landing/Pro production update.

## What the workflow does

1. Verifies that the selected workflow ref is the exact current `origin/main`
   40-character SHA.
2. Builds, lints, and tests the Astro landing with Node 22 and Bun.
3. Builds the Pro web application only when the required build configuration is
   present.
4. Uploads SHA-named GitHub artifacts with a 14-day retention period.

The two build jobs may run in parallel after the exact-main preflight. Neither
job receives production FTP credentials.

## Required before production deployment is re-enabled

- Create a protected `production` GitHub environment with an explicit reviewer
  and production-scoped credentials.
- Use a dedicated `deploy-only` runner. Build and policy runners must not
  receive production credentials.
- Require FTPS with a hostname whose certificate validates. Do not disable TLS
  certificate verification or allow plaintext fallback.
- Promote the already-built SHA-named artifacts; do not rebuild during deploy.
- Capture a restorable remote snapshot before mutation.
- Make landing and Pro promotion recoverable as one release decision.
- Run HTTP and content smokes for `formulaeapps.com` and
  `app.formulaeapps.com` and restore the prior release automatically on failure.
- Record the release SHA, artifact digests, deployment run, smoke result, and
  rollback point.

Until those controls have executable evidence, production remains a separate
manual operator procedure and this workflow is build-only.
