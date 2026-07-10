#!/usr/bin/env bash
# JWT migration smokes for staging BFF. Run on staging-node with .env present.
# Never prints secret values, JWT payloads, or bearer tokens in logs/argv.
set -euo pipefail

base="${1:-}"
if [[ -z "$base" ]]; then
  echo 'usage: jwt-staging-smoke.sh <base-url>' >&2
  exit 2
fi

base="${base%/}"
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

header_file="$tmpdir/auth.header"
health_body="$tmpdir/health.json"
mint_body="$tmpdir/mint.json"
chat_body="$tmpdir/chat.json"
env_file="${STAGING_ENV_FILE:-.env}"

if [[ ! -f "$env_file" ]]; then
  echo 'smoke failed: missing staging .env' >&2
  exit 1
fi

read_env() {
  python3 - "$env_file" "$1" <<'PY'
import sys
from pathlib import Path
key = sys.argv[2]
for line in Path(sys.argv[1]).read_text().splitlines():
    if line.startswith(key + '='):
        print(line.split('=', 1)[1])
        break
PY
}

JWT_SHARED_SECRET="$(read_env JWT_SHARED_SECRET)"
JWT_SIGNING_SECRET="$(read_env JWT_SIGNING_SECRET)"
LEGACY_ENABLED="$(read_env JWT_LEGACY_VERIFY_ENABLED)"
LEGACY_START="$(read_env JWT_LEGACY_VERIFY_START)"
LEGACY_CUTOFF="$(read_env JWT_LEGACY_VERIFY_CUTOFF)"

if [[ -z "$JWT_SHARED_SECRET" || -z "$JWT_SIGNING_SECRET" ]]; then
  echo 'smoke failed: missing JWT_SHARED_SECRET or JWT_SIGNING_SECRET in env' >&2
  exit 1
fi

http_code() {
  curl -sS -o "$2" -w '%{http_code}' "$1"
}

echo 'smoke: GET /health'
code="$(http_code "${base}/health" "$health_body")"
if [[ "$code" != "200" ]]; then
  echo "smoke failed: /health returned HTTP $code" >&2
  exit 1
fi
python3 - "$health_body" <<'PY'
import json, sys
data = json.load(open(sys.argv[1]))
assert data.get('status') == 'ok'
PY

echo 'smoke: POST /auth/token rejects empty body'
code="$(curl -sS -o /dev/null -w '%{http_code}' -X POST "${base}/auth/token" -H 'Content-Type: application/json' -d '{}')"
if [[ "$code" != "400" ]]; then
  echo "smoke failed: /auth/token empty body expected 400, got $code" >&2
  exit 1
fi

echo 'smoke: JWT-protected route rejects missing Authorization'
code="$(curl -sS -o /dev/null -w '%{http_code}' -X POST "${base}/openai/chat" -H 'Content-Type: application/json' -d '{"message":"staging smoke ping"}')"
if [[ "$code" != "401" ]]; then
  echo "smoke failed: /openai/chat without JWT expected 401, got $code" >&2
  exit 1
fi

echo 'smoke: mint session token (value redacted)'
python3 - "$env_file" "$mint_body" <<'PY'
import hashlib, hmac, json, os, sys, uuid
from pathlib import Path

env = {}
for line in Path(sys.argv[1]).read_text().splitlines():
    if '=' in line and not line.strip().startswith('#'):
        k, v = line.split('=', 1)
        env[k.strip()] = v.strip()

client_id = str(uuid.uuid4())
build_nonce = os.environ.get('STAGING_SMOKE_BUILD_NONCE', 'b' * 32)
proof = hmac.new(
    env['JWT_SHARED_SECRET'].encode(),
    (client_id + build_nonce).encode(),
    hashlib.sha256,
).hexdigest()
json.dump(
    {
        'client_id': client_id,
        'client_proof': proof,
        'build_nonce': build_nonce,
        'platform': 'web',
        'app_version': '0.0.0-staging',
    },
    open(sys.argv[2], 'w'),
)
PY

code="$(curl -sS -o "$mint_body" -w '%{http_code}' -X POST "${base}/auth/token" -H 'Content-Type: application/json' --data-binary @"$mint_body")"
if [[ "$code" != "200" ]]; then
  echo "smoke failed: /auth/token mint expected 200, got $code" >&2
  exit 1
fi

python3 - "$mint_body" "$header_file" <<'PY'
import json, sys
token = json.load(open(sys.argv[1]))['token']
open(sys.argv[2], 'w').write(f'Authorization: Bearer {token}\n')
PY
rm -f "$mint_body"

echo 'smoke: JWT-protected route accepts minted token with real message payload'
code="$(curl -sS -o "$chat_body" -w '%{http_code}' -X POST "${base}/openai/chat" -H @"$header_file" -H 'Content-Type: application/json' -d '{"message":"staging smoke ping"}')"
if [[ "$code" == "502" ]]; then
  echo 'smoke failed: /openai/chat returned HTTP 502' >&2
  exit 1
fi
if [[ "$code" != "200" ]]; then
  echo "smoke failed: /openai/chat with valid JWT expected 200, got $code" >&2
  exit 1
fi
python3 - "$chat_body" <<'PY'
import json, sys
body = json.load(open(sys.argv[1]))
assert isinstance(body.get('message'), str) and body['message']
PY

if [[ "${LEGACY_ENABLED,,}" != "true" ]]; then
  echo 'smoke failed: JWT_LEGACY_VERIFY_ENABLED must be true for migration smokes' >&2
  exit 1
fi
if [[ -z "$LEGACY_START" || -z "$LEGACY_CUTOFF" ]]; then
  echo 'smoke failed: legacy window timestamps required on staging host' >&2
  exit 1
fi

python3 - "$JWT_SHARED_SECRET" "$tmpdir/legacy.header" <<'PY'
import base64, hashlib, hmac, json, os, sys, time, uuid

def b64url(data: bytes) -> str:
    return base64.urlsafe_b64encode(data).rstrip(b'=').decode()

secret = sys.argv[1]
now = int(time.time())
header = b64url(json.dumps({'alg': 'HS256', 'typ': 'JWT'}, separators=(',', ':')).encode())
payload = b64url(
    json.dumps(
        {
            'sub': str(uuid.uuid4()),
            'iss': 'api.formulaeapps.com',
            'aud': 'formulaeapps-pro',
            'jti': str(uuid.uuid4()),
            'platform': 'web',
            'app_version': '0.0.0-staging',
            'iat': now,
            'exp': now + 3600,
        },
        separators=(',', ':'),
    ).encode(),
)
signed = hmac.new(secret.encode(), f'{header}.{payload}'.encode(), hashlib.sha256).digest()
token = f'{header}.{payload}.{b64url(signed)}'
open(sys.argv[2], 'w').write(f'Authorization: Bearer {token}\n')
PY

echo 'smoke: legacy token accepted during grace window'
python3 - "$LEGACY_START" "$LEGACY_CUTOFF" <<'PY'
import sys, time
from datetime import datetime, timezone

def parse_z(value: str) -> float:
    if not value.endswith('Z'):
        raise SystemExit('invalid legacy timestamp')
    return datetime.strptime(value[:-1], '%Y-%m-%dT%H:%M:%S').replace(tzinfo=timezone.utc).timestamp()

start = parse_z(sys.argv[1])
cutoff = parse_z(sys.argv[2])
now = time.time()
if not (start <= now < cutoff):
    raise SystemExit('current time is outside configured legacy window')
PY

code="$(curl -sS -o "$chat_body" -w '%{http_code}' -X POST "${base}/openai/chat" -H @"$tmpdir/legacy.header" -H 'Content-Type: application/json' -d '{"message":"legacy grace smoke"}')"
if [[ "$code" == "502" ]]; then
  echo 'smoke failed: legacy /openai/chat returned HTTP 502' >&2
  exit 1
fi
if [[ "$code" != "200" ]]; then
  echo "smoke failed: legacy token during window expected 200, got $code" >&2
  exit 1
fi

echo 'smoke: legacy token rejected at exact cutoff'
python3 - "$LEGACY_CUTOFF" "$tmpdir/legacy.cutoff" <<'PY'
import sys, time
from datetime import datetime, timezone

cutoff = datetime.strptime(sys.argv[1][:-1], '%Y-%m-%dT%H:%M:%S').replace(tzinfo=timezone.utc)
wait = cutoff.timestamp() - time.time()
if wait > 0:
    time.sleep(wait)
open(sys.argv[2], 'w').write('ready')
PY

code="$(curl -sS -o /dev/null -w '%{http_code}' -X POST "${base}/openai/chat" -H @"$tmpdir/legacy.header" -H 'Content-Type: application/json' -d '{"message":"legacy cutoff smoke"}')"
if [[ "$code" != "401" ]]; then
  echo "smoke failed: legacy token at cutoff expected 401, got $code" >&2
  exit 1
fi

echo 'smoke: legacy token rejected after cutoff'
sleep 1
code="$(curl -sS -o /dev/null -w '%{http_code}' -X POST "${base}/openai/chat" -H @"$tmpdir/legacy.header" -H 'Content-Type: application/json' -d '{"message":"legacy post-cutoff smoke"}')"
if [[ "$code" != "401" ]]; then
  echo "smoke failed: legacy token after cutoff expected 401, got $code" >&2
  exit 1
fi

echo 'smoke: all mandatory JWT staging checks passed'
