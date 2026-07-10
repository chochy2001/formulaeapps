#!/usr/bin/env bash
# Remote staging BFF deploy. Reads JSON config from stdin; never interpolates
# caller-controlled strings into shell fragments.
set -euo pipefail

CONFIG="$(mktemp)"
trap 'rm -f "$CONFIG"' EXIT
cat >"$CONFIG"

python3 - "$CONFIG" <<'PY'
import json
import os
import subprocess
import sys
from pathlib import Path

config_path = Path(sys.argv[1])
config = json.loads(config_path.read_text())

required = ('candidate_sha', 'app_path')
for key in required:
    if key not in config or not config[key]:
        raise SystemExit(f'missing config field: {key}')

app_path = Path(config['app_path'])
candidate_sha = config['candidate_sha']
legacy_start = config.get('legacy_verify_start')
legacy_cutoff = config.get('legacy_verify_cutoff')
compose_file = 'docker-compose.staging.yml'
project = 'formulaeapps-staging'
state_path = app_path / '.staging-deploy-state.json'
deployed_sha_path = app_path / 'DEPLOYED_SHA'

os.chdir(app_path)

if not Path('.env.staging').is_file():
    print('Missing .env.staging on staging host', file=sys.stderr)
    raise SystemExit(1)

prior_sha = deployed_sha_path.read_text().strip() if deployed_sha_path.is_file() else ''
prior_image = ''
inspect = subprocess.run(
    ['docker', 'compose', '-f', compose_file, '-p', project, 'images', '-q', 'bff'],
    capture_output=True,
    text=True,
    check=False,
)
if inspect.returncode == 0:
    prior_image = inspect.stdout.strip().splitlines()[-1] if inspect.stdout.strip() else ''

state_path.write_text(
    json.dumps({'prior_sha': prior_sha, 'prior_image': prior_image, 'candidate_sha': candidate_sha})
)

Path('.env').write_text(Path('.env.staging').read_text())

if legacy_start and legacy_cutoff:
    lines = []
    for line in Path('.env').read_text().splitlines():
        if line.startswith('JWT_LEGACY_VERIFY_ENABLED='):
            lines.append('JWT_LEGACY_VERIFY_ENABLED=true')
        elif line.startswith('JWT_LEGACY_VERIFY_START='):
            lines.append(f'JWT_LEGACY_VERIFY_START={legacy_start}')
        elif line.startswith('JWT_LEGACY_VERIFY_CUTOFF='):
            lines.append(f'JWT_LEGACY_VERIFY_CUTOFF={legacy_cutoff}')
        else:
            lines.append(line)
    text = '\n'.join(lines) + '\n'
    if 'JWT_LEGACY_VERIFY_ENABLED=' not in text:
        text += 'JWT_LEGACY_VERIFY_ENABLED=true\n'
    if 'JWT_LEGACY_VERIFY_START=' not in text:
        text += f'JWT_LEGACY_VERIFY_START={legacy_start}\n'
    if 'JWT_LEGACY_VERIFY_CUTOFF=' not in text:
        text += f'JWT_LEGACY_VERIFY_CUTOFF={legacy_cutoff}\n'
    Path('.env').write_text(text)

subprocess.run(
    ['docker', 'compose', '-f', compose_file, '-p', project, 'build', 'bff'],
    check=True,
)
subprocess.run(
    ['docker', 'compose', '-f', compose_file, '-p', project, 'up', '-d', '--no-deps', 'bff'],
    check=True,
)

deployed_sha_path.write_text(candidate_sha + '\n')
print(f'DEPLOYED_SHA={candidate_sha}')
PY
