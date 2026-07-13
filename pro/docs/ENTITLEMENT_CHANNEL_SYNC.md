# Formulae — channel-scoped entitlements (§10 follow-up)

Design + first integration step for fleet rule **§10 Polar↔IAP** in
`capdesis-fleet-modularization/docs/fleet-modularization/FLEET_PROVIDER_UNIFICATION_2026-07-13.md`.

## Current state (verified 2026-07-13)

| Layer | Status |
|-------|--------|
| Mobile IAP | `InAppPurchaseManager` — local StoreKit/BillingClient; `hasValidPurchase` in-memory |
| BFF `POST /iap/validate` | Implemented + integration-tested; FE did not call it |
| Auth | Device/session JWT via `client_proof` HMAC — **no user accounts** |
| Web Polar | None (mobile-only product today) |
| Entitlement SoT | None — folder split `pro/` vs `community/` |

## Target (IngeTracker-shaped, channel-scoped)

1. **Identity:** email/password + Google/Apple on BFF (replace device-only JWT as entitlement key).
2. **Table:** `mobile_entitlements` (or fleet-shared contract) keyed by `user_id` + `payment_source` (`app_store` \| `play_store`).
3. **Grant path:** `POST /iap/validate` → verify receipt → persist row with scope `mobile` only.
4. **Gating:** Pro runtime queries server entitlement; local IAP cache remains offline fallback until account login exists.
5. **Web Polar (future):** only if formulaeapps.com sells Pro — separate `polar` rows with scope `web`; never auto-grant mobile.

## Landed in this pass (code)

- `lib/chat_gpt/iap_validation_service.dart` — optional BFF receipt validation behind `ENABLE_BFF_IAP_VALIDATION` (default **off**).
- `InAppPurchaseManager` calls the service after store purchase/restore when the flag is on; **does not** change local gating yet (no account binding).
- Tests: `test/iap_validation_service_test.dart`.
- **BFF WP5 step 1 (2026-07-13):** `bun:sqlite` `mobile_entitlements` store + grant on successful `POST /iap/validate` + `GET /entitlement` (`scope: "mobile"` only). Keyed by interim JWT `sub` until accounts land. Contract bump `1.0.0` → `1.1.0`.
- **BFF fail-closed check (2026-07-13 follow-up):** `entitlement-check.ts` (`readMobileEntitlement` / `hasActiveMobileEntitlement` / `evaluateMobileIapPurchase`) + runtime reject of `polar`/`web` payment sources on grant. Export OpenAPI version follows `CONTRACT_VERSION`.
- **FE WP5 steps 3–4 (2026-07-13):** `EntitlementService` → `GET /entitlement`; paywall `buyProduct` fail-closed pre-IAP guard when `ENABLE_BFF_IAP_VALIDATION` is on (anti double-pay stub via `lastPurchaseBlockReason`). Flag still default **off**.

## Next implementation steps (ordered)

| Step | Repo | Work |
|------|------|------|
| 1 | BFF | ✅ `mobile_entitlements` store + grant on `/iap/validate` + `GET /entitlement` + fail-closed check helper. |
| 2 | BFF | User auth routes (email/OAuth) — extend beyond device JWT. |
| 3 | Pro FE | ✅ `EntitlementService` → `GET /entitlement` (wired; used when flag on). |
| 4 | Pro FE | ✅ Paywall: check entitlement before IAP charge (fail-closed when flag on). |
| 5 | Fleet | OpenAPI entitlement contract shared with IngeTracker (`sources`, `scope`, `since`). |
| 6 | Product | Decide if web Polar is in scope; if yes, add Polar handler + webhook before marketing web Pro. |

### Remaining checklist (post FE steps 3–4)

- [ ] User accounts (email/password + Google/Apple) replace JWT `sub` as entitlement key
- [x] FE `EntitlementService` + paywall pre-IAP check (steps 3–4)
- [ ] Flip `ENABLE_BFF_IAP_VALIDATION` only after accounts + real Apple/Google validators
- [ ] Polar web products — **do not invent**; only if product decides formulaeapps.com sells Pro
- [ ] No production BFF deploy from this slice alone

## Local validation

```bash
cd Formulae/monorepo/bff && bun run test
cd Formulae/monorepo/pro && flutter test \
  test/iap_validation_service_test.dart \
  test/entitlement_service_test.dart \
  test/entitlement_channel_test.dart \
  test/in_app_purchase_manager_test.dart
cd Formulae/monorepo/pro && flutter analyze --no-pub --fatal-infos --fatal-warnings
```

## Flags

| Flag | Default | Purpose |
|------|---------|---------|
| `ENABLE_BFF_IAP_VALIDATION` | `false` | Opt-in wire from store purchase → BFF `/iap/validate` **and** pre-purchase `GET /entitlement` fail-closed guard |

Do **not** enable in production until BFF persistence + user accounts exist.
