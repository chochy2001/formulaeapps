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
- The latest measured Pro coverage is **81.60%** (23,125 / 28,330 lines),
  from `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter
  compact` with the three CI Dart defines above. Four behavior tests now cover
  task slide-to-edit, iOS drawer navigation, folder switching/formula-size
  persistence, and disabled empty-folder actions. The edit flow exposed and
  fixed a real dialog lifecycle defect: saving previously attempted to read
  `TaskData` from the dialog route and disposed its text controller before the
  closing frame completed. The 85% target remains **956 lines** away at the
  current denominator; continue with PDF/extraction paths and task reminders.
- The latest increment adds PDF preview/render-size behavior tests and a
  reminder/due-date persistence regression. It fixes reminder state being
  changed in-place without being persisted or notifying the UI, and prevents
  the empty reminder dialog from dereferencing a null selection. Measured
  coverage is **81.70% raw line coverage** (23,134 / 28,331), using
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter
  compact` with `JWT_SHARED_SECRET=test-shared-secret`,
  `FORMULAE_BUILD_NONCE=ci-test-build-nonce`, and
  `FORMULAE_APP_VERSION=0.0.0-ci`; **948 lines** remain to reach 85% at this
  denominator. The full suite passed 151 tests; strict analysis and
  `scripts/verify-parity.sh` passed locally. This is local branch evidence,
  not a staging or production claim.
- The latest coverage increment adds destructive task-delete confirmation,
  empty-reminder dismissal, due-date persistence, and desktop drawer-route
  behavior tests. It also fixes task editing so an already-completed task
  remains completed after its name is changed. Measured raw Pro line coverage
  is **82.09%** (**23,259 / 28,332**), using
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter
  compact` with `JWT_SHARED_SECRET=test-shared-secret`,
  `FORMULAE_BUILD_NONCE=ci-test-build-nonce`, and
  `FORMULAE_APP_VERSION=0.0.0-ci`; **824 lines** remain to reach 85% at this
  denominator. The full suite passed **155 tests**; strict analysis and
  `scripts/verify-parity.sh` passed locally. This is local code-validation
  evidence, not a staging or production claim. Highest-return residual
  hotspots remain PDF generation/preview (`ver_pdf.dart`,
  `favorites_pdf_generator.dart`), chat UI (`chat_screen.dart`), and
  task-list/task-screen flows.
- The latest increment adds behavior coverage for cached subscriptions sending
  chat messages, failed PDF resize recovery, task clear-all confirmation, and
  opening the add-task sheet. It fixes cached valid subscriptions being treated
  as invalid by the send handler and avoids starting a fresh purchase-validation
  future on every chat rebuild. Measured raw Pro line coverage is **82.33%**
  (**23,328 / 28,334**), using
  `FLUTTER_TEST_CONCURRENCY=1 flutter test --no-pub --coverage --reporter
  compact` with `JWT_SHARED_SECRET=test-shared-secret`,
  `FORMULAE_BUILD_NONCE=ci-test-build-nonce`, and
  `FORMULAE_APP_VERSION=0.0.0-ci`; **756 lines** remain to reach 85% at this
  denominator. The full suite passed **160 tests**. This is local
  code-validation evidence, not a staging or production claim. Remaining
  high-return hotspots include PDF generation/preview
  (`favorites_pdf_generator.dart`, `ver_pdf.dart`), chat UI
  (`chat_screen.dart`), and task-list/task-screen flows.
