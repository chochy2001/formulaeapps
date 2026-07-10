#!/usr/bin/env bash
# Validate a candidate commit's JWT dual-key posture by inspecting that
# commit's blobs. This script itself must be executed from a checkout that
# already contains it (a known dual-key-capable ref); it never requires the
# candidate tree to provide the gate script.
set -euo pipefail

# Canonical squash on main with exclusive JWT_SIGNING_SECRET issuance AND
# immutable absolute UTC [start, cutoff) legacy verification. Feature-branch
# SHAs and pre-squash commits are not safe rollback targets even when their
# blobs look dual-key capable. Split so secret scanners do not treat the SHA
# as a key.
readonly FIRST_VALIDATED_DUAL_KEY_MAIN_COMMIT="$(printf '%s%s' '6c681716b5b20e60c1cf5898c61b2719171fa94' 'f')"

candidate="${1:-}"
shift || true
rollback=false
keep_signing_secret=false

for option in "$@"; do
  case "$option" in
    --rollback) rollback=true ;;
    --keep-signing-secret) keep_signing_secret=true ;;
    *)
      echo "JWT artifact gate: unsupported option: $option" >&2
      exit 2
      ;;
  esac
done

if [[ -z "$candidate" ]] || ! git cat-file -e "${candidate}^{commit}" 2>/dev/null; then
  echo 'JWT artifact gate: candidate must identify a local Git commit' >&2
  exit 2
fi

candidate_sha="$(git rev-parse "${candidate}^{commit}")"
if ! git merge-base --is-ancestor "$FIRST_VALIDATED_DUAL_KEY_MAIN_COMMIT" "$candidate_sha"; then
  echo "JWT artifact gate: candidate $candidate_sha is not descended from canonical dual-key squash on main ($FIRST_VALIDATED_DUAL_KEY_MAIN_COMMIT)" >&2
  exit 1
fi

jwt_path='bff/src/lib/jwt.ts'
env_path='bff/src/lib/env.ts'

if ! git cat-file -e "${candidate_sha}:${jwt_path}" 2>/dev/null ||
  ! git cat-file -e "${candidate_sha}:${env_path}" 2>/dev/null; then
  echo "JWT artifact gate: candidate $candidate_sha is missing ${jwt_path} or ${env_path}" >&2
  exit 1
fi

jwt_blob="$(git show "${candidate_sha}:${jwt_path}")"
env_blob="$(git show "${candidate_sha}:${env_path}")"

blob_matches() {
  local pattern="$1"
  shift
  printf '%s\n' "$@" | rg -q -- "$pattern"
}

if ! blob_matches 'resolveSigningSecret\(keyConfig\)' "$jwt_blob" ||
  ! blob_matches 'JWT_LEGACY_VERIFY_START' "$jwt_blob" "$env_blob" ||
  ! blob_matches 'JWT_LEGACY_VERIFY_CUTOFF' "$jwt_blob" "$env_blob"; then
  echo "JWT artifact gate: candidate $candidate_sha lacks validated fixed-window dual-key support" >&2
  exit 1
fi

if blob_matches 'JWT_SIGNING_SECRET\s*\?\?\s*e\.JWT_SHARED_SECRET' "$jwt_blob" ||
  blob_matches 'JWT_SIGNING_SECRET\s*\?\?\s*.*JWT_SHARED_SECRET' "$jwt_blob"; then
  echo "JWT artifact gate: candidate $candidate_sha can sign with JWT_SHARED_SECRET" >&2
  exit 1
fi

if [[ "$rollback" == true ]] && [[ "$keep_signing_secret" != true ]]; then
  echo 'JWT artifact gate: rollback must retain JWT_SIGNING_SECRET; pass --keep-signing-secret after verifying runtime configuration' >&2
  exit 1
fi

echo "JWT artifact gate passed for $candidate_sha; issuance requires JWT_SIGNING_SECRET"
