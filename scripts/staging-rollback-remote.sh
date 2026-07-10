#!/usr/bin/env bash
# Roll back staging BFF to the prior artifact while preserving JWT_SIGNING_SECRET.
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
app_path = Path(config['app_path'])
compose_file = 'docker-compose.staging.yml'
project = 'formulaeapps-staging'
state_path = app_path / '.staging-deploy-state.json'

os.chdir(app_path)

if not state_path.is_file():
    print('rollback: no prior deploy state recorded', file=sys.stderr)
    raise SystemExit(1)

state = json.loads(state_path.read_text())
prior_sha = state.get('prior_sha', '')
prior_image = state.get('prior_image', '')

signing_line = None
for line in Path('.env').read_text().splitlines():
    if line.startswith('JWT_SIGNING_SECRET='):
        signing_line = line
        break
if signing_line is None:
    print('rollback: JWT_SIGNING_SECRET missing from .env', file=sys.stderr)
    raise SystemExit(1)

if prior_sha:
    subprocess.run(['git', 'checkout', '--force', prior_sha], check=True)
    Path('.env.staging').write_text(Path('.env').read_text())
    lines = Path('.env.staging').read_text().splitlines()
    kept = [line for line in lines if not line.startswith('JWT_SIGNING_SECRET=')]
    kept.append(signing_line)
    text = '\n'.join(kept) + '\n'
    Path('.env.staging').write_text(text)
    Path('.env').write_text(text)
    Path('DEPLOYED_SHA').write_text(prior_sha + '\n')

if prior_image:
    subprocess.run(
        ['docker', 'compose', '-f', compose_file, '-p', project, 'build', 'bff'],
        check=False,
    )

subprocess.run(
    ['docker', 'compose', '-f', compose_file, '-p', project, 'up', '-d', '--no-deps', 'bff'],
    check=True,
)
print('rollback: staging BFF restored')
PY
