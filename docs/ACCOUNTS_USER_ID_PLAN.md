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

## Landed slices (mergeable, flags OFF)

| Item | Status |
|------|--------|
| OpenAPI `POST /auth/register` + `POST /auth/login` | ✅ Contract ≥ `1.3.0`; **403** while flag off |
| `mobile_entitlements.user_id` nullable column + index | ✅ Additive migration |
| `ENABLE_USER_ACCOUNT_AUTH` | ✅ Default **off** |
| Users table + argon2id hash + real register/login | ✅ Behind flag; JWT includes `user_id` |
| Optional `client_id` binds device entitlements | ✅ `bindEntitlementsUserId` on register/login |
| `GET /entitlement` merges subject + user_id rows | ✅ When flag on + claim present |
| Polar web | ❌ Explicitly deferred (see below) |
| Production deploy | ❌ Out of scope |

## Remaining ordered steps

### A. Accounts (BFF) — later PRs

1. ~~**Users table**~~ ✅
2. ~~**Password hashing**~~ ✅ Bun argon2id
3. ~~**Implement register/login** behind flag~~ ✅
4. ~~**Link device session → account** via optional `client_id`~~ ✅
5. **OAuth (later):** Google/Apple Sign-In as additive providers; same `user_id` key.
6. **FE account UI** (optional) gated separately; keep dart-defines off until go-live.

### B. Entitlement read path

7. ~~Prefer user_id when JWT has claim and flag on~~ ✅ (merged with subject rows)
8. FE: keep `ENABLE_BFF_IAP_VALIDATION` default **off** until accounts + real Apple/Google validators in production.

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
| `ENABLE_USER_ACCOUNT_AUTH` | `false` | BFF env | Unlock register/login + persist `user_id` on grants |
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
- [x] Account register/login **implemented** behind flag (users table + hashing + JWT `user_id`)
- [x] Polar web **explicitly deferred** pending product sign-off (this doc)
- [x] Anti-double-pay / channel rules unchanged (IAP ≠ polar/web)
- [ ] Flip flags only after Jorge go-live approval — **no deploy from agents**
- [ ] OAuth providers (optional follow-up)
- [ ] Product decision on Polar web Pro
