# Formulae Session Status

## 2026-07-17

- Pro line coverage: **81.17%** (22,996 / 28,330 lines), measured with:
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter compact`
  plus `JWT_SHARED_SECRET=test-shared-secret`,
  `FORMULAE_BUILD_NONCE=ci-test-build-nonce`, and
  `FORMULAE_APP_VERSION=0.0.0-ci`.
- PR #96 merged the create-folder dialog controller lifetime fix and five PDF,
  export, navigation, and favorites behavior tests.
- PR #97 merged behavior coverage for multi-page PDF previews, destructive task
  and favorites confirmations, and the no-destination move path.
- This increment adds state-transition tests for task completion/details,
  destructive favorite and folder actions, folder moves, PDF retry behavior,
  and drawer navigation. The 85% fleet target remains unmet; the remaining
  listed hotspots are `tasks_list.dart` (61/193), `ver_pdf.dart` (128/262),
  `drawer_personalizado.dart` (123/231), and `favorites_screen.dart` (247/320).
