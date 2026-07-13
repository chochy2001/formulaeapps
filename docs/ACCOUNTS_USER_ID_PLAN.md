# Formulae accounts + user_id entitlements — implementation plan

Fleet tracker: [capdesis-fleet-modularization#86](https://github.com/CAPDESIS/capdesis-fleet-modularization/issues/86)
Parent: [#84](https://github.com/CAPDESIS/capdesis-fleet-modularization/issues/84)
Companion design: [`pro/docs/ENTITLEMENT_CHANNEL_SYNC.md`](../pro/docs/ENTITLEMENT_CHANNEL_SYNC.md)

**Deploy policy:** merge to `main` only. No VPS / store / production flag flips from this workstream without Jorge approval.

---

## Goal

Replace interim JWT `sub` (device/session) as the entitlement key with a real
`user_id` from email/password (then Google/Apple) accounts, while keeping
channel rules from fleet §10 (IAP = mobile only; Polar web never unlocks
mobile).

## Landed in this slice (mergeable, flags OFF)

| Item | Status |
|------|--------|
| OpenAPI stubs `POST /auth/register` + `POST /auth/login` | ✅ Contract `1.2.0`; handlers return **403** `E_ACCOUNTS_DISABLED` while flag off |
| `mobile_entitlements.user_id` nullable column + index | ✅ Additive migration; subject uniqueness unchanged |
| `ENABLE_USER_ACCOUNT_AUTH` | ✅ Default **off**; call-time read for tests |
| Grant/bind helpers honor flag | ✅ `user_id` ignored / bind no-op when off |
| Polar web | ❌ Explicitly deferred (see below) |
| Production deploy | ❌ Out of scope |

## Remaining ordered steps

### A. Accounts (BFF) — next PRs

1. **Users table** (`users`: `id` UUID PK, `email` unique, `password_hash`, `created_at`).
2. **Password hashing** — Bun `password.hash` / `password.verify` (argon2id).
3. **Implement register/login** behind `ENABLE_USER_ACCOUNT_AUTH=true` only; issue JWT with claims `{ sub, user_id }` (keep device `sub` for chat rate-limit continuity or migrate carefully).
4. **Link device session → account** on first login: `bindEntitlementsUserId(subject, user_id)` so prior IAP grants move with the user.
5. **OAuth (later):** Google/Apple Sign-In as additive providers; same `user_id` key.

### B. Entitlement read path

6. Prefer `listEntitlementsForUserId` when JWT has `user_id` **and** flag on; fall back to subject until migration complete.
7. `GET /entitlement` response stays `scope: "mobile"` only — no Polar leakage.
8. FE: optional account UI gated separately; keep `ENABLE_BFF_IAP_VALIDATION` default **off** until accounts + real Apple/Google validators.

### C. Polar web — deferred (product decision required)

**Do not invent Polar products.** Only if product decides formulaeapps.com sells Pro:

| Rule | Requirement |
|------|-------------|
| Channel | Separate rows / table with `payment_source=polar`, `scope=web` |
| Grant path | Polar webhook handler only — never from `POST /iap/validate` |
| Mobile unlock | Forbidden — web Pro must not set mobile entitlement |
| Marketing | No web Pro checkout until handler + webhook secrets exist |

Until Jorge signs off on selling web Pro, Polar stays documented-deferred and
unimplemented.

## Flags

| Flag | Default | Layer | Purpose |
|------|---------|-------|---------|
| `ENABLE_USER_ACCOUNT_AUTH` | `false` | BFF env | Unlock account stubs → real register/login + persist `user_id` on grants |
| `ENABLE_BFF_IAP_VALIDATION` | `false` | Flutter dart-define | FE → BFF `/iap/validate` + fail-closed pre-IAP guard |

## Local validation

```bash
cd bff && bun run test && bun run typecheck
cd bff && bun run build:openapi   # regenerates contracts/bff.openapi.yaml
# If OpenAPI shapes change FE clients:
bash scripts/verify-parity.sh
```

## Acceptance mapping (#86)

- [x] Account-bound entitlement grant path **documented** + schema/`user_id` prep behind flag
- [ ] Account register/login **implemented** (not just stub) behind flag
- [x] Polar web **explicitly deferred** pending product sign-off (this doc)
- [x] Anti-double-pay / channel rules unchanged (IAP ≠ polar/web)
- [ ] Flip flags only after Jorge go-live approval — **no deploy from agents**
