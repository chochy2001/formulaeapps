#!/usr/bin/env python3
"""Isolated tests for immutable staging deploy/rollback helpers."""
from __future__ import annotations

import json
import os
import stat
import subprocess
import sys
import tempfile
import unittest
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

sys.path.insert(0, str(Path(__file__).resolve().parent))
import staging_lib as lib  # noqa: E402


@dataclass
class FakeRunner:
    calls: list[list[str]] = field(default_factory=list)
    images: dict[str, str] = field(default_factory=dict)
    fail_actions: set[str] = field(default_factory=set)
    fail_first_actions: set[str] = field(default_factory=set)
    failed_first_actions: set[str] = field(default_factory=set)
    build_count: int = 0

    def _action(self, args: list[str]) -> str | None:
        if len(args) >= 2 and args[0:2] == ['docker', 'compose']:
            for action in ('build', 'up', 'images'):
                if action in args:
                    return action
        if args[:2] == ['docker', 'tag']:
            return 'tag'
        return None

    def run(
        self,
        args: list[str],
        *,
        cwd: Path | None = None,
        check: bool = True,
        capture: bool = False,
        env: dict[str, str] | None = None,
    ) -> subprocess.CompletedProcess[str]:
        self.calls.append(args)
        action = self._action(args)
        if action in self.fail_actions:
            if check:
                raise subprocess.CalledProcessError(1, args)
            return subprocess.CompletedProcess(args, 1, '', 'failed')
        if action in self.fail_first_actions and action not in self.failed_first_actions:
            self.failed_first_actions.add(action)
            if check:
                raise subprocess.CalledProcessError(1, args)
            return subprocess.CompletedProcess(args, 1, '', 'failed')
        if action == 'build':
            self.build_count += 1
        if action == 'images':
            image = self.images.get(str(cwd), 'sha256:built')
            stdout = f'{image}\n'
            return subprocess.CompletedProcess(args, 0, stdout, '')
        return subprocess.CompletedProcess(args, 0, '', '')


def write_env(path: Path) -> None:
    path.write_text(
        '\n'.join(
            [
                'BFF_ENV=staging',
                'JWT_SIGNING_SECRET=' + 'a' * 64,
                'JWT_SHARED_SECRET=' + 'b' * 64,
                'JWT_LEGACY_VERIFY_ENABLED=true',
                'JWT_LEGACY_VERIFY_START=2026-07-10T00:00:00Z',
                'JWT_LEGACY_VERIFY_CUTOFF=2026-07-10T00:10:00Z',
                'OPENROUTER_API_KEY=sk-or-v1-test',
            ]
        )
        + '\n'
    )
    path.chmod(stat.S_IRUSR | stat.S_IWUSR)


def seed_release(root: Path, sha: str, runner: FakeRunner, *, link_current: bool = True) -> Path:
    release = lib.release_path(root, sha)
    release.mkdir(parents=True)
    (release / 'bff').mkdir()
    (release / lib.COMPOSE_FILE).write_text('services:\n  bff:\n    image: test\n')
    (release / 'DEPLOYED_SHA').write_text(sha + '\n')
    runner.images[str(release)] = f'sha256:prior-{sha[:8]}'
    if link_current:
        lib.switch_current_release(root, release)
    return release


class StagingLibTests(unittest.TestCase):
    def test_valid_utc_fractions_and_impossible_dates(self) -> None:
        lib.validate_legacy_window('2026-07-10T00:00:00.000Z', '2026-07-10T00:10:00.500Z', max_window_ms=lib.STAGING_MAX_WINDOW_MS)
        with self.assertRaises(ValueError):
            lib.parse_utc_z('2026-02-30T00:00:00Z')
        with self.assertRaises(ValueError):
            lib.validate_legacy_window('2026-07-10T00:10:00Z', '2026-07-10T00:00:00Z')

    def test_staging_window_incompatible_with_timeout_rejected(self) -> None:
        with self.assertRaises(ValueError):
            lib.validate_staging_job_window('2026-07-10T00:00:00Z', '2026-07-10T00:50:00Z', job_timeout_minutes=45)

    def test_path_guards_reject_empty_root_symlink(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / 'formulaeapps'
            root.mkdir()
            allowed = str(root)
            with self.assertRaises(ValueError):
                lib.resolve_allowed_root('', allowed)
            with self.assertRaises(ValueError):
                lib.resolve_allowed_root('/', allowed)
            outside = Path(tmp) / 'outside'
            outside.mkdir()
            with self.assertRaises(ValueError):
                lib.resolve_allowed_root(str(outside), allowed)
            link = root / 'link'
            link.symlink_to(root / 'releases')
            with self.assertRaises(ValueError):
                lib.resolve_allowed_root(str(link), allowed)

    def test_wrong_host_marker_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            marker = Path(tmp) / 'role'
            marker.write_text('production\n')
            with self.assertRaises(RuntimeError):
                lib.verify_host_role(marker, 'staging')

    def test_bootstrap_without_baseline_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            runner = FakeRunner()
            candidate = 'c' * 40
            prior = 'a' * 40
            write_env(root / lib.PERSISTENT_ENV_NAME)
            seed_release(root, prior, runner, link_current=False)
            lib.release_path(root, candidate).mkdir(parents=True)
            (lib.release_path(root, candidate) / lib.COMPOSE_FILE).write_text('services:\n  bff:\n    image: test\n')
            with self.assertRaises(RuntimeError):
                lib.deploy_candidate(
                    root,
                    candidate,
                    '2026-07-10T00:00:00Z',
                    '2026-07-10T00:05:00Z',
                    runner=runner,
                )

    def test_normal_deploy_atomic_switch(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            runner = FakeRunner()
            prior = 'a' * 40
            candidate = 'b' * 40
            write_env(root / lib.PERSISTENT_ENV_NAME)
            seed_release(root, prior, runner)
            candidate_release = lib.release_path(root, candidate)
            candidate_release.mkdir(parents=True)
            (candidate_release / lib.COMPOSE_FILE).write_text('services:\n  bff:\n    image: test\n')
            runner.images[str(candidate_release)] = 'sha256:candidate'
            lib.deploy_candidate(
                root,
                candidate,
                '2026-07-10T00:00:00Z',
                '2026-07-10T00:05:00Z',
                runner=runner,
                readiness_base_url=None,
            )
            self.assertEqual(os.readlink(root / lib.CURRENT_LINK_NAME), f'releases/{candidate}')
            state = json.loads((root / lib.STATE_DIR_NAME / lib.STATE_FILE_NAME).read_text())
            self.assertEqual(state['prior_sha'], prior)
            self.assertEqual(state['candidate_sha'], candidate)

    def test_build_fail_triggers_auto_rollback(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            runner = FakeRunner(fail_actions={'build'})
            prior = 'a' * 40
            candidate = 'b' * 40
            write_env(root / lib.PERSISTENT_ENV_NAME)
            seed_release(root, prior, runner)
            candidate_release = lib.release_path(root, candidate)
            candidate_release.mkdir(parents=True)
            (candidate_release / lib.COMPOSE_FILE).write_text('services:\n  bff:\n    image: test\n')
            with self.assertRaises(subprocess.CalledProcessError):
                lib.deploy_candidate(
                    root,
                    candidate,
                    '2026-07-10T00:00:00Z',
                    '2026-07-10T00:05:00Z',
                    runner=runner,
                )
            self.assertEqual(os.readlink(root / lib.CURRENT_LINK_NAME), f'releases/{prior}')

    def test_compose_up_fail_triggers_auto_rollback(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            runner = FakeRunner(fail_first_actions={'up'})
            prior = 'a' * 40
            candidate = 'b' * 40
            write_env(root / lib.PERSISTENT_ENV_NAME)
            seed_release(root, prior, runner)
            candidate_release = lib.release_path(root, candidate)
            candidate_release.mkdir(parents=True)
            (candidate_release / lib.COMPOSE_FILE).write_text('services:\n  bff:\n    image: test\n')
            runner.images[str(candidate_release)] = 'sha256:candidate'
            with self.assertRaises(subprocess.CalledProcessError):
                lib.deploy_candidate(
                    root,
                    candidate,
                    '2026-07-10T00:00:00Z',
                    '2026-07-10T00:05:00Z',
                    runner=runner,
                )
            self.assertEqual(os.readlink(root / lib.CURRENT_LINK_NAME), f'releases/{prior}')

    def test_readiness_timeout_triggers_auto_rollback(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            runner = FakeRunner()
            prior = 'a' * 40
            candidate = 'b' * 40
            write_env(root / lib.PERSISTENT_ENV_NAME)
            seed_release(root, prior, runner)
            candidate_release = lib.release_path(root, candidate)
            candidate_release.mkdir(parents=True)
            (candidate_release / lib.COMPOSE_FILE).write_text('services:\n  bff:\n    image: test\n')
            runner.images[str(candidate_release)] = 'sha256:candidate'

            clock = {'now': 0.0}

            def now_fn() -> float:
                return clock['now']

            def sleep_fn(seconds: float) -> None:
                clock['now'] += seconds

            with self.assertRaises(TimeoutError):
                lib.deploy_candidate(
                    root,
                    candidate,
                    '2026-07-10T00:00:00Z',
                    '2026-07-10T00:05:00Z',
                    runner=runner,
                    readiness_base_url='http://127.0.0.1:9',
                    sleep_fn=sleep_fn,
                    now_fn=now_fn,
                )
            self.assertEqual(os.readlink(root / lib.CURRENT_LINK_NAME), f'releases/{prior}')

    def test_rollback_restores_prior_without_rebuild(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            runner = FakeRunner()
            prior = 'a' * 40
            candidate = 'b' * 40
            write_env(root / lib.PERSISTENT_ENV_NAME)
            prior_release = seed_release(root, prior, runner)
            candidate_release = lib.release_path(root, candidate)
            candidate_release.mkdir(parents=True)
            (candidate_release / lib.COMPOSE_FILE).write_text('services:\n  bff:\n    image: test\n')
            runner.images[str(candidate_release)] = 'sha256:candidate'
            lib.deploy_candidate(
                root,
                candidate,
                '2026-07-10T00:00:00Z',
                '2026-07-10T00:05:00Z',
                runner=runner,
            )
            runner.build_count = 0
            lib.rollback_to_prior(root, runner=runner)
            self.assertEqual(os.readlink(root / lib.CURRENT_LINK_NAME), f'releases/{prior}')
            self.assertEqual((prior_release / 'DEPLOYED_SHA').read_text().strip(), prior)
            self.assertEqual(runner.build_count, 0)

    def test_rollback_failure_visible(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            with self.assertRaises(RuntimeError):
                lib.rollback_to_prior(root, runner=FakeRunner())

    def test_sensitive_files_mode_0600(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            path = root / lib.STATE_DIR_NAME / lib.STATE_FILE_NAME
            lib.write_private_json(path, {'x': 1})
            mode = path.stat().st_mode & 0o777
            self.assertEqual(mode, 0o600)

    def test_exact_boundary_with_injected_clock(self) -> None:
        start = lib.parse_utc_z('2026-07-10T00:00:00.000Z')
        cutoff = lib.parse_utc_z('2026-07-10T00:10:00.000Z')
        injected = cutoff.timestamp() - 0.001
        self.assertLess(start.timestamp(), injected)
        self.assertLess(injected, cutoff.timestamp())

    def test_transport_rejects_invalid_sha(self) -> None:
        repo = Path(__file__).resolve().parent.parent
        proc = subprocess.run(
            [sys.executable, 'scripts/staging-transport.py', 'deploy', 'not-a-sha', str(repo / 'tmp'), '2026-07-10T00:00:00Z', '2026-07-10T00:05:00Z'],
            cwd=repo,
            capture_output=True,
            text=True,
        )
        self.assertNotEqual(proc.returncode, 0)


if __name__ == '__main__':
    unittest.main()
