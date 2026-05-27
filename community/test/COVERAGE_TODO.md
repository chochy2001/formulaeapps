# FormulaeCommunity test coverage roadmap

Bootstrap landed in issue #17 with five smoke tests and a CI gate. Coverage is
intentionally low today; ratchet the floor as new tests land.

## Measure coverage locally

```sh
cd community
flutter pub get
flutter test --coverage
awk -F: '/^LF:/{lf+=$2} /^LH:/{lh+=$2} END{ printf "%.2f%%\n", (lh*100)/lf }' coverage/lcov.info
```

## Next 10 tests (priority order)

1. `test/chat_model_test.dart` — `ChatModel.fromJson` happy path + missing key.
2. `test/models_model_test.dart` — `ModelsModel.fromJson` and snapshot helpers.
3. `test/task_data_test.dart` — `TaskData` CRUD with mocked SharedPreferences.
4. `test/favorites_notifier_load_test.dart` — `FavoritesNotifier.loadFavorites`.
5. `test/chats_provider_test.dart` — `ChatProvider` listener mutations (no live API).
6. `test/fraccion_repeating_branch_test.dart` — repeating-decimal branch coverage.
7. `test/tasks_list_widget_test.dart` — `TasksList` for 0 / 1 / N tasks.
8. `test/scaffold_screen_widget_test.dart` — shared scaffold wrapper widget.
9. `test/locale_provider_test.dart` — locale switching notifies listeners.
10. `test/favorite_type_name_test.dart` — `TypeNameExtension` edge cases.

## Ratchet plan

| Stage      | Coverage | Notes                              |
|------------|----------|------------------------------------|
| Bootstrap  | ~0.3%    | 5 smoke tests (issue #17)          |
| Foundation | 5%       | Models + notifiers + repositories  |
| Stable     | 30%      | Common widgets and key screens     |
| Mature     | 60%      | Navigation flows                   |
| Target     | 85%      | Golden + integration tests         |
