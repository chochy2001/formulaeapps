# Formulae Session Status

## 2026-07-17

- Pro line coverage: **80.65%** (22,847 / 28,330 lines), measured with:
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter compact`
  and the documented non-secret Dart defines.
- PR #96 merged the create-folder dialog controller lifetime fix and five PDF,
  export, navigation, and favorites behavior tests.
- PR #97 merged behavior coverage for multi-page PDF previews, destructive task
  and favorites confirmations, and the no-destination move path.
- The 85% fleet target remains unmet; the next largest behavior hotspots are
  `tasks_list.dart`, `ver_pdf.dart`, `drawer_personalizado.dart`, and
  `favorites_screen.dart`.
