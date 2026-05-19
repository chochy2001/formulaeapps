# FormulaeApps monorepo — top-level task runner
#
# Wraps scripts/*.sh so contributors have one entry point per Principle IV.
# Run `make help` for a list of targets.

.PHONY: help verify-all verify-parity verify-routes verify-infra verify-infra-local \
        build-openapi generate-types bff-test bff-build flutter-analyze landing-build \
        compose-lint compose-up compose-down

help:
	@echo "FormulaeApps monorepo — make targets"
	@echo ""
	@echo "Verification (Principle VIII):"
	@echo "  verify-all          Run every per-stack analyze/build/test gate"
	@echo "  verify-parity       Detect drift between Zod schemas, OpenAPI, Dart types"
	@echo "  verify-routes       Run route-coverage scan (Principle VI)"
	@echo "  verify-infra        Run production infra validator (Principle IX)"
	@echo "  verify-infra-local  Run infra validator in local-dev mode"
	@echo ""
	@echo "Codegen:"
	@echo "  build-openapi       Export contracts/bff.openapi.yaml from BFF Zod schemas"
	@echo "  generate-types      Generate Dart types in pro/ and community/"
	@echo ""
	@echo "Per-stack:"
	@echo "  bff-test            Run BFF test suite"
	@echo "  bff-build           Build the BFF Docker image"
	@echo "  flutter-analyze     Run flutter analyze in pro/ and community/"
	@echo "  landing-build       Build the Astro landing site"
	@echo "  compose-lint        Lint docker-compose.yml"
	@echo "  compose-up          Bring up landing + pro + bff containers"
	@echo "  compose-down        Stop and remove the compose stack"
	@echo ""

verify-all: verify-parity verify-routes verify-infra-local bff-test flutter-analyze landing-build compose-lint
	@echo "✓ All per-stack gates passed."

verify-parity:
	bash scripts/verify-parity.sh

verify-routes:
	bash scripts/route-coverage.sh

verify-infra:
	bash scripts/infra-validate.sh

verify-infra-local:
	bash scripts/infra-validate.sh --local

build-openapi:
	cd bff && bun run build:openapi

generate-types: build-openapi
	bash scripts/generate-bff-types.sh

bff-test:
	cd bff && bun install --frozen-lockfile && bun test

bff-build:
	docker compose build bff

flutter-analyze:
	cd pro && flutter analyze --no-pub --fatal-infos --fatal-warnings
	cd community && flutter analyze --no-pub --fatal-infos --fatal-warnings

landing-build:
	cd landing && bun install && bun run build

compose-lint:
	docker compose config > /dev/null && echo "compose lint OK"

compose-up:
	docker compose up -d

compose-down:
	docker compose down
