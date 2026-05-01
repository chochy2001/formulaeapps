---
name: formulae-pro
description: Guidelines for Formulae Pro math formulas reference app (Flutter + Provider + ChatGPT + LaTeX)
---

# Formulae Pro Development Guidelines

Cross-platform math formulas reference app. Spanish-first with English support.

## Tech Stack
- **Framework**: Flutter (Dart SDK >=2.12.0 <3.0.0, null-safe)
- **State Management**: Provider + ChangeNotifier (5 providers at root)
- **Math Rendering**: flutter_math_fork (LaTeX)
- **i18n**: Flutter l10n with ARB files (Spanish template + English)
- **AI**: ChatGPT integration (lib/chat_gpt/) with in-app purchases
- **Platforms**: iOS, Android, Web, Windows, macOS, Linux

## Commands
- Dependencies: `flutter pub get`
- Lint: `flutter analyze --no-pub`
- Format: `dart format lib`
- Test: `flutter test`
- Build Windows: `flutter build windows` (MSIX packaging for Windows Store)

## Structure
- `lib/menus/`: 36 files, one per math subject menu
- `lib/secciones_app/`: 15 math subject directories (algebra, calculo, geometria, etc.)
- `lib/chat_gpt/`: ChatGPT API service, providers, UI, in-app purchase manager
- `lib/widgets_personalizados/`: Custom reusable widgets
- `lib/constantes/`: Colors, URLs, image paths, routes, video maps

## Conventions
- State management: Provider + ChangeNotifier ONLY (not Riverpod or BLoC).
- Math formulas rendered with flutter_math_fork LaTeX syntax.
- No `print()`. Use `debugPrint()`.
- Spanish-first: Template locale is app_es.arb.
- Publisher: CAPDESIS (Windows Store via MSIX).
- All user-facing strings must use i18n (intl package).
