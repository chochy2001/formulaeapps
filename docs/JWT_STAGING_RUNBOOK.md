# FormulaeApps BFF — JWT dual-key staging runbook (draft)

Operator procedure for validating the dual-key JWT migration on `staging-node`
before any production promotion. This does **not** provision production secrets
or enable daily production deploys.

## Prerequisites (human-approved)

1. `staging` GitHub environment with required reviewers (configure in repository
   Settings → Environments).
2. Repository secrets: `STAGING_SSH_HOST`, `STAGING_SSH_USER`, `STAGING_SSH_KEY`,
   `STAGING_SSH_KNOWN_HOSTS`. Optional: `STAGING_SSH_PORT`.
3. Repository variable: `STAGING_APP_PATH` (default
   `/opt/staging/apps/formulaeapps`).
4. Repository variable: `STAGING_BFF_BASE_URL` (staging Traefik route, e.g.
   `https://staging.api.formulaeapps.com`).
5. Host file `/opt/staging/apps/formulaeapps/.env.staging` with:
   - `BFF_ENV=staging`
   - `JWT_SHARED_SECRET` (existing client-shared key, unchanged)
   - `JWT_SIGNING_SECRET` (new server-only 64-hex value, independently generated)
   - `OPENROUTER_API_KEY`
   - Migration window for smokes (required):
     `JWT_LEGACY_VERIFY_ENABLED=true`,
     `JWT_LEGACY_VERIFY_START=<absolute UTC ISO-8601 Z>`,
     `JWT_LEGACY_VERIFY_CUTOFF=<absolute UTC ISO-8601 Z>` (max 2 hours after start)

Never print secret values, token payloads, or full `.env` contents in terminals,
CI logs, or tickets. Record only secret **names**, presence booleans, and
redacted format-validation results.

## Candidate selection

1. Choose a **full 40-hex SHA** contained in `origin/main`.
2. Run the executable artifact gate from a dual-key-capable checkout:

   ```bash
   bash scripts/verify-jwt-release-artifact.sh <candidate-sha>
   ```

3. Reject any candidate not descended from the canonical dual-key squash on
   `main` or that can sign with `JWT_SHARED_SECRET`.

## Staging deploy (workflow_dispatch)

Workflow: `.github/workflows/deploy-staging-bff.yml`

Inputs:

| Input | Required | Notes |
|---|---|---|
| `candidate_sha` | yes | Full 40-hex SHA on `main` |
| `legacy_verify_start` | yes | Absolute UTC `Z` start of legacy verification window |
| `legacy_verify_cutoff` | yes | Absolute UTC `Z` cutoff; must be within (0, 2h] after start |
| `rollback` | no | Set true only for rollback validation |
| `keep_signing_secret` | no | Required with `rollback=true` |

The workflow:

1. Fetches `origin/main`, validates `candidate_sha` format and main membership.
2. Validates the legacy window pair with `scripts/validate-legacy-window.sh`.
3. Runs JWT artifact gate + BFF typecheck/tests/build on the candidate.
4. Rsyncs the candidate to `staging-node` and deploys with
   `docker compose -f docker-compose.staging.yml -p formulaeapps-staging` only
   (no `docker-compose.override.yml`, no production domains/networks).
5. Verifies `DEPLOYED_SHA` on the host matches the candidate.
6. Checks secret **presence and format** on the host (redacted).
7. Runs mandatory `scripts/jwt-staging-smoke.sh` on the host (mint, protected
   route, legacy grace/cutoff/post-cutoff). Rejects HTTP 502.
8. Auto-rolls back to the prior artifact on deploy/smoke failure while
   preserving `JWT_SIGNING_SECRET`.

## Smoke expectations (mandatory)

| Check | Pass criterion |
|---|---|
| `/health` | HTTP 200, `status=ok` |
| `/auth/token` empty body | HTTP 400 (schema rejection) |
| `/openai/chat` no JWT | HTTP 401 |
| Mint + protected route | HTTP 200 with non-empty `message` payload |
| Legacy token during grace | HTTP 200 inside `[start, cutoff)` |
| Legacy token at cutoff | HTTP 401 at exact cutoff |
| Legacy token after cutoff | HTTP 401 |

Smokes read `JWT_SHARED_SECRET` from the host `.env` and never print bearer
tokens or secret values.

## Rollback

- **Allowed**: roll forward or restore a dual-key artifact that passes
  `verify-jwt-release-artifact.sh --rollback --keep-signing-secret`, keeping the
  existing `JWT_SIGNING_SECRET` unchanged.
- **Prohibited**: rollback to pre-dual-key binaries or any artifact that resumes
  signing with `JWT_SHARED_SECRET`.
- **Automatic**: failed deploy or smoke triggers `scripts/staging-rollback-remote.sh`.

## Production promotion gate

Do not promote until:

1. Staging workflow is green on the same `candidate_sha`.
2. `JWT_SIGNING_SECRET` is provisioned on production (presence + format only).
3. Legacy window timestamps are recorded in the change ticket.
4. Monday/manual promotion policy and open-alert checks pass per the Capdesis
   fleet release policy documented in the workspace `docs/STAGING_RELEASE_POLICY.md`
   file (maintained outside this repository).
