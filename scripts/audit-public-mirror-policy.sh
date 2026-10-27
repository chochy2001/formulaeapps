#!/usr/bin/env bash
# Audits the workflows of this PUBLIC mirror.
#
# This repository is the public face of the private CAPDESIS/formulaeapps. Its
# workflows are deliberately NOT a copy of the private ones: deploy paths are
# retired in YAML, self-hosted runners are replaced by GitHub-hosted ones and
# secrets are stripped. This script is the control that keeps it that way.
#
# Usage: audit-public-mirror-policy.sh [workflow-dir]   (default .github/workflows)

set -euo pipefail

WORKFLOW_DIR="${1:-.github/workflows}"

findings=0
fail() {
  findings=$((findings + 1))
  echo "::error::$*"
}

# Reads a workflow with YAML comments stripped, so a comment that merely talks
# about a forbidden thing never counts as doing it.
workflow_body() {
  sed -E 's/[[:space:]]+#.*$//' "$1" | sed '/^[[:space:]]*#/d'
}

workflow_has() {
  local file="$1"
  local pattern="$2"
  workflow_body "$file" | grep -Eiq "$pattern"
}

# Subcomandos de compose que NO pueden cambiar un entorno: solo renderizan el
# fichero combinado o leen estado. `config` y `convert` son un lint del compose,
# que es exactamente para lo que los usa jwt-pr-preflight.yml.
COMPOSE_READ_ONLY='config|convert|version|ls'

# Imprime, uno por linea, el subcomando de cada invocacion de compose del
# workflow. Todo en minusculas para que "Docker compose" y "docker compose" se
# traten igual, que es como lo lee el resto del control con grep -i.
compose_subcommands() {
  workflow_body "$1" |
    tr '[:upper:]' '[:lower:]' |
    grep -Eo 'docker[[:space:]-]+compose[[:space:]]+[^;&|]*' |
    sed -E 's/^docker[[:space:]-]+compose[[:space:]]+//' |
    awk '{
      for (i = 1; i <= NF; i++) {
        if ($i ~ /^-/) {
          if ($i ~ /^(-f|-p|--file|--project-name|--env-file|--profile|--project-directory)$/) {
            i++
          }
          continue
        }
        print $i
        exit
      }
      print "(sin-subcomando)"
    }'
}

# Cierto cuando alguna invocacion de compose puede cambiar un entorno.
#
# Falla cerrado a proposito: si el workflow menciona compose y no se consigue
# leer ningun subcomando, o el subcomando no esta en la lista de solo lectura,
# se considera capaz de desplegar. Un clasificador que no entiende lo que lee
# no esta en condiciones de autorizar nada.
compose_is_deploy_capable() {
  local file="$1" subs sub
  workflow_has "$file" 'docker[[:space:]-]+compose' || return 1
  subs="$(compose_subcommands "$file")"
  [ -n "$subs" ] || return 0
  while IFS= read -r sub; do
    [ -n "$sub" ] || continue
    printf '%s' "$sub" | grep -Eq "^(${COMPOSE_READ_ONLY})$" || return 0
  done <<<"$subs"
  return 1
}

shopt -s nullglob
workflow_files=("$WORKFLOW_DIR"/*.yml "$WORKFLOW_DIR"/*.yaml)
if ((${#workflow_files[@]} == 0)); then
  echo 'No workflows to audit.'
  exit 0
fi

for file in "${workflow_files[@]}"; do
  base="$(basename "$file")"
  case "$base" in
    release-policy.yml | release-policy.yaml)
      continue
      ;;
  esac

  if workflow_has "$file" 'self-hosted'; then
    fail "$base still references self-hosted runners; public mirror workflows must stay GitHub-hosted"
  fi

  if workflow_has "$file" '\$\{\{[[:space:]]*secrets\.'; then
    fail "$base still references GitHub secrets; public mirror workflows must stay secret-free"
  fi

  retired=false
  if workflow_has "$file" 'name:[[:space:]]*Retired'; then
    retired=true
  fi

  # `docker compose` sale de esta lista a proposito y pasa por
  # compose_is_deploy_capable: como cadena suelta marcaba igual un render que un
  # despliegue, y ademas se le escapaba por completo la forma con guion
  # `docker-compose up`, que si despliega.
  deploy_like=false
  if [[ "$base" =~ [Dd]eploy ]] ||
    workflow_has "$file" 'rsync|ssh .+@|scp |kubectl|fly deploy|vercel|hostinger' ||
    compose_is_deploy_capable "$file"; then
    deploy_like=true
  fi
  if [ "$deploy_like" != true ] && [ "$retired" != true ]; then
    continue
  fi

  if ! grep -Eq '^concurrency:' "$file"; then
    fail "$base is deploy-like but has no top-level concurrency guard"
  fi

  if [ "$retired" = true ]; then
    continue
  fi

  fail "$base remains deploy-capable in the public mirror; retire it in YAML or move it to the private repository"

  if workflow_has "$file" 'environment:[[:space:]]*production|deploy-prod|production|PRODUCTION_|web-app-proxy|ancare'; then
    if ! grep -Eq '^[[:space:]]*name:[[:space:]]*production[[:space:]]*$' "$file"; then
      fail "$base references production without environment: production"
    fi
    if ! grep -Eq '^[[:space:]]*workflow_dispatch:' "$file"; then
      fail "$base references production without a manual workflow_dispatch entrypoint"
    fi
  fi
done

if ((findings > 0)); then
  exit 1
fi
echo 'Release policy passed: active public workflows stay hosted-only, and deploy-like paths are retired in YAML.'
