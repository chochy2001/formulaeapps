#!/usr/bin/env bash

# Validate the local Formulae execution tracker. Keep this intentionally
# dependency-free so it works on the macOS Bash version bundled with the repo.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TRACKER="$ROOT/docs/TICKETS.md"

if [ ! -f "$TRACKER" ]; then
  echo "ERROR: missing ticket tracker: $TRACKER" >&2
  exit 2
fi

ticket_ids="$(sed -nE 's/^### (FML-[0-9]{3}): .*/\1/p' "$TRACKER")"
ticket_count="$(printf '%s\n' "$ticket_ids" | sed '/^$/d' | wc -l | tr -d ' ')"

if [ "$ticket_count" -eq 0 ]; then
  echo "ERROR: tracker contains no FML ticket headings." >&2
  exit 1
fi

duplicates="$(printf '%s\n' "$ticket_ids" | sed '/^$/d' | sort | uniq -d)"
if [ -n "$duplicates" ]; then
  echo "ERROR: duplicate ticket IDs:" >&2
  printf '%s\n' "$duplicates" >&2
  exit 1
fi

required_fields=(
  '^- Estado: (PENDIENTE|EN_CURSO|BLOQUEADO|HECHO|CANCELADO)$'
  '^- Prioridad: P[0-3]$'
  '^- Area: .+$'
  '^- Responsable: .+$'
  '^- Proximo paso: .+$'
  '^- Criterio de cierre: .+$'
  '^- Evidencia: .+$'
  '^- Bloqueo: .+$'
)

while IFS= read -r ticket_id; do
  [ -n "$ticket_id" ] || continue

  ticket_block="$(awk -v heading="### $ticket_id:" '
    index($0, heading) == 1 { found = 1 }
    found && $0 ~ /^### / && index($0, heading) != 1 { exit }
    found { print }
  ' "$TRACKER")"

  if [ -z "$ticket_block" ]; then
    echo "ERROR: unable to read ticket block for $ticket_id" >&2
    exit 1
  fi

  for field in "${required_fields[@]}"; do
    field_count="$(printf '%s\n' "$ticket_block" | grep -Ec -- "$field" || true)"
    if [ "$field_count" -ne 1 ]; then
      echo "ERROR: $ticket_id must contain exactly one field matching: $field" >&2
      echo "       found $field_count" >&2
      exit 1
    fi
  done
done <<EOF
$ticket_ids
EOF

summary_statuses=(EN_CURSO PENDIENTE BLOQUEADO HECHO CANCELADO)
for status in "${summary_statuses[@]}"; do
  count="$(grep -Ec -- "^- Estado: $status$" "$TRACKER" || true)"
  summary_counts="$(awk -F '|' -v status="$status" '
    $2 ~ "^[[:space:]]*`" status "`[[:space:]]*$" {
      value = $3
      gsub(/[[:space:]]/, "", value)
      print value
    }
  ' "$TRACKER")"
  summary_row_count="$(printf '%s\n' "$summary_counts" | sed '/^$/d' | wc -l | tr -d ' ')"

  if [ "$summary_row_count" -ne 1 ]; then
    echo "ERROR: summary table must contain exactly one row for $status" >&2
    exit 1
  fi
  if [ "$summary_counts" -ne "$count" ]; then
    echo "ERROR: summary table says $status=$summary_counts but tickets say $count" >&2
    exit 1
  fi

  printf '%s=%s ' "$status" "$count"
done
printf '\nTicket tracker valid: %s tickets.\n' "$ticket_count"
