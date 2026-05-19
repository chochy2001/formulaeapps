#!/usr/bin/env bash
# sync-working-trees.sh — US1 zombie reconciliation helper
#
# Per specs/002-formulae-fe-be-sync/research.md § R10 and tasks.md T011.
#
# For each modified file between a zombie clone and the matching canonical
# subdir, present the diff and prompt for classification:
#   r = replay-in-canonical  (file is staged for later PR via copy)
#   d = discard               (file is recorded as scratch/experimental)
#   c = already-in-canonical  (no action — equivalent content already there)
#   s = skip                  (review later; nothing finalized)
#
# Dispositions are appended to the audit manifest as rows shaped by E11
# (path | disposition | rationale). Staged files for "replay" land under
# `.sync-staging/<canonical-subdir>/<relative-path>` so the user can `cp` them
# into the canonical working tree before opening a PR (T015).
#
# Usage:
#   bash scripts/sync-working-trees.sh <zombie-path> <canonical-subdir-name>
#
# Examples:
#   bash scripts/sync-working-trees.sh ~/Documents/Apps/FormulaeApps/FormulaePro pro
#   bash scripts/sync-working-trees.sh ~/Documents/Apps/FormulaeApps/FormulaeCommunity community
#
# Env overrides:
#   WORKING_TREES_MANIFEST   path to the disposition manifest (default:
#                            ~/Documents/Apps/specs/002-formulae-fe-be-sync/audit/working-trees-2026-05-18.md)
#   STAGING_ROOT             where to copy "replay" files (default: <repo-root>/.sync-staging)
#   NONINTERACTIVE           if "1", classify everything as "skip" and only
#                            append a section listing the diffs (useful for CI dry-run)
#
# Exit: 0 done, 2 setup error.

set -euo pipefail

if [ "$#" -ne 2 ]; then
  cat >&2 <<EOF
Usage: $0 <zombie-path> <canonical-subdir-name>
Example: $0 ~/Documents/Apps/FormulaeApps/FormulaePro pro
EOF
  exit 2
fi

ZOMBIE_PATH="${1%/}"
CANONICAL_SUBDIR="$2"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CANONICAL_PATH="$ROOT/$CANONICAL_SUBDIR"

DEFAULT_MANIFEST="$HOME/Documents/Apps/specs/002-formulae-fe-be-sync/audit/working-trees-2026-05-18.md"
MANIFEST="${WORKING_TREES_MANIFEST:-$DEFAULT_MANIFEST}"
STAGING_DIR="${STAGING_ROOT:-$ROOT/.sync-staging}/$CANONICAL_SUBDIR"

# ─────────────────── pre-flight ───────────────────

if [ ! -d "$ZOMBIE_PATH" ]; then
  echo "ERROR: zombie path '$ZOMBIE_PATH' does not exist." >&2
  exit 2
fi
if [ ! -d "$CANONICAL_PATH" ]; then
  echo "ERROR: canonical path '$CANONICAL_PATH' does not exist." >&2
  exit 2
fi
if [ ! -f "$MANIFEST" ]; then
  echo "ERROR: audit manifest '$MANIFEST' does not exist." >&2
  echo "Hint: it is seeded by T014 (see audit/working-trees-2026-05-18.md)." >&2
  exit 2
fi

mkdir -p "$STAGING_DIR"

cat <<EOF
Comparing zombie:    $ZOMBIE_PATH
Against canonical:   $CANONICAL_PATH
Manifest:            $MANIFEST
Staging (replays):   $STAGING_DIR
Mode:                $([ -n "${NONINTERACTIVE:-}" ] && echo "non-interactive (dry-run)" || echo "interactive")

EOF

# ─────────────────── diff enumeration ───────────────────

diff_lines=$(diff -rq \
  --exclude='node_modules' \
  --exclude='dist' \
  --exclude='build' \
  --exclude='out' \
  --exclude='.dart_tool' \
  --exclude='.flutter-plugins*' \
  --exclude='.astro' \
  --exclude='ios/Pods' \
  --exclude='android/.gradle' \
  --exclude='.idea' \
  --exclude='.vscode' \
  --exclude='*.lock' \
  --exclude='*.lockb' \
  --exclude='pubspec.lock' \
  --exclude='package-lock.json' \
  "$ZOMBIE_PATH" "$CANONICAL_PATH" 2>/dev/null || true)

if [ -z "$diff_lines" ]; then
  echo "✓ Zero diffs (after excludes) — zombie is already in sync with canonical $CANONICAL_SUBDIR/."
  {
    echo ""
    echo "## $(basename "$ZOMBIE_PATH") vs canonical $CANONICAL_SUBDIR/ — $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo ""
    echo "No diffs detected after standard excludes."
    echo ""
    printf "| %s | synced | clean diff after standard excludes |\n" "$ZOMBIE_PATH"
  } >> "$MANIFEST"
  exit 0
fi

# ─────────────────── audit section header ───────────────────

{
  echo ""
  echo "## $(basename "$ZOMBIE_PATH") vs canonical $CANONICAL_SUBDIR/ — $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo ""
  echo "Diff method: \`diff -rq\` with standard excludes (\`node_modules\`, \`dist\`, \`build\`, \`.dart_tool\`, IDE caches, lockfiles)."
  echo ""
  echo "| path | disposition | rationale |"
  echo "|------|-------------|-----------|"
} >> "$MANIFEST"

replayed=0
discarded=0
already=0
skipped=0

# ─────────────────── per-file classification ───────────────────

# diff -rq emits two line shapes:
#   Only in <dir>: <name>          (file exists on one side only)
#   Files <a> and <b> differ       (file exists both sides with different content)

classify() {
  local rel_path="$1"
  local rationale_default="$2"
  local extra="$3"  # absolute path to source file for replay (if applicable)

  if [ -n "${NONINTERACTIVE:-}" ]; then
    printf "| %s | skip | %s (non-interactive) |\n" "$rel_path" "$rationale_default" >> "$MANIFEST"
    skipped=$((skipped + 1))
    return
  fi

  while true; do
    printf "  Classify [r=replay  d=discard  c=already-in-canonical  s=skip] " >&2
    read -r choice
    case "$choice" in
      r|R)
        if [ -n "$extra" ] && [ -f "$extra" ]; then
          local dest="$STAGING_DIR/$rel_path"
          mkdir -p "$(dirname "$dest")"
          cp "$extra" "$dest"
          printf "| %s | replayed-in-canonical | staged at %s — open PR via T015 |\n" \
            "$rel_path" ".sync-staging/$CANONICAL_SUBDIR/$rel_path" >> "$MANIFEST"
        else
          printf "| %s | replayed-in-canonical | source not stage-able (only-in-zombie dir?); manual review |\n" \
            "$rel_path" >> "$MANIFEST"
        fi
        replayed=$((replayed + 1))
        return
        ;;
      d|D)
        local why
        printf "    Discard rationale (single line, optional): " >&2
        read -r why
        if [ -z "$why" ]; then why="$rationale_default; classified as scratch/experimental"; fi
        printf "| %s | discarded | %s |\n" "$rel_path" "$why" >> "$MANIFEST"
        discarded=$((discarded + 1))
        return
        ;;
      c|C)
        printf "| %s | already-in-canonical | user-classified equivalent |\n" "$rel_path" >> "$MANIFEST"
        already=$((already + 1))
        return
        ;;
      s|S|"")
        printf "  (skipped — recorded but not finalized)\n" >&2
        printf "| %s | skip | deferred to a later run |\n" "$rel_path" >> "$MANIFEST"
        skipped=$((skipped + 1))
        return
        ;;
      *)
        printf "    invalid choice '%s' — try r/d/c/s\n" "$choice" >&2
        ;;
    esac
  done
}

while IFS= read -r line; do
  [ -z "$line" ] && continue

  if [[ "$line" == "Only in $ZOMBIE_PATH"* ]]; then
    src_dir="${line#Only in }"
    src_dir="${src_dir%: *}"
    src_name="${line##*: }"
    src_path="$src_dir/$src_name"
    rel="${src_path#$ZOMBIE_PATH/}"
    echo "" >&2
    echo "─── ONLY IN ZOMBIE: $rel ───" >&2
    if [ -f "$src_path" ]; then
      echo "  (size: $(wc -c < "$src_path" 2>/dev/null || echo '?') bytes)" >&2
    elif [ -d "$src_path" ]; then
      echo "  (directory; entries: $(find "$src_path" -maxdepth 1 -mindepth 1 | wc -l | tr -d ' '))" >&2
    fi
    classify "$rel" "only-in-zombie" "$src_path"
    continue
  fi

  if [[ "$line" == "Only in $CANONICAL_PATH"* ]]; then
    src_dir="${line#Only in }"
    src_dir="${src_dir%: *}"
    src_name="${line##*: }"
    src_path="$src_dir/$src_name"
    rel="${src_path#$CANONICAL_PATH/}"
    echo "" >&2
    echo "─── ONLY IN CANONICAL: $rel (no zombie work to migrate) ───" >&2
    printf "| %s | already-in-canonical | canonical-only — no zombie counterpart |\n" "$rel" >> "$MANIFEST"
    already=$((already + 1))
    continue
  fi

  if [[ "$line" == "Files "*" and "*" differ" ]]; then
    rest="${line#Files }"
    zombie_file="${rest% and *}"
    rest="${rest#* and }"
    canonical_file="${rest% differ}"
    rel="${zombie_file#$ZOMBIE_PATH/}"
    echo "" >&2
    echo "─── DIFFERS: $rel ───" >&2
    diff -u --label "canonical/$rel" --label "zombie/$rel" "$canonical_file" "$zombie_file" 2>/dev/null | head -50 >&2 || true
    classify "$rel" "files differ between zombie and canonical" "$zombie_file"
    continue
  fi

  echo "  (unrecognized diff line: $line)" >&2
done <<< "$diff_lines"

# ─────────────────── summary ───────────────────

cat >&2 <<EOF

─── Summary ───
  Replayed (staged for PR):  $replayed → $STAGING_DIR
  Discarded:                 $discarded
  Already-in-canonical:      $already
  Skipped (deferred):        $skipped

Manifest updated: $MANIFEST
EOF

if [ "$replayed" -gt 0 ]; then
  cat >&2 <<EOF

Next step (T015): review files in $STAGING_DIR, copy/move them into the
canonical clone $CANONICAL_PATH/, commit, push to a topic branch, and open a
PR against CAPDESIS/formulaeapps with title prefix 'from-zombie-clone:'.
EOF
fi

exit 0
