#!/usr/bin/env bash
# Honest line-coverage summary from an LCOV file (Flutter, Bun, or Vitest).
#
# Prints RAW LF/LH % and an optional NO_GENERATED view (excl. l10n / .g.dart /
# .freezed.dart / .mocks.dart). Never excludes under-test production code to
# inflate the percentage.
#
# Usage:
#   bash scripts/coverage-summary.sh <lcov.info> [label]
#   bash scripts/coverage-summary.sh <lcov.info> [label] --gate 85
#
# Soft-report by default. With --gate N, exit 1 if RAW % < N.
set -euo pipefail

LCOV="${1:-}"
LABEL="${2:-coverage}"
GATE=""

if [[ -z "$LCOV" ]]; then
  echo "usage: $0 <lcov.info> [label] [--gate N]" >&2
  exit 2
fi

shift || true
if [[ "${1:-}" != "" && "${1:-}" != --gate ]]; then
  LABEL="$1"
  shift || true
fi
if [[ "${1:-}" == --gate ]]; then
  GATE="${2:-85}"
fi

if [[ ! -f "$LCOV" ]]; then
  echo "Missing LCOV file: $LCOV" >&2
  exit 1
fi

python3 - "$LCOV" "$LABEL" "$GATE" <<'PY'
import sys
from pathlib import Path

lcov_path = Path(sys.argv[1])
label = sys.argv[2]
gate_raw = sys.argv[3]

raw_lf = raw_lh = 0
nog_lf = nog_lh = 0


def is_generated(path: str) -> bool:
    p = path.replace("\\", "/")
    return (
        "/l10n/" in p
        or p.endswith(".g.dart")
        or p.endswith(".freezed.dart")
        or p.endswith(".mocks.dart")
    )


current = None
lf = lh = 0
for line in lcov_path.read_text(errors="ignore").splitlines():
    if line.startswith("SF:"):
        current = line[3:].strip()
        lf = lh = 0
    elif line.startswith("LF:"):
        lf = int(line[3:] or "0")
    elif line.startswith("LH:"):
        lh = int(line[3:] or "0")
    elif line.strip() == "end_of_record" and current is not None:
        raw_lf += lf
        raw_lh += lh
        if not is_generated(current):
            nog_lf += lf
            nog_lh += lh
        current = None


def pct(h: int, f: int) -> float:
    return (100.0 * h / f) if f else 0.0


raw = pct(raw_lh, raw_lf)
nog = pct(nog_lh, nog_lf)

print(f"=== {label} (honest line coverage) ===")
print(f"RAW (all instrumented lines):              {raw_lh}/{raw_lf} = {raw:.2f}%")
if nog_lf:
    print(f"NO_GENERATED (excl. l10n/.g/.freezed/mocks): {nog_lh}/{nog_lf} = {nog:.2f}%")
else:
    print("NO_GENERATED: n/a (no non-generated SF records)")
print("Mode: soft-report (informational)" if not gate_raw else f"Mode: gate RAW >= {gate_raw}%")

# Append to GITHUB_STEP_SUMMARY when running in Actions.
import os

summary_env = os.environ.get("GITHUB_STEP_SUMMARY", "").strip()
if summary_env:
    summary = Path(summary_env)
    # Guard against empty/`.` paths outside Actions.
    if summary.is_file() or (not summary.exists() and summary.parent.is_dir() and summary.name):
        with summary.open("a", encoding="utf-8") as fh:
            fh.write(f"## {label}\n\n")
            fh.write(f"- **RAW:** `{raw_lh}/{raw_lf}` = **{raw:.2f}%**\n")
            if nog_lf:
                fh.write(
                    f"- **NO_GENERATED:** `{nog_lh}/{nog_lf}` = **{nog:.2f}%** "
                    "(excl. l10n / `.g.dart` / `.freezed.dart` / `.mocks.dart`)\n"
                )
            fh.write(
                "- Soft report only — not a fake-green filtered gate. "
                "Denominator is instrumented LCOV LF/LH.\n\n"
            )

if gate_raw:
    threshold = float(gate_raw)
    if raw + 1e-9 < threshold:
        print(f"GATE FAIL: RAW {raw:.2f}% < {threshold:.0f}%")
        sys.exit(1)
    print(f"GATE PASS: RAW {raw:.2f}% >= {threshold:.0f}%")
PY
