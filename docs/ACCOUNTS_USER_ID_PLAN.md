# Formulae accounts + user_id entitlements — implementation plan

Fleet tracker: [capdesis-fleet-modularization#86](https://github.com/CAPDESIS/capdesis-fleet-modularization/issues/86)
Parent: [#84](https://github.com/CAPDESIS/capdesis-fleet-modularization/issues/84)
Companion design: [`pro/docs/ENTITLEMENT_CHANNEL_SYNC.md`](../pro/docs/ENTITLEMENT_CHANNEL_SYNC.md)

**Deploy policy:** `main` only after the exact candidate passes its gates. No
VPS / store / production flag flip is authorized by this document: user intent
does not replace a staged SHA, backup, smoke and rollback evidence.

---

## Goal

Add a real `user_id` from email/password (then Google/Apple) accounts without
letting account credentials adopt an existing device/session subject or its
entitlements. Keep the fleet §10 channel rules (IAP = mobile only; Polar web
never unlocks mobile).

## Landed slices (mergeable, flags OFF)

| Item | Status |
|------|--------|
| OpenAPI `POST /auth/register` + `POST /auth/login` | ✅ Contract `2.0.0`; strict requests reject public `client_id`; **403** while flag off |
| `mobile_entitlements.user_id` nullable column + index | ✅ Additive migration |
| `ENABLE_USER_ACCOUNT_AUTH` | ✅ Default **off** |
| Users table + argon2id hash + real register/login | ✅ Behind flag; JWT includes `user_id` and account-owned `sub=user:<user_id>` |
| Public device adoption from register/login | ✅ Removed; `client_id` is rejected and the binding helper has no remaining path |
| `GET /entitlement` merges subject + user_id rows | ✅ When flag on + claim present; rows bound to another `user_id` are excluded |
| Device → account pairing | ❌ Pending a verified session or one-time pairing design; no automatic bind exists |
| Polar web | ❌ Explicitly deferred (see below) |
| Production deploy | ❌ Blocked: no staged SHA, completed green CI/candidate for the code candidate, verified FTPS rollback or VPS volume/backup evidence |

## Remaining ordered steps

### A. Accounts (BFF) — later PRs

1. ~~**Users table**~~ ✅
2. ~~**Password hashing**~~ ✅ Bun argon2id
3. ~~**Implement register/login** behind flag~~ ✅ Strict schemas reject
   `client_id`; account tokens use `sub=user:<user_id>`.
4. **Device session → account pairing:** pending. If product needs to migrate
   an existing device grant, derive it from a verified session or one-time
   pairing. Do not reintroduce a public `client_id` bind.
5. **OAuth (later):** Google/Apple Sign-In as additive providers; same `user_id` key.
6. ~~**FE account client stub**~~ ✅ `AccountAuthService` behind dart-define (default off).
7. **FE account UI** (optional) gated separately; keep dart-defines off until go-live.

### B. Entitlement read path

1. ~~Read account-owned grants when JWT has claim and flag on~~ ✅ Subject rows
   bound to another account are filtered; regression tests cover isolation.
2. **Write account-owned grants only from validated IAP:** the current grant
   path writes `user_id` only with an account JWT and
   `ENABLE_USER_ACCOUNT_AUTH=true`. It must continue to persist before a valid
   IAP response is returned.
3. FE: keep `ENABLE_BFF_IAP_VALIDATION` default **off** until real
   Apple/Google validators, durable VPS storage and staged validation exist.

## Contract and security boundary

`CONTRACT_VERSION=2.0.0` is a deliberate major change: it removes
`client_id` from register/login and their strict Zod schemas reject that
unknown field. The OpenAPI document and both generated Dart clients were
regenerated in the same cycle. A client must regenerate rather than silently
sending the rejected field.

The removed `bindEntitlementsUserId` helper leaves no account endpoint that can
adopt a device subject. `readMobileEntitlement` can read a legacy unbound row
for its own subject, but an account session does not receive a row already bound
to a different `user_id`. These controls prevent the prior public-UUID takeover
class; they do not implement device migration or make account/IAP flags safe to
enable in production.

## Promotion boundary

Production is blocked outside this codebase until the exact candidate has a
green CI run and staging deployment with smoke/rollback. No completed green
CI/candidate exists for code SHA `081aa889` (the `main` SHA at dispatch): its
matching CI and web candidate runs are queued while eligible `ci-builds` runners are offline; the
historical landing runner also failed Node setup with `EACCES`. No Formulae
staging SHA exists. The FTPS hosting route lacks a verified host/certificate,
snapshot, atomic publish and rollback. On the VPS,
`/opt/infrastructure/formulaeapps` is not a Git checkout and the observed BFF
has `LocalVolumes=0`, so persistence, backup and restore are not evidenced. No
flag may be flipped to work around those missing controls.

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
| `ENABLE_USER_ACCOUNT_AUTH` | `false` | BFF env + Flutter dart-define | Unlock register/login + FE `AccountAuthService`; permits a validated IAP grant with account JWT to record `user_id` |
| `ENABLE_BFF_IAP_VALIDATION` | `false` | Flutter dart-define | FE → BFF `/iap/validate` + fail-closed pre-IAP guard; never flips on before validators, staging and persistence evidence |

## Local validation

```bash
cd bff && bun run test && bun run typecheck && bun run build:openapi
cd .. && bash scripts/generate-bff-types.sh
bash scripts/verify-parity.sh
bash scripts/route-coverage.sh
```

## Acceptance mapping (#86)

- [x] Account `user_id` schema/storage prep behind flag and generated contract `2.0.0`
- [x] Account register/login **implemented** behind flag (users table + hashing + account-owned JWT subject)
- [x] Public `client_id` adoption removed; account entitlement reads isolate another user's rows
- [x] Polar web **explicitly deferred** pending product sign-off (this doc)
- [x] Anti-double-pay / channel rules unchanged (IAP ≠ polar/web)
- [ ] Verified device → account pairing, only if product needs that migration
- [ ] Flip flags only after product policy, validators, staged SHA, backup/smoke/rollback — **no deploy from this plan**
- [ ] OAuth providers (optional follow-up)
- [ ] Product decision on Polar web Pro
