# FormulaeApps BFF — JWT dual-key staging runbook (draft)

Operator procedure for validating the dual-key JWT migration on `staging-node`
before any production promotion. This does **not** provision production secrets
or enable daily production deploys.

## Prerequisites (human-approved)

1. `staging` GitHub environment with required reviewers (configure in repository
   Settings → Environments).
2. Staging environment secrets: `STAGING_SSH_HOST`, `STAGING_SSH_USER`,
   `STAGING_SSH_KEY`, `STAGING_SSH_KNOWN_HOSTS`. Optional: `STAGING_SSH_PORT`.
3. Repository variable: `STAGING_APP_PATH` (default
   `/opt/staging/apps/formulaeapps`).
4. The staging Traefik route must be exactly
   `https://staging.api.formulaeapps.com`; the workflow intentionally rejects
   configurable or production base URLs.
5. Host marker `/etc/capdesis-role` must contain exactly `staging`.
6. Persistent host file `/opt/staging/apps/formulaeapps/.env.staging` (outside
   immutable releases) with:
   - `BFF_ENV=staging`
   - `JWT_SHARED_SECRET` (existing client-shared key, unchanged)
   - `JWT_SIGNING_SECRET` (new server-only 64-hex value, independently generated)
   - `OPENROUTER_API_KEY`
   - Migration window for smokes (required):
     `JWT_LEGACY_VERIFY_ENABLED=true`,
     `JWT_LEGACY_VERIFY_START=<absolute UTC ISO-8601 Z>`,
     `JWT_LEGACY_VERIFY_CUTOFF=<absolute UTC ISO-8601 Z>` (max 20 minutes after
     start for staging deploy jobs; production policy remains 2 hours)

Never print secret values, token payloads, or full `.env` contents in terminals,
CI logs, or tickets. Record only secret **names**, presence booleans, and
redacted format-validation results.

## Immutable release layout

```
/opt/staging/apps/formulaeapps/
├── .env.staging                 # persistent secrets (0600), outside releases
├── .staging-state/deploy-state.json
├── current -> releases/<40hex>  # switched only after build + readiness
└── releases/<40hex>/           # rsync target per candidate SHA
```

- Rsync never uses `--delete` against the active release root.
- Rollback state lives in `.staging-state/` outside synced release trees.
- First deploy without an existing baseline is rejected unless an explicit
  bootstrap mode is approved separately (not enabled in this draft).

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
| `legacy_verify_cutoff` | yes | Absolute UTC `Z` cutoff; max 20m for staging jobs |
| `rollback` | no | Set true only for rollback validation |
| `keep_signing_secret` | no | Required with `rollback=true` |

The workflow:

1. Fetches `origin/main`, validates `candidate_sha` format and main membership.
2. Validates the legacy window pair with `scripts/validate-legacy-window.sh`
   (`STAGING_LEGACY_MAX_MS=1200000`).
3. Runs JWT artifact gate + BFF typecheck/tests/build on the candidate.
4. Rsyncs the candidate into `releases/<candidate_sha>/` on `staging-node`.
5. Deploys remotely with JSON stdin transport (no secret argv), builds/tags the
   immutable image, polls `/health`, then atomically switches `current`.
6. Verifies `current/DEPLOYED_SHA` matches the candidate.
7. Checks secret **presence and format** on the host (redacted).
8. Runs mandatory `scripts/jwt-staging-smoke.sh` on the host (mint, protected
   route, legacy grace/cutoff/post-cutoff). Rejects HTTP 502.
9. Auto-rolls back to the exact prior release/image on any post-sync failure;
   rollback failure keeps the workflow red.

## Smoke expectations (mandatory)

| Check | Pass criterion |
|---|---|
| `/health` | HTTP 200, `status=ok` |
| `/auth/token` empty body | HTTP 400 (schema rejection) |
| `/openai/chat` no JWT | HTTP 401 |
| Mint + protected route | HTTP 200 with non-empty `message` payload |
| Legacy token during grace | HTTP 200 inside `[start, cutoff)` |
| Legacy token at cutoff | HTTP 401 at cutoff boundary |
| Legacy token after cutoff | HTTP 401 |

Smokes read secrets from the host `.env` file and never print bearer tokens or
secret values. All curls use bounded `--connect-timeout` and `--max-time`.

## Rollback

- **Allowed**: roll forward or restore a dual-key artifact that passes
  `verify-jwt-release-artifact.sh --rollback --keep-signing-secret`, keeping the
  existing `JWT_SIGNING_SECRET` unchanged.
- **Prohibited**: rollback to pre-dual-key binaries or any artifact that resumes
  signing with `JWT_SHARED_SECRET`.
- **Automatic**: failed deploy/readiness/smoke triggers
  `scripts/staging_rollback_remote.py`, restoring the prior release symlink and
  tagged image without recompiling the candidate.

## Production promotion gate

Do not promote until:

1. Staging workflow is green on the same `candidate_sha`.
2. `JWT_SIGNING_SECRET` is provisioned on production (presence + format only).
3. Legacy window timestamps are recorded in the change ticket.
4. Monday/manual promotion policy and open-alert checks pass per the Capdesis
   fleet release policy documented in the workspace `docs/STAGING_RELEASE_POLICY.md`
   file (maintained outside this repository).
