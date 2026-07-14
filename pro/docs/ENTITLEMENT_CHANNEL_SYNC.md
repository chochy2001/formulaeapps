# Formulae — channel-scoped entitlements (§10 follow-up)

This document records the verified state of Formulae mobile entitlements. It is
not authorization to enable the related flags in staging or production.

## Current state (verified 2026-07-13)

| Layer | Status |
|-------|--------|
| Mobile IAP | `InAppPurchaseManager` continues to use local StoreKit/BillingClient state. |
| BFF `POST /iap/validate` | Contract, persistence path and fail-closed availability envelope exist; Apple/Google validators and sandbox evidence are still missing. |
| BFF `GET /entitlement` | Implemented and consumed by Pro only when `ENABLE_BFF_IAP_VALIDATION=true`; it must not become an authority before validator, persistence and ownership checks are proven. |
| Accounts | Register/login code and a Pro client stub exist behind `ENABLE_USER_ACCOUNT_AUTH=false`; there is no account UI and device-to-account entitlement binding is not approved. |
| Web Polar | Out of scope for the mobile-only product. A future web entitlement must never unlock mobile automatically. |
| Entitlement source of truth | Local store state remains the live purchase gate. `mobile_entitlements` is preparatory storage, not a production authority. |

## Delivered code, with boundaries

- `IapValidationService` is opt-in; outside development the BFF returns
  `503 E_IAP_VALIDATION_UNAVAILABLE` until real Apple/Google validation is
  available.
- `EntitlementService` and the pre-purchase guard are opt-in and fail closed.
  They do not replace the local purchase flow while the BFF is not authoritative.
- The BFF persists account and entitlement SQLite files on its declared runtime
  path. The Docker/Compose topology is guarded locally, but its VPS ownership,
  recreation, backup and restore still require production evidence.
- Account register/login uses a feature flag and has no UI. Do not enable it
  until a user/device proof-of-possession design and regressions prevent one
  device identifier from exposing another user’s entitlement.

## Required work before either flag can be enabled

| Order | Area | Required evidence |
|------:|------|-------------------|
| 1 | Product | Approved authority for online/offline, timeout, `503`, restore and duplicate-purchase behavior. |
| 2 | BFF security | Device-to-account binding derived from a verified session or one-time pairing; public `client_id` input alone is insufficient. Rows tied to another user must never be returned. |
| 3 | IAP | Real Apple and Google validators, sandbox purchases/restores, and a policy that does not report success without a durable grant. |
| 4 | Persistence | BFF volume permissions, recreate test, backup and restore on the target VPS. |
| 5 | Pro | Enable the guard only against the staged, validated BFF SHA; retain local store fallback according to the approved policy. |
| 6 | Product | Decide whether Polar web is in scope. If so, add a separate web handler/webhook and scope; never cross-grant by default. |

## Local validation

```bash
cd bff && bun run typecheck && bun run check:persistence-config && bun test
cd ../pro && flutter analyze --no-pub --fatal-infos --fatal-warnings
cd ../pro && flutter test --no-pub
bash ../scripts/route-coverage.sh
```

## Flags

| Flag | Default | Meaning |
|------|---------|---------|
| `ENABLE_BFF_IAP_VALIDATION` | `false` | Enables the Pro BFF validation call and pre-purchase entitlement guard. Keep off until validators, durable storage and a release SHA are verified. |
| `ENABLE_USER_ACCOUNT_AUTH` | `false` | Enables account endpoints and the Pro client stub. Keep off until account/device proof-of-possession and entitlement-isolation tests are complete. |

No production deployment may flip either flag without the required staging,
backup, smoke and rollback evidence.
