# Formulae web release candidates

The workflow `.github/workflows/deploy-web.yml` builds the landing and Pro web
artifacts manually from the exact current `main` SHA and then promotes them to
production through a dedicated FTPS job.

## Current status

The following failures are historical; none changed production:

- run `29265090762` used an unsupported Node version for the landing and did
  not have the required Pro build configuration;
- run `29267520787` could not write Node 22 to the test runner tool cache and
  did not have `FORMULAE_JWT_SHARED_SECRET` configured;
- run `29271110965` also failed while creating the Node tool-cache directory
  with `EACCES`;
- at that time the production upload job did not exist, so uploads were skipped.

The code from PR [#79](https://github.com/CAPDESIS/formulaeapps/pull/79) is
integrated in `main`; PR [#83](https://github.com/CAPDESIS/formulaeapps/pull/83)
made Flutter test concurrency explicit, and PR
[#84](https://github.com/CAPDESIS/formulaeapps/pull/84) recorded the integration
and release blockers. At `2026-07-14T02:50:46Z`, the dispatches for code SHA
`b909676d11e5e789811409c2968541d191c3bb9f` were
[CI `29302052034`](https://github.com/CAPDESIS/formulaeapps/actions/runs/29302052034)
and [Build Web Release Candidate `29302052031`](https://github.com/CAPDESIS/formulaeapps/actions/runs/29302052031).
The candidate completed with the exact-SHA guard failing correctly after
`main` advanced beyond `b909676`; no Pro or landing artifact was built. The
CI is not green or terminal: its landing unit-test step passed, then its
landing lint step failed, while other jobs remain in progress, queued or
cancelled. There is no candidate for the newer documentation-only `main`
state. The older `081aa889` dispatches `29301504493` and `29301504487` were
cancelled and are not current evidence. No production system changed.

The FTPS promotion job now exists in `.github/workflows/deploy-web.yml` and
runs on a dedicated `deploy-only` runner inside a protected `production`
environment. It connects to Hostinger IP `31.170.161.105` with
`ssl:check-hostname false` while we wait for the real hostname from the user.
That interim configuration validates the server certificate chain but does not
verify the hostname; the target remains hostname-verified FTPS as soon as the
real hostname is provisioned. The upload uses `mirror --reverse` without
`--delete`, so a failed run cannot wipe the live site, and a post-deploy smoke
checks landing, app, sample images, and release markers. A failed build must
never become a partial production update.

## What the workflow does

1. Verifies that the selected workflow ref is the exact current `origin/main`
   40-character SHA.
2. Builds, lints, and tests the Astro landing with Node 24 and Bun 1.3.14.
3. Builds the Pro web application only when the required build configuration is
   present.
4. Uploads SHA-named GitHub artifacts with a 14-day retention period.
5. Promotes the validated artifacts to production through the FTPS job when the
   required secrets and environment are present.

The two build jobs may run in parallel after the exact-main preflight. Only the
`deploy` job receives production FTPS credentials.

## Current build blockers

- Restore sufficient Formulae-authorized capacity for `test-light`,
  `build-heavy` and `policy-light`; do not bypass the restricted workflow
  allowlist of a laptop or move secrets to a non-approved group merely to
  drain the remaining queue.
- Landing lint on main failed when `astro check` ran under runner Node 20
  (`29302052034` / `29324249766`). CI now installs Node `24` in the landing job
  before lint/build; do not treat unit tests alone as the landing gate.
- Pro/Community analyze on those runs was green; jobs died mid-test when the
  self-hosted runner lost communication under parallel Flutter load. CI now
  runs those jobs on `build-heavy` and serializes Community after Pro.
- Provision `FORMULAE_JWT_SHARED_SECRET` through the approved secret store and
  scope it only to the build that requires it. Never record the value in this
  repository or in workflow logs.

## Production deployment controls

The following controls are in place in `deploy-web.yml`:

- A protected `production` GitHub environment with a `deploy-only` runner.
- FTPS is forced (`ftp:ssl-force true`, `ftp:ssl-protect-data true`) and the
  server certificate chain is verified (`ssl:verify-certificate true`).
- Promotion uses the already-built SHA-named artifacts; the deploy job does not
  rebuild.
- A post-deploy smoke checks landing, app, sample images, and release markers.
- Release markers are written to `release-sha.txt` in both artifacts.

Remaining hardening target:

- **Require FTPS with a hostname whose certificate and hostname both validate.**
  The current job connects to Hostinger IP `31.170.161.105` with
  `ssl:check-hostname false` while we wait for the real hostname from the user.
  Do not treat the IP-based interim as the final security posture; switch to a
  hostname-verified endpoint as soon as it is provisioned.

Additional controls still required before treating the pipeline as fully
production-ready:

- Capture a restorable remote snapshot before mutation.
- Make landing and Pro promotion recoverable as one release decision with an
  executable rollback (currently manual: re-run the workflow at the previous
  good SHA; artifacts are retained 14 days).
- Record the release SHA, artifact digests, deployment run, smoke result, and
  rollback point.
- Require the relevant CI and release-policy checks before promotion.

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
