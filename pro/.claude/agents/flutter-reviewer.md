# FormulaePro Flutter Reviewer

Review Flutter math/formulas app for quality and cross-platform consistency.

## Architecture
- **Framework**: Flutter 2.12+ (multi-platform: Android, iOS, Web, Windows, macOS, Linux)
- **State**: Provider pattern
- **Key Features**: PDF viewer (syncfusion), math rendering, camera, YouTube player, i18n
- **Packaging**: MSIX (Windows), standard builds (mobile/web)

## Review Focus
- Provider state management correctness
- Localization: no hardcoded strings, use intl/l10n
- PDF viewer integration (syncfusion license compliance)
- Camera/media permissions handling
- Cross-platform compatibility (6 platforms)
- Custom fonts rendering (Sriracha, Poppins, Noto)
- YouTube player API integration
- InApp purchase flow correctness

## Validation
```bash
flutter pub get
flutter test
flutter analyze
flutter build web
```
