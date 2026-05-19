# BFF Contracts

This directory holds the **runtime-generated** OpenAPI artifact derived from the BFF's Zod schemas (`bff/src/schemas/*.ts`). It is the canonical contract between the BFF and FE clients.

## DO NOT EDIT

The OpenAPI YAML in this directory is **generated** by `bun run build:openapi` (which calls `bff/scripts/export-openapi.ts`, which calls `@hono/zod-openapi`'s `getOpenAPI31Document()`).

Hand-edits will:

1. Be reverted by the next `bun run build:openapi`.
2. Trigger `scripts/verify-parity.sh` to fail in CI.
3. Make the FE Dart types under `pro/lib/generated/bff/` and `community/lib/generated/bff/` drift from the BFF code.

To change the contract: **edit the Zod schemas** under `bff/src/schemas/` and rerun the generators.

## Files

| File | Status | Notes |
|------|--------|-------|
| `bff.openapi.yaml` | 🤖 GENERATED (US3 will produce this) | Source: `bff/src/schemas/*.ts` via `@hono/zod-openapi` |
| `README.md` | Hand-written | This file |

The design-time blueprint for `bff.openapi.yaml` (what shape it should have, used to seed the Zod schemas) lives at `specs/002-formulae-fe-be-sync/contracts/bff.openapi.yaml`. Once US6 + US3 land, `~/Code/formulaeapps/contracts/bff.openapi.yaml` becomes the authoritative copy.

## Version policy

Per [`../specs/002-formulae-fe-be-sync/research.md`](../specs/002-formulae-fe-be-sync/research.md) § R13:

- **MAJOR** — breaking change (field renamed, response type changed, route removed).
- **MINOR** — additive (new route, new optional field, new error code).
- **PATCH** — non-semantic (description, example, examples).

The version lives in the Zod source (`bff/src/lib/openapi.ts`); diffs surface in PR review.

## Tooling

- Generate: `cd bff && bun run build:openapi` → writes `../contracts/bff.openapi.yaml`.
- Generate FE types: `bash scripts/generate-bff-types.sh` → writes Dart types in `pro/` and `community/`.
- Verify parity: `bash scripts/verify-parity.sh` → exits non-zero on drift.
