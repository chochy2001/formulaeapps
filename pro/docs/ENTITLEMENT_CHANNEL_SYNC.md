# Formulae — channel-scoped entitlements (§10 follow-up)

This document records the verified state of Formulae mobile entitlements. It is
not authorization to enable the related flags in staging or production.

## Current state (verified 2026-07-13)

| Layer | Status |
|-------|--------|
| Mobile IAP | `InAppPurchaseManager` continues to use local StoreKit/BillingClient state. |
| BFF `POST /iap/validate` | Contract `2.0.0`, persistence path and fail-closed availability envelope exist. A provider-confirmed result cannot return `valid=true` until its mobile grant persists; Apple/Google validators and sandbox evidence are still missing. |
| BFF `GET /entitlement` | Implemented and consumed by Pro only when `ENABLE_BFF_IAP_VALIDATION=true`; an account session filters out subject rows bound to a different `user_id`. It must not become an authority before validator, persistence and ownership checks are proven. |
| Accounts | Register/login code and a Pro client stub exist behind `ENABLE_USER_ACCOUNT_AUTH=false`; requests are strict, reject public `client_id` and issue account-owned `sub=user:<user_id>`. There is no account UI or device-to-account pairing flow. |
| Web Polar | Out of scope for the mobile-only product. A future web entitlement must never unlock mobile automatically. |
| Entitlement source of truth | Local store state remains the live purchase gate. `mobile_entitlements` is preparatory storage, not a production authority. |

## Delivered code, with boundaries

- `IapValidationService` is opt-in; outside development the BFF returns
  `503 E_IAP_VALIDATION_UNAVAILABLE` until real Apple/Google validation is
  available. If a future validator confirms a purchase, the BFF persists the
  mobile grant before it returns success; missing subject and persistence
  failures become `E_IAP_MISSING_SUBJECT` and `E_ENTITLEMENT_PERSISTENCE`.
- `EntitlementService` and the pre-purchase guard are opt-in and fail closed.
  They do not replace the local purchase flow while the BFF is not authoritative.
- The BFF persists account and entitlement SQLite files on its declared runtime
  path. The Docker/Compose topology is guarded locally, but its VPS ownership,
  recreation, backup and restore still require production evidence.
- Account register/login uses a feature flag and has no UI. The public
  `client_id` adoption path and its binding helper were removed: credentials
  alone cannot take over a device subject or its prior grant. Account sessions
  use `user:<user_id>` and entitlement reads isolate rows belonging to another
  user. A future device-to-account migration needs a verified session or
  one-time pairing; it is not implemented by the current account endpoints.
- `user_id` on a mobile grant is written only from a validated IAP path with an
  account JWT and `ENABLE_USER_ACCOUNT_AUTH=true`; it is not inferred from a
  register/login request.

## Required work before either flag can be enabled

| Order | Area | Required evidence |
|------:|------|-------------------|
| 1 | Product | Approved authority for online/offline, timeout, `503`, restore and duplicate-purchase behavior. |
| 2 | BFF security | If product needs a device-to-account migration, derive it from a verified session or one-time pairing; public `client_id` is rejected by current register/login. Rows tied to another user must never be returned. |
| 3 | IAP | Real Apple and Google validators, sandbox purchases/restores, and a policy that keeps the current durable-grant-before-success rule. |
| 4 | Persistence | BFF volume permissions, recreate test, backup and restore on the target VPS. |
| 5 | Pro | Enable the guard only against the staged, validated BFF SHA; retain local store fallback according to the approved policy. |
| 6 | Product | Decide whether Polar web is in scope. If so, add a separate web handler/webhook and scope; never cross-grant by default. |

## Local validation

```bash
cd bff && bun run typecheck && bun run check:persistence-config && bun test && bun run build:openapi
cd .. && bash scripts/generate-bff-types.sh
cd pro && flutter analyze --no-pub --fatal-infos --fatal-warnings
FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub
cd .. && bash scripts/route-coverage.sh
```

## Flags

| Flag | Default | Meaning |
|------|---------|---------|
| `ENABLE_BFF_IAP_VALIDATION` | `false` | Enables the Pro BFF validation call and pre-purchase entitlement guard. Keep off until validators, durable storage, staging and a release SHA are verified. |
| `ENABLE_USER_ACCOUNT_AUTH` | `false` | Enables account endpoints and the Pro client stub. Keep off until product approves identity/pairing behavior, VPS storage is proven and the staged candidate passes the account-isolation regressions. |

Production is currently blocked: no Formulae staging SHA or completed green
CI/release-candidate run exists for code SHA `081aa889` (the `main` SHA at
dispatch). The matching CI and web candidate runs are queued because eligible `ci-builds`
runners are offline; the historical landing runner also hit Node toolcache
`EACCES`. The FTPS publication/snapshot/rollback route is not verifiable, and
the observed VPS stack is not a Git checkout with a proven BFF volume. No
deployment may flip either flag without the required staging, backup, smoke and
rollback evidence.
