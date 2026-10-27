#!/usr/bin/env bash
# Tests for audit-public-mirror-policy.sh.
#
# Why this exists. The audit is the only control that keeps this PUBLIC mirror
# from carrying deploy capability, self-hosted runners or secrets. It had been
# red every single scheduled day since at least 2026-07-24 (95 failures against
# 1 success) on one finding:
#
#   jwt-pr-preflight.yml remains deploy-capable in the public mirror;
#   retire it in YAML or move it to the private repository
#
# That finding was wrong. The classifier matched the bare string "docker
# compose" and so could not tell `docker compose config`, which only renders the
# merged file and is a lint, from `docker compose up`, which starts an
# environment. A gate that fires every day on a false positive stops being read,
# and then it protects nothing the day it is right.
#
# These tests pin both directions: the render must pass and every mutating verb
# must still fail. They run on a hosted runner, need no secrets and no network.

set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUDIT="${HERE}/audit-public-mirror-policy.sh"

TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/mirror-policy-tests-XXXXXX")"
chmod 700 "$TMP_ROOT"
trap 'rm -rf "$TMP_ROOT"' EXIT

failures=0
checks=0

# Escribe un workflow aislado en su propio directorio y devuelve el directorio.
fixture() {
  local name="$1"
  local body="$2"
  local dir
  dir="$(mktemp -d "${TMP_ROOT}/wf-XXXXXX")"
  printf '%s\n' "$body" >"${dir}/${name}"
  printf '%s' "$dir"
}

expect_pass() {
  local label="$1" dir="$2" out status
  checks=$((checks + 1))
  out="$(bash "$AUDIT" "$dir" 2>&1)"
  status=$?
  if [ "$status" -eq 0 ]; then
    echo "ok   ${label}"
    return
  fi
  failures=$((failures + 1))
  echo "FAIL ${label}"
  echo "     se esperaba salida 0 y se obtuvo ${status}"
  echo "     salida: ${out}"
}

expect_fail_with() {
  local label="$1" dir="$2" needle="$3" out status
  checks=$((checks + 1))
  out="$(bash "$AUDIT" "$dir" 2>&1)"
  status=$?
  if [ "$status" -eq 0 ]; then
    failures=$((failures + 1))
    echo "FAIL ${label}"
    echo "     se esperaba salida distinta de 0 y se obtuvo 0"
    echo "     salida: ${out}"
    return
  fi
  if ! printf '%s' "$out" | grep -qF "$needle"; then
    failures=$((failures + 1))
    echo "FAIL ${label}"
    echo "     se esperaba un hallazgo que contuviera: ${needle}"
    echo "     salida: ${out}"
    return
  fi
  echo "ok   ${label}"
}

# Comillas simples a proposito: este texto es YAML de Actions y su ${{ ... }}
# tiene que llegar literal al fichero de prueba, no expandirse en bash.
# shellcheck disable=SC2016
HOSTED_HEADER='name: Ejemplo

on:
  pull_request:

concurrency:
  group: ejemplo-${{ github.ref }}
  cancel-in-progress: true

jobs:
  job:
    runs-on: ubuntu-latest
    steps:'

# ---------------------------------------------------------------------------
# Un render de compose es un lint, no un despliegue.
# ---------------------------------------------------------------------------

expect_pass 'docker compose config (render) no es capacidad de despliegue' \
  "$(fixture compose-config.yml "${HOSTED_HEADER}
      - name: Docker compose config (synthetic)
        run: docker compose -f docker-compose.staging.yml config >/dev/null")"

expect_pass 'docker compose convert (render) tampoco lo es' \
  "$(fixture compose-convert.yml "${HOSTED_HEADER}
      - run: docker compose -f docker-compose.staging.yml convert >/dev/null")"

expect_pass 'el nombre de un paso que menciona compose no basta para marcarlo' \
  "$(fixture compose-name-only.yml "${HOSTED_HEADER}
      - name: Docker compose config check
        run: echo sin comandos")"

# ---------------------------------------------------------------------------
# Cualquier verbo que toque un entorno sigue siendo despliegue. Sin estos, el
# arreglo de arriba seria un agujero en vez de una correccion.
# ---------------------------------------------------------------------------

DEPLOY_MSG='remains deploy-capable in the public mirror'

expect_fail_with 'docker compose up sigue siendo despliegue' \
  "$(fixture compose-up.yml "${HOSTED_HEADER}
      - run: docker compose up -d")" \
  "$DEPLOY_MSG"

expect_fail_with 'docker compose up con -f delante sigue siendo despliegue' \
  "$(fixture compose-up-file.yml "${HOSTED_HEADER}
      - run: docker compose -f docker-compose.staging.yml up -d")" \
  "$DEPLOY_MSG"

expect_fail_with 'docker compose pull sigue siendo despliegue' \
  "$(fixture compose-pull.yml "${HOSTED_HEADER}
      - run: docker compose pull")" \
  "$DEPLOY_MSG"

expect_fail_with 'docker compose down sigue siendo despliegue' \
  "$(fixture compose-down.yml "${HOSTED_HEADER}
      - run: docker compose down")" \
  "$DEPLOY_MSG"

expect_fail_with 'docker compose restart sigue siendo despliegue' \
  "$(fixture compose-restart.yml "${HOSTED_HEADER}
      - run: docker compose restart web")" \
  "$DEPLOY_MSG"

expect_fail_with 'la forma con guion docker-compose up tambien se detecta' \
  "$(fixture compose-hyphen.yml "${HOSTED_HEADER}
      - run: docker-compose up -d")" \
  "$DEPLOY_MSG"

expect_fail_with 'un subcomando desconocido se trata como despliegue' \
  "$(fixture compose-unknown.yml "${HOSTED_HEADER}
      - run: docker compose verbo-que-no-existe")" \
  "$DEPLOY_MSG"

expect_fail_with 'compose sin subcomando legible se trata como despliegue' \
  "$(fixture compose-bare.yml "${HOSTED_HEADER}
      - run: docker compose")" \
  "$DEPLOY_MSG"

# ---------------------------------------------------------------------------
# El resto del control no se toca: sigue rechazando lo que ya rechazaba.
# ---------------------------------------------------------------------------

expect_fail_with 'un runner self-hosted sigue prohibido' \
  "$(fixture self-hosted.yml 'name: Ejemplo

on:
  pull_request:

jobs:
  job:
    runs-on: [self-hosted, Linux, X64]
    steps:
      - run: echo hola')" \
  'still references self-hosted runners'

expect_fail_with 'una referencia a secrets sigue prohibida' \
  "$(fixture secretos.yml "${HOSTED_HEADER}
      - run: echo \"\${{ secrets.ALGUNA_CLAVE }}\"")" \
  'still references GitHub secrets'

expect_fail_with 'un workflow llamado deploy sin retirar sigue fallando' \
  "$(fixture deploy-web.yml "${HOSTED_HEADER}
      - run: echo despliego")" \
  "$DEPLOY_MSG"

expect_pass 'un deploy retirado en YAML sigue aceptandose' \
  "$(fixture deploy-retirado.yml 'name: Retired Web Deploy (public mirror disabled)

on:
  workflow_dispatch:

concurrency:
  group: retirado
  cancel-in-progress: true

jobs:
  noop:
    runs-on: ubuntu-latest
    steps:
      - run: echo retirado')" \
  || true

expect_fail_with 'un deploy sin guarda de concurrencia sigue fallando por eso' \
  "$(fixture deploy-sin-concurrencia.yml 'name: Ejemplo

on:
  pull_request:

jobs:
  job:
    runs-on: ubuntu-latest
    steps:
      - run: echo despliego')" \
  'has no top-level concurrency guard'

expect_pass 'un comentario que solo habla de compose no marca el workflow' \
  "$(fixture solo-comentario.yml "${HOSTED_HEADER}
      # docker compose up -d quedaria prohibido aqui
      - run: echo sin comandos")"

echo
if [ "$failures" -ne 0 ]; then
  echo "audit-public-mirror-policy: ${failures} de ${checks} comprobaciones fallaron"
  exit 1
fi
echo "audit-public-mirror-policy: ${checks} comprobaciones en verde"
