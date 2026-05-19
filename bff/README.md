# FormulaeApps BFF

Backend-for-Frontend for FormulaeApps Pro + Community. Proxies LLM chat through **OpenRouter** with JWT verification (so the FE can swap models per-task and adopt new ones without a redeploy), validates Apple/Google IAP receipts server-side, and issues short-lived session JWTs to the FE clients.

> **Status**: implementation complete locally (Phase 4 US6 T021–T071, except VPS cutover T060–T068). 32/32 unit + integration tests pass via `bun test` (was 31 pre-OpenRouter migration; +1 multi-provider test). `bun run typecheck` clean. Docker image builds, `docker compose up -d bff` reports healthy in < 60s. VPS Contabo cutover is the remaining gating step.

## Stack

| Layer | Choice | Why |
|-------|--------|-----|
| Runtime | **Bun 1.3+** | Workspace default (CLAUDE.md); fast cold-start; built-in test runner |
| Framework | **Hono 4.x** | Portable across Bun/Node/Deno/Edge; great DX |
| Validation + OpenAPI | **@hono/zod-openapi + Zod 3.x** | Single source of truth: Zod schemas drive request validation AND the OpenAPI export |
| Auth | **jose** (HS256 JWT) | BFF-issued session tokens, ≤60 min lifetime |
| IAP — Apple | **@apple/app-store-server-library** | Official Apple Node SDK |
| IAP — Google | **googleapis** | Official Google SDK |
| Logging | **hono/logger** + custom JSON serializer | Structured, redacted of secrets |
| Tests | **bun test** | Built-in; `hono/testing` for in-process HTTP simulation |

Full rationale: [`../specs/002-formulae-fe-be-sync/research.md`](../specs/002-formulae-fe-be-sync/research.md) §§ R1, R4, R5, R9, R11, R12.

## Quick start

```bash
# 1. Install deps
bun install

# 2. Copy env (NEVER commit real values)
cp .env.example .env
#    edit .env: set JWT_SHARED_SECRET = `openssl rand -hex 32`,
#              set OPENROUTER_API_KEY (get from https://openrouter.ai/keys)

# 3. Run in dev (live reload)
bun run dev                       # http://localhost:3000

# 4. Test (32 tests, ~100ms)
bun test                          # unit + integration
bun test --watch                  # TDD loop

# 5. Typecheck
bun run typecheck                 # tsc --noEmit, no source emit

# 6. Regenerate OpenAPI artifact at ../contracts/bff.openapi.yaml
bun run build:openapi

# 7. Local Docker run (uses ../docker-compose.override.yml; binds host port 3001 → container 3000)
cd .. && docker compose up -d bff
curl http://localhost:3001/health
docker compose down
```

For local docker compose testing: see the monorepo root `docker-compose.yml`. For the full reproducible flow including FE clients: see [`../specs/002-formulae-fe-be-sync/quickstart.md`](../specs/002-formulae-fe-be-sync/quickstart.md).

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

## Known size note

Current Docker image is **~341 MB** vs the 120 MB target in `research.md` § R11. Primary cause: the official `googleapis` npm package bundles many service modules. Optimization options for future work:

- Replace `googleapis` with `googleapis-common-types` + targeted androidpublisher client (manual fetch + service-account JWT auth). Drops ~150 MB.
- Use Bun-native bundler (`bun build src/index.ts --target bun --outfile dist/server`) to ship a single binary with tree-shaken dependencies. Drops ~50-100 MB more.
- Switch base image to `oven/bun:1.3-distroless` (smaller).

None are blocking — the container is functional and well within the workspace's VPS Contabo disk/memory budget.

## Deployment

Target host: **VPS Contabo** (resumed from pause). The existing `../docker-compose.yml:64` already declares `build: ./bff`, so once this directory is populated, `docker compose up -d bff` works.

Production cutover process: [`../specs/002-formulae-fe-be-sync/research.md`](../specs/002-formulae-fe-be-sync/research.md) §§ R6, R7 (VPS readiness checklist + Cloudflare DNS 3-phase cutover).

Secret provisioning: [`../specs/002-formulae-fe-be-sync/research.md`](../specs/002-formulae-fe-be-sync/research.md) § R16 (`/opt/infrastructure/secrets/formulaeapps-docker/`).

## Contracts

The runtime-exported OpenAPI 3.1 contract lives at `../contracts/bff.openapi.yaml`. It is **generated** by `bun run build:openapi` from the Zod schemas under `src/schemas/`. Never hand-edit either the YAML or the generated FE Dart types under `../pro/lib/generated/bff/` and `../community/lib/generated/bff/` — drift is detected by `../scripts/verify-parity.sh` and fails CI.

## Security

- JWT shared secret lives ONLY in env / compose secrets — never committed.
- OpenAI key lives ONLY in BFF env — never in client builds.
- Apple p8 / Google SA via compose secret file mounts at `/run/secrets/{apple_p8,google_sa}` (production) or `bff/secrets/` (development).
- Placeholder secret values (e.g., `PLACEHOLDER_DEV_NOT_FOR_PROD`, empty string) are rejected at runtime in production mode.
- CORS allowlist is exact-match; no wildcards in production.
- Structured logs redact JWT contents, OpenAI key, IAP receipt bodies, and PII.

## Tests

```bash
bun test                  # all
bun test tests/unit/      # unit only
bun test tests/integration/  # integration only
```

Coverage target: every route added in US6 has at least one success-path and one primary-failure-path test (SC-011). **Current: 35/35 pass** (R12 added 3 IAP-availability integration tests).

## R12+R13 additions (2026-05-19)

### `probe-allowlist` — OpenRouter catalog drift detector

```bash
bun run probe:allowlist
```

Queries `https://openrouter.ai/api/v1/models` and exits non-zero if any model in `OPENROUTER_MODEL_ALLOWLIST` is missing from the live catalog. Caught two silent removals from OpenRouter during R11+R12 (`google/gemini-2.0-flash-exp`, `anthropic/claude-3.5-sonnet`).

CI gate at `.github/workflows/probe-allowlist.yml` runs on push/PR to `src/lib/env.ts` or `scripts/probe-allowlist.ts`, plus monthly cron, plus `workflow_dispatch`. Bun pin `1.3.9`, GitHub-hosted `ubuntu-latest` (not self-hosted — see memory `feedback_runner_scope_capdesis`).

### `iap-availability` service + startup check

`src/services/iap-availability.ts` (R12) detects placeholder env vars + missing/empty/malformed secret files. The `/iap/validate` handler calls it at the top of every request; on `!available` it returns HTTP 503 + ErrorEnvelope `code: 'E_IAP_VALIDATION_UNAVAILABLE'` instead of letting the Apple/Google SDK construction fail with cryptic messages.

Startup emits one warn line per platform check:

```
[iap] startup check: apple=ok|missing(<reason>) google=ok|missing(<reason>)
```

Reason tokens: `apple_issuer_id_placeholder`, `apple_key_id_placeholder`, `apple_p8_file_missing`, `apple_p8_file_empty`, `apple_p8_file_not_pkcs8`, `google_sa_missing`, `google_sa_invalid_json`, `google_sa_missing_client_email`, `google_package_name_placeholder`. The integration test suite at `tests/integration/iap-availability.test.ts` covers the 503 path for both platforms.

### Production state (2026-05-19)

| Endpoint | Status |
|---|---|
| `https://api.formulaeapps.com/health` | 200 (Bun + Hono on Contabo `ancare`, image rebuilt from R13 source via rsync + `docker compose build bff`) |
| `https://api.formulaeapps.com/auth/token` | Mints valid JWTs after HMAC `client_proof` verification |
| `https://api.formulaeapps.com/openai/chat` | Real OpenRouter roundtrip (Gemini Flash Lite ~1.16 s; 6 models allowlisted) |
| `https://api.formulaeapps.com/iap/validate` | 503 + `E_IAP_VALIDATION_UNAVAILABLE` until real Apple/Google secrets dropped (T061) |
| TLS | Let's Encrypt via Traefik DNS-01 (Cloudflare token) |
| CORS | Exact-match `https://app.formulaeapps.com` + `https://formulaeapps.com` (no wildcards) |

## Related docs

- Feature spec: [`../specs/002-formulae-fe-be-sync/spec.md`](../specs/002-formulae-fe-be-sync/spec.md)
- Implementation plan: [`../specs/002-formulae-fe-be-sync/plan.md`](../specs/002-formulae-fe-be-sync/plan.md)
- Phase 0 research: [`../specs/002-formulae-fe-be-sync/research.md`](../specs/002-formulae-fe-be-sync/research.md)
- Data model: [`../specs/002-formulae-fe-be-sync/data-model.md`](../specs/002-formulae-fe-be-sync/data-model.md)
- Constitution: [`../.specify/memory/constitution.md`](../.specify/memory/constitution.md) v1.1.0
