# Formulae Session Status

## 2026-07-17

- Pro line coverage: **81.44%** (23,072 / 28,330 lines), measured with:
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter compact`
  plus `--dart-define=JWT_SHARED_SECRET=test-shared-secret`,
  `--dart-define=FORMULAE_BUILD_NONCE=ci-test-build-nonce`, and
  `--dart-define=FORMULAE_APP_VERSION=0.0.0-ci`.
- PR #96 merged the create-folder dialog controller lifetime fix and five PDF,
  export, navigation, and favorites behavior tests.
- PR #97 merged behavior coverage for multi-page PDF previews, destructive task
  and favorites confirmations, and the no-destination move path.
- This increment adds state-transition tests for task completion/details,
  destructive favorite and folder actions, folder moves, PDF retry behavior,
  and drawer navigation. The 85% fleet target remains unmet; the remaining
  listed hotspots are `tasks_list.dart` (61/193), `ver_pdf.dart` (128/262),
  `drawer_personalizado.dart` (123/231), and `favorites_screen.dart` (247/320).
- The latest increment adds behavior tests for skipping optional task dates,
  locale-specific video URL resolution, and compact navigation between task and
  favorites tabs. It raised raw line coverage by 76 lines (0.27 percentage
  points). The 85% target remains 1,009 covered lines away at the current
  denominator; the highest-return remaining user-flow hotspots are
  `tasks_list.dart`, `drawer_personalizado.dart`, `ver_pdf.dart`, and
  `tasks_screen.dart`.
