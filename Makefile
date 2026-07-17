# FormulaeApps monorepo — top-level task runner
#
# Wraps scripts/*.sh so contributors have one entry point per Principle IV.
# Run `make help` for a list of targets.

.PHONY: help verify-all verify-parity verify-routes verify-infra verify-infra-local verify-tickets \
        measure-community-android \
        build-openapi generate-types bff-typecheck bff-persistence bff-audit bff-test bff-build flutter-analyze flutter-test \
        landing-lint landing-build landing-test landing-images \
        compose-lint compose-lint-production compose-up compose-down compose-up-local compose-down-local \
        compose-up-production compose-down-production

help:
	@echo "FormulaeApps monorepo — make targets"
	@echo ""
	@echo "Verification (Principle VIII):"
	@echo "  verify-all          Run every per-stack analyze/build/test gate"
	@echo "  verify-parity       Detect drift between Zod schemas, OpenAPI, Dart types"
	@echo "  verify-routes       Run route-coverage scan (Principle VI)"
	@echo "  verify-infra        Run production infra validator (Principle IX)"
	@echo "  verify-infra-local  Run infra validator in local-dev mode"
	@echo "  verify-tickets      Validate the active execution ticket tracker"
	@echo "  measure-community-android  Measure first interactive Community UI on Android"
	@echo ""
	@echo "Codegen:"
	@echo "  build-openapi       Export contracts/bff.openapi.yaml from BFF Zod schemas"
	@echo "  generate-types      Generate Dart types in pro/ and community/"
	@echo ""
	@echo "Per-stack:"
	@echo "  bff-typecheck       Type-check the BFF"
	@echo "  bff-persistence     Check BFF SQLite volume and runtime-path topology"
	@echo "  bff-audit           Audit BFF dependency advisories"
	@echo "  bff-test            Run BFF test suite"
	@echo "  bff-build           Build the BFF Docker image"
	@echo "  flutter-analyze     Run flutter analyze in pro/ and community/"
	@echo "  flutter-test        Run flutter test in pro/ and community/"
	@echo "  landing-lint        Lint and format-check the Astro landing site"
	@echo "  landing-build       Build and validate localized marketing output"
	@echo "  landing-test        Run landing vitest suite"
	@echo "  landing-images      Validate the 176 local canonical Formulae assets"
	@echo "  compose-lint        Lint the explicit local BFF overlay (safe default)"
	@echo "  compose-lint-production  Lint only the production Compose file (requires protected env)"
	@echo "  compose-up          Start the local BFF overlay on 127.0.0.1:3001"
	@echo "  compose-down        Stop the local BFF overlay"
	@echo "  compose-up-production  Start the production stack from docker-compose.yml only"
	@echo "  compose-down-production Stop the production stack from docker-compose.yml only"
	@echo ""

verify-all: verify-tickets verify-parity verify-routes bff-typecheck bff-persistence bff-audit bff-test flutter-analyze flutter-test landing-lint landing-test landing-build landing-images compose-lint verify-infra-local
	@echo "✓ All per-stack gates passed."

verify-parity:
	bash scripts/verify-parity.sh

verify-routes:
	bash scripts/route-coverage.sh

verify-infra:
	bash scripts/infra-validate.sh

verify-infra-local:
	bash scripts/infra-validate.sh --local

verify-tickets:
	bash scripts/validate-ticket-tracker.sh

measure-community-android:
	bash scripts/measure-community-android-startup.sh

build-openapi:
	cd bff && bun run build:openapi

generate-types: build-openapi
	bash scripts/generate-bff-types.sh

bff-typecheck:
	cd bff && bun install --frozen-lockfile && bun run typecheck

bff-persistence:
	cd bff && bun install --frozen-lockfile && bun run check:persistence-config

bff-audit:
	cd bff && bun install --frozen-lockfile && bun run audit

bff-test:
	cd bff && bun install --frozen-lockfile && bun test

bff-build:
	docker compose -f docker-compose.yml build bff

flutter-analyze:
	cd pro && flutter analyze --no-pub --fatal-infos --fatal-warnings
	cd community && flutter analyze --no-pub --fatal-infos --fatal-warnings

# JWT_SHARED_SECRET / build nonce are compile-time consts required by auth_service
# minting tests. Values here are non-secret CI/local test constants only.
flutter-test:
	cd pro && FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --reporter compact \
		--dart-define=JWT_SHARED_SECRET=test-shared-secret \
		--dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
		--dart-define=FORMULAE_APP_VERSION=0.0.0-ci
	cd community && FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --reporter compact \
		--dart-define=JWT_SHARED_SECRET=test-shared-secret \
		--dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce \
		--dart-define=FORMULAE_APP_VERSION=0.0.0-ci
	cd pro/packages/formulaeapps_bff_client && dart test
	cd community/packages/formulaeapps_bff_client && dart test

landing-lint:
	cd landing && bun install --frozen-lockfile && bun run lint

landing-build:
	cd landing && bun install --frozen-lockfile && bun run build && bun run check:localized-marketing

landing-test:
	cd landing && bun install --frozen-lockfile && bun run test

landing-images:
	cd landing && bun install --frozen-lockfile && bun run check:formulae-images

compose-lint:
	docker compose -f docker-compose.yml -f docker-compose.local.yml config > /dev/null && echo "local compose lint OK"

compose-lint-production:
	docker compose -f docker-compose.yml config > /dev/null && echo "production compose lint OK"

compose-up: compose-up-local

compose-down: compose-down-local

compose-up-local:
	@test -n "$$JWT_SIGNING_SECRET" || { echo "ERROR: export an independent JWT_SIGNING_SECRET before starting the local BFF." >&2; exit 2; }
	docker compose -f docker-compose.yml -f docker-compose.local.yml up -d bff

compose-down-local:
	docker compose -f docker-compose.yml -f docker-compose.local.yml down

compose-up-production:
	docker compose -f docker-compose.yml up -d

compose-down-production:
	docker compose -f docker-compose.yml down
