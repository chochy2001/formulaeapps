# FormulaeApps BFF

Backend-for-Frontend for FormulaeApps Pro + Community. Proxies LLM chat through **OpenRouter** with JWT verification (so the FE can swap models per-task and adopt new ones without a redeploy), exposes un endpoint de validación IAP Apple/Google que falla cerrado hasta contar con validadores reales, and issues short-lived session JWTs to the FE clients.

> **Estado verificado localmente, 2026-07-13**: `bun run typecheck` y
> `bun test` pasan con 138 pruebas en el checkout auditado. IAP falla cerrado
> con `503 E_IAP_VALIDATION_UNAVAILABLE` fuera de desarrollo mientras los
> validadores reales no estén listos. La configuración actual de GitHub no
> exige checks verdes en `main`; por ello estos resultados no son una
> declaración de CI, despliegue o entitlement productivo.

## Stack

| Layer | Choice | Why |
|-------|--------|-----|
| Runtime | **Bun 1.3+** | Workspace default (CLAUDE.md); fast cold-start; built-in test runner |
| Framework | **Hono 4.x** | Portable across Bun/Node/Deno/Edge; great DX |
| Validation + OpenAPI | **@hono/zod-openapi + Zod 4.4.3** | Single source of truth: Zod schemas drive request validation AND the OpenAPI export |
| Auth | **jose** (HS256 JWT) | BFF-issued session tokens, ≤60 min lifetime |
| IAP — Apple | **@apple/app-store-server-library** | Official Apple Node SDK |
| IAP — Google | **googleapis** | Official Google SDK |
| Logging | **hono/logger** + custom JSON serializer | Structured, redacted of secrets |
| Tests | **bun test** | Built-in; `hono/testing` for in-process HTTP simulation |

Estado y limitaciones actuales: [`../docs/AUDITORIA_FUNCIONAL_2026-07-13.md`](../docs/AUDITORIA_FUNCIONAL_2026-07-13.md).

## Quick start

```bash
# 1. Install deps
bun install

# 2. Copy env (NEVER commit real values)
cp .env.example .env
#    edit .env: set JWT_SHARED_SECRET = `openssl rand -hex 32`,
#              set JWT_SIGNING_SECRET = a separate `openssl rand -hex 32`,
#              set OPENROUTER_API_KEY (get from https://openrouter.ai/keys)

# 3. Run in dev (live reload)
bun run dev                       # http://localhost:3000

# 4. Test (see the verified current count in "Tests" below)
bun test                          # unit + integration
bun test --watch                  # TDD loop

# 5. Typecheck
bun run typecheck                 # tsc --noEmit, no source emit

# 6. Regenerate OpenAPI artifact at ../contracts/bff.openapi.yaml
bun run build:openapi

# 7. Local Docker run (explicit overlay; binds only 127.0.0.1:3001 → container 3000)
# bff/.env is for direct `bun run dev`; export values for Docker interpolation.
export JWT_SHARED_SECRET="local-dev-secret-replace-this-please-32chars-min"
export JWT_SIGNING_SECRET="$(openssl rand -hex 32)"
export OPENROUTER_API_KEY="your-local-key" # optional unless exercising chat
cd .. && docker compose -f docker-compose.yml -f docker-compose.local.yml up -d bff
curl http://localhost:3001/health
docker compose -f docker-compose.yml -f docker-compose.local.yml down
```

For local Docker Compose testing, see the monorepo root `docker-compose.yml`,
explicit `docker-compose.local.yml`, and the current root `README.md`. The local
overlay resets the VPS-only root `.env` and IAP secret mounts, binds the BFF to
loopback only, and never supplies a deterministic signing secret. It also
passes both `FORMULAE_BFF_BASE_URL=http://localhost:3001` and
`FORMULAE_BFF_CHAT_URL=http://localhost:3001/openai/chat` to a local Pro web
build. IAP remains on its explicit development stub (never a production
validator). A running local BFF on port 3001 is only needed
to actively prove the CORS preflight; never commit real secrets.

## Source layout (current state)

```
bff/
├── src/
│   ├── index.ts                # Hono app entry, middleware + route registration
│   ├── lib/
│   │   ├── env.ts              # Zod-validated env parsing, placeholder-rejection in prod
│   │   ├── openapi.ts          # @hono/zod-openapi wiring + AppEnv type
│   │   └── jwt.ts              # jose HS256 issue/verify, shouldRefresh helper
│   ├── schemas/                # Zod schemas — single source of truth
│   │   ├── auth.ts             # AuthTokenRequest/Response (E1, E2)
│   │   ├── chat.ts             # ChatRequest/Response/Usage (E4, E5)
│   │   ├── iap.ts              # IapValidate* (E6, E7)
│   │   ├── error.ts            # ErrorEnvelope + ErrorKind enum (E8)
│   │   ├── health.ts           # HealthResponse (E9)
│   │   └── prompts.ts          # 22 versioned system prompts moved from Pro client
│   ├── middleware/
│   │   ├── jwt-auth.ts         # Bearer verification
│   │   ├── cors.ts             # Exact-match allowlist (dev-friendly)
│   │   ├── logger.ts           # Structured JSON logs, redacted, X-Request-Id propagation
│   │   └── error.ts            # ErrorEnvelope mapper + BffError throw helper
│   ├── services/
│   │   ├── jwt-issuer.ts          # Verify client_proof HMAC; issue session JWT
│   │   ├── openrouter-proxy.ts    # Server-side OpenRouter; injects system prompts; HTTP-Referer + X-Title attribution; allowlist-gated provider/model selection; usage invariant
│   │   ├── apple-iap.ts           # Stub + real validator (real defers to live integration)
│   │   └── google-iap.ts          # Stub + real validator (real defers to live integration)
│   └── routes/
│       ├── health.ts           # GET /health
│       ├── auth.ts             # POST /auth/token
│       ├── chat.ts             # POST /openai/chat (JWT-gated, X-Auth-Refresh rotation)
│       └── iap.ts              # POST /iap/validate (JWT-gated)
├── scripts/
│   └── export-openapi.ts       # Writes ../contracts/bff.openapi.yaml
├── tests/
│   ├── setup.ts                # Preloaded env for deterministic tests
│   ├── unit/                   # jwt + openrouter-proxy + apple-iap + google-iap
│   └── integration/            # health + auth-flow + chat-flow + iap-flow
├── Dockerfile                  # Multi-stage Bun + Alpine; non-root
├── package.json
├── tsconfig.json
├── bunfig.toml                 # bun:test preload = tests/setup.ts
├── bun.lock                    # tracked for reproducibility (Bun 1.2+ text lockfile)
├── .env.example                # placeholders only
├── .gitignore
└── README.md                   # this file
```

## Nota de tamaño por verificar

El tamaño actual de la imagen no se midió en este checkout y no debe afirmarse
como una métrica vigente. `googleapis` puede aportar un peso significativo por
sus muchos módulos; opciones a evaluar con una medición reproducible son:

- Replace `googleapis` with `googleapis-common-types` + targeted androidpublisher client (manual fetch + service-account JWT auth). Drops ~150 MB.
- Use Bun-native bundler (`bun build src/index.ts --target bun --outfile dist/server`) to ship a single binary with tree-shaken dependencies. Drops ~50-100 MB more.
- Switch base image to `oven/bun:1.3-distroless` (smaller).

No dar por hecho que la imagen, sus permisos o el presupuesto del VPS están
validados hasta construirla y probarla contra el entorno de promoción.

## Deployment

El host de despliegue y su estado actual no se verificaron en este checkout.
`../docker-compose.yml` declara el servicio BFF, pero un despliegue también
requiere secretos autorizados, persistencia para las bases SQLite y validación
en el VPS. No ejecutar una promoción basándose sólo en este README.

The current release controls and known runtime blockers are documented in [`../docs/DEPLOY_CI_WEB.md`](../docs/DEPLOY_CI_WEB.md) and [`../docs/AUDITORIA_FUNCIONAL_2026-07-13.md`](../docs/AUDITORIA_FUNCIONAL_2026-07-13.md).

## Contracts

The runtime-exported OpenAPI 3.1 contract lives at `../contracts/bff.openapi.yaml`. It is **generated** by `bun run build:openapi` from the Zod schemas under `src/schemas/`. Never hand-edit either the YAML or the generated FE Dart types under `../pro/packages/formulaeapps_bff_client/` and `../community/packages/formulaeapps_bff_client/`; drift is detected by `../scripts/verify-parity.sh` and fails CI.

## Security

- **Two distinct secrets** guard session auth:
  - `JWT_SHARED_SECRET` is the **client-shared** key used for the `client_proof`
    HMAC. It is baked into the Flutter client bundles (`--dart-define`) and is
    therefore recoverable from a deployed web bundle / APK — treat it as a
    deterrent, not a strong identity proof.
  - `JWT_SIGNING_SECRET` is the **server-only** key used to sign/verify session
    JWTs (HS256). It never ships in any client build, so a leaked
    `JWT_SHARED_SECRET` cannot be used to forge valid session tokens.
  - New session JWTs are signed **only** with `JWT_SIGNING_SECRET`; there is no
    fallback to `JWT_SHARED_SECRET`. Staging and production fail closed unless
    the signing secret is exactly 64 hexadecimal characters, differs from the
    shared secret, and contains neither whitespace, placeholder text, nor an
    obvious weak pattern. These are format/obviousness defenses, not a
    mathematical proof of entropy; generate 32 random bytes with a CSPRNG.
  - During migration only, legacy JWTs can be verified with
    `JWT_SHARED_SECRET` when `JWT_LEGACY_VERIFY_ENABLED=true` **and** the current
    time is within the immutable absolute UTC
    `[JWT_LEGACY_VERIFY_START, JWT_LEGACY_VERIFY_CUTOFF)` interval. At the exact
    cutoff millisecond, legacy verification stops. Startup validates that
    cutoff is after start and the total fixed interval is at most two hours; it
    never derives either instant from process start, so restarts cannot extend
    the window.
  - Existing client builds remain compatible because clients use
    `JWT_SHARED_SECRET` only for `client_proof`; they never sign session JWTs.
- OpenAI / OpenRouter key lives ONLY in BFF env — never in client builds.
- `/auth/token` uses a constant-time (`crypto.timingSafeEqual`) `client_proof`
  comparison. Because the request contract is fixed (deployed Pro/Community
  clients send exactly `HMAC(client_id + build_nonce)` with no timestamp/nonce —
  changing that would 401 every live install), replay is bounded by an
  in-memory **per-proof throttle**: the same valid proof may mint at most a few
  tokens per short window (a legitimate install re-mints ~once per ~55 min and
  never approaches it; a captured proof replayed at volume trips it with `429`
  `E_PROOF_REPLAY`). Stronger, fully replay-proof identity (device attestation /
  asymmetric tokens) is tracked as future work — see the PR description.
- **In-process rate limiting** (defense-in-depth under the Traefik
  `api-ratelimit@file` edge middleware) caps `/auth/token` and `/openai/chat`
  per client IP; a tripped limit returns `429` + `rate_limited` with a
  `Retry-After` header.
- Apple p8 / Google SA via compose secret file mounts at `/run/secrets/{apple_p8,google_sa}` in production. The explicit local overlay mounts neither, so IAP stays fail-closed.
- Placeholder secret values (e.g., `PLACEHOLDER_DEV_NOT_FOR_PROD`, empty string) are rejected at runtime in production mode.
- CORS allowlist is exact-match; no wildcards in production.
- Structured logs redact JWT contents, OpenAI key, IAP receipt bodies, and PII.

### Zero-downtime JWT key migration runbook

This is an operator procedure, not an automated deploy. Do not print either
secret, token values, or environment-file contents in terminals or CI logs.

1. Provision a strong, distinct `JWT_SIGNING_SECRET` through the approved
   server-only secret-management path. Keep `JWT_SHARED_SECRET` unchanged
   because deployed clients still need it for `client_proof`.
2. Set `JWT_LEGACY_VERIFY_ENABLED=true` with immutable absolute UTC
   `JWT_LEGACY_VERIFY_START` and `JWT_LEGACY_VERIFY_CUTOFF` values. Cutoff must
   be after start, no more than two hours later, and late enough for the final
   legacy token to expire. Record these values in the change ticket; never
   regenerate them during a restart or rollback.
3. Deploy the dual-key BFF through the normal staging-first promotion path.
   Confirm every old instance has left service; only the dual-key version may
   issue tokens from this point onward.
4. Smoke `/health`, mint a session through the existing authenticated client
   flow, and call one JWT-protected endpoint. Confirm the minted token works
   without logging its value. Also confirm an existing pre-cutover session
   remains accepted during the grace window.
5. Wait at least 60 minutes plus the chosen margin after the final old instance
   stopped issuing legacy-signed JWTs. Do not shorten the absolute cutoff.
6. Remove legacy verification by setting `JWT_LEGACY_VERIFY_ENABLED=false` and
   clearing both migration timestamps; do **not** remove `JWT_SHARED_SECRET`.
   Recreate only the BFF through the approved deployment workflow.
7. Repeat the health, token-mint, and protected-endpoint smoke. A retained
   pre-cutover token must now receive `401`; a newly minted token must succeed.

Rollback strategy: **prefer roll-forward to the last known-good dual-key
artifact**, keeping the server-only `JWT_SIGNING_SECRET` provisioned and
unchanged. Repeat the smoke checks without printing token or secret values.

**A pre-dual-key binary is NOT a safe rollback artifact.** It cannot verify both
legacy and newly signed sessions, and it can resume signing with the
client-shared key. Do not deploy one during or after migration. If the current
dual-key release is unhealthy, roll forward to a corrected dual-key artifact or
restore a previously validated dual-key artifact; never revert the signing
secret to `JWT_SHARED_SECRET`.

Before any release or rollback, run the executable artifact gate from a
checkout that already contains `scripts/verify-jwt-release-artifact.sh` (the
workflow ref / current dual-key-capable head). The script inspects the
*candidate* commit's blobs via `git show`; it does not require the candidate
tree to provide the gate script. The earliest allowed rollback SHA is
`5a7795f657283f1b47069ef026ef864d3a65f73c` (exclusive signing + immutable UTC
window). Earlier dual-key SHAs that recomputed grace from process start are
rejected. Rollback also requires explicit confirmation that the runtime keeps
the existing server-only signing key:

```bash
bash scripts/verify-jwt-release-artifact.sh <candidate-sha>
bash scripts/verify-jwt-release-artifact.sh <candidate-sha> \
  --rollback --keep-signing-secret
```

The release workflow checks out the workflow ref to run this gate, then checks
out the same `candidate_sha` for behavioral tests and infrastructure
validation. It blocks commits predating validated fixed-window dual-key
support or source that can fall back to signing with `JWT_SHARED_SECRET`.

## Tests

```bash
bun test                  # all
bun test tests/unit/      # unit only
bun test tests/integration/  # integration only
```

Coverage target: every route has at least one success-path and one primary-failure-path test. **Última ejecución local, 2026-07-13: 138 pruebas pasan** con `bun test`; no es una medición de cobertura ni una aprobación de producción.

## R12+R13 additions (2026-05-19)

### `probe-allowlist` — OpenRouter catalog drift detector

```bash
bun run probe:allowlist
```

Queries `https://openrouter.ai/api/v1/models` and exits non-zero if any model in `OPENROUTER_MODEL_ALLOWLIST` is missing from the live catalog. Caught two silent removals from OpenRouter during R11+R12 (`google/gemini-2.0-flash-exp`, `anthropic/claude-3.5-sonnet`).

Se ejecuta manualmente o desde un workflow que se configure y verifique de
forma explícita. No asumir un gate existente sólo por este comando.

### `iap-availability` service + startup check

`src/services/iap-availability.ts` (R12) detects placeholder env vars + missing/empty/malformed secret files. The `/iap/validate` handler calls it at the top of every request; on `!available` it returns HTTP 503 + ErrorEnvelope `code: 'E_IAP_VALIDATION_UNAVAILABLE'` instead of letting the Apple/Google SDK construction fail with cryptic messages.

Startup emits one warn line per platform check:

```
[iap] startup check: apple=ok|missing(<reason>) google=ok|missing(<reason>)
```

Reason tokens include `apple_not_configured`, `google_not_configured`, missing/
placeholder secret reasons and `apple_validator_not_ready` /
`google_validator_not_ready`. The integration test suite at
`tests/integration/iap-availability.test.ts` covers the 503 path for both
platforms; development alone retains the explicit `valid:false` stub.

### Historical production snapshot (2026-05-19)

| Endpoint | Status |
|---|---|
| `https://api.formulaeapps.com/health` | Observed HTTP 200, but reports deployed contract 1.0.0; source/artifact provenance is unverified |
| `https://api.formulaeapps.com/auth/token` | Route exists in the deployed 1.0.0 contract; live auth behavior was not reverified in this checkout |
| `https://api.formulaeapps.com/openai/chat` | Route exists in the deployed 1.0.0 contract; do not claim a live provider roundtrip without a protected smoke |
| `https://api.formulaeapps.com/iap/validate` | 503 + `E_IAP_VALIDATION_UNAVAILABLE` until real Apple/Google secrets dropped (T061) |
| TLS | Let's Encrypt via Traefik DNS-01 (Cloudflare token) |
| CORS | Exact-match `https://app.formulaeapps.com` + `https://formulaeapps.com` (no wildcards) |

## Related docs

- Current audit: [`../docs/AUDITORIA_FUNCIONAL_2026-07-13.md`](../docs/AUDITORIA_FUNCIONAL_2026-07-13.md)
- Contract workflow: [`../contracts/README.md`](../contracts/README.md)
- Workspace constitution: `/Users/jorge/Documents/Apps/.specify/memory/constitution.md`
