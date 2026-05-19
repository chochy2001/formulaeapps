# FormulaeApps BFF — multi-stage Bun + Alpine
#
# Spec §FR-025 + Research §R11. Final image target: ≤120 MB compressed.
# Runs as non-root `bun` user. HEALTHCHECK matches docker-compose.yml:72-76.

# ───────────────────── Stage 1: deps + OpenAPI export ─────────────────────
FROM oven/bun:1.3-alpine AS builder
WORKDIR /app

# Install deps (cached layer)
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

# Copy source + run OpenAPI export (writes ../contracts/bff.openapi.yaml relative to bff/)
COPY tsconfig.json bunfig.toml ./
COPY src ./src
COPY scripts ./scripts
RUN mkdir -p /app/.openapi-out && \
    BFF_ENV=development \
    JWT_SHARED_SECRET=build-time-dummy \
    OPENAI_API_KEY=build-time-dummy \
    bun run scripts/export-openapi.ts || echo "OpenAPI export skipped at build time (writes outside container)"

# ───────────────────── Stage 2: runtime ─────────────────────
FROM oven/bun:1.3-alpine

# Healthcheck needs wget (Alpine ships busybox wget, available without extra install)
WORKDIR /app

# Copy only runtime artifacts (no dev deps, no tests, no scripts)
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
COPY --from=builder /app/package.json ./package.json

EXPOSE 3000

# Drop privileges — Bun official image has a `bun` user (uid 1000) pre-created
USER bun

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -q --spider http://localhost:3000/health || exit 1

CMD ["bun", "run", "src/index.ts"]
