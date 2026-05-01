# FormulaePro Agent Guide

This repository is a Flutter application built around Provider-based state
management and a relatively old Dart SDK constraint.

## Commands

- Install dependencies: `flutter pub get`
- Format touched code: `dart format lib`
- Analyze: `flutter analyze`
- Run tests: `flutter test` (only if the repo contains or adds runnable tests)
- Build web: `flutter build web`
- Build Android: `flutter build apk`

## Stack notes

- State management is based on `provider`, not Riverpod or BLoC.
- The SDK constraint is `>=2.12.0 <3.0.0`; keep dependency upgrades conservative.
- The app includes `in_app_purchase`, camera, local notifications, and other
  platform-sensitive integrations.

## Rules

- Prefer existing Provider patterns and folder structure over introducing new
  state libraries.
- Treat store credentials, purchase flows, and notification setup as sensitive.
- If tests are missing or incomplete, report that clearly instead of pretending
  they ran.
