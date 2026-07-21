# FormulaeCommunity (monorepo copy) test coverage roadmap

Play Store source of truth is **`CAPDESIS/FormulaeCommunity`**
(`Formulae/community-app/`). This `community/` tree is a vendored copy used by
monorepo CI.

## Measured coverage (do not invent)

| When | RAW LF/LH | Source |
|------|-----------|--------|
| 2026-07-17 (local lcov) | **85.44%** (21 138 / 24 739) | `community/coverage/lcov.info` |
| CI (after line-coverage PR) | printed in job summary + `community-monorepo-lcov` artifact | `.github/workflows/ci.yml` `community-test` |

`COVERAGE_TODO` previously claimed ~0.3% from the issue #17 bootstrap — that
figure is **obsolete** after the large monorepo community suite landed.

## Measure locally (prefer CI when the laptop is constrained)

```sh
cd community
flutter pub get
FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage \
  --dart-define=JWT_SHARED_SECRET=test-shared-secret \
  --dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
  --dart-define=FORMULAE_APP_VERSION=0.0.0-ci
bash ../scripts/coverage-summary.sh coverage/lcov.info "Community (monorepo)"
```

## Ratchet plan

| Stage | Coverage | Notes |
|-------|----------|-------|
| Current (2026-07-17 local) | ~85.4% RAW | Needs runner remasure after post-7/17 churn |
| Soft CI report | informational | Upload lcov; no hard gate until runner confirms |
| Hard gate | RAW ≥85% | Only after CI summary matches or exceeds |

Largest residual misses historically: generated l10n, drawer, IAP, chat,
favorites, tasks screens — prefer high-leverage unit/widget tests over
excluding production code from the denominator.
