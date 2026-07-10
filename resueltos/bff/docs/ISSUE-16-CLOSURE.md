# Issue #16 closure evidence — BFF FormulaeApps (OpenAPI → prod)

**Issue**: [CAPDESIS/formulaeapps#16](https://github.com/CAPDESIS/formulaeapps/issues/16)  
**Verified**: 2026-05-27  
**Canonical repo**: `formulaeapps-code` (`CAPDESIS/formulaeapps`)

## Acceptance criteria

| Criterion | Status | Evidence |
| --------- | ------ | -------- |
| OpenAPI routes implemented | ✅ | `GET /health`, `POST /auth/token`, `POST /openai/chat`, `POST /iap/validate` in `bff/src/routes/`; contract `contracts/bff.openapi.yaml` v1.0.0 |
| Dart codegen client | ✅ | `pro/packages/formulaeapps_bff_client/`, `community/packages/formulaeapps_bff_client/`; consumed by `lib/chat_gpt/api_service.dart` in both apps |
| VPS deploy with Traefik | ✅ | `docker-compose.yml` labels `formulae-bff` on `api.formulaeapps.com`; live `curl https://api.formulaeapps.com/health` → HTTP 200 |
| Contract tests | ✅ | `scripts/verify-parity.sh`, `scripts/route-coverage.sh`, `bff/tests/` (**35** Bun tests at historical closure in CI job `bff-test`) |

## Validation run (2026-05-27)

```text
bff-test:        35 pass, 0 fail   ← historical Issue #16 closure count
verify-parity:   ✓ Zod ↔ OpenAPI ↔ Dart match
verify-routes:   exit_status PASS (2 covered routes, 1 intentional orphan /iap/validate)
prod /health:    {"status":"ok","version":"1.0.0","prompts_version":"1.0.0"}
```

> **Do not conflate test counts.** The **35** figure above is the Issue #16
> closure evidence from 2026-05-27. The live BFF suite has grown since then
> (JWT dual-key migration, release gate, rate-limit, IAP, gitleaks guards,
> etc.). At the dual-key PR baseline it was **110** passing Bun tests; after
> the `legacyVerificationAllowed` + gitleaks hardening it is **121**. Cite
> **35** only when discussing the historical #16 closure; cite the live
> `bun test` total for current branch validation.

## Out of scope for #16 (follow-up issues)

- Wire FE to `/iap/validate` or remove orphan route (product decision).
- Implement `AppleIapRealValidator` / `GoogleIapRealValidator` (currently throw / stub).
- Pro Web rebuild if Hostinger build still uses placeholder JWT secret.

## Related

- Feature 002 audits: `specs/002-formulae-fe-be-sync/audit/round-10-production-cutover-2026-05-19.md`, `round-11-chat-live-2026-05-19.md`
- Release tag: `v1.0.0-bff`
