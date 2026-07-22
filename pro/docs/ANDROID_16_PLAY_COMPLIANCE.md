# Formulae Pro — Android 16 / Play Console compliance

Evidence-backed notes for the Google Play deadlines around **2026-08-31**.
Source of truth for the Play-bound Pro Android app is this monorepo path:
`pro/` (`applicationId` `com.capdesis.formulae_pro.formulae_calculo_pro`).
The archived GitHub repo `CAPDESIS/FormulaePro` still shows older SDK pins and
must not be used for store uploads.

## Requirements (confirmed)

| Gate | Requirement | Pro status |
| --- | --- | --- |
| Target API | New apps/updates must target **API 36** (Android 16) by 2026-08-31 | `compileSdkVersion 36` / `targetSdkVersion 36` in `android/app/build.gradle` |
| Play Billing | Billing Library **7** rejected for new uploads after 2026-08-31; need **8+** | `in_app_purchase` ^3.3.0 → `in_app_purchase_android` ≥0.5 → `com.android.billingclient:billing:8.0.0`, with Gradle floor `<8` → `8.0.0` |

## Android 16 behavior changes handled here

### Edge-to-edge (mandatory; opt-out removed)

- On **targetSdk 36**, `R.attr#windowOptOutEdgeToEdgeEnforcement` is ignored on
  Android 16 devices. Formulae Pro does **not** set that opt-out in themes.
- `lib/main.dart` calls `SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge)`.
- Content screens wrap bodies in Flutter `SafeArea` so controls stay clear of
  status/nav bars and display cutouts.
- Activity already uses `android:windowSoftInputMode="adjustResize"` for IME
  inset handling with edge-to-edge.

### Permissions

- `POST_NOTIFICATIONS` is declared in the main manifest (Android 13+ runtime
  permission; also merged from `flutter_local_notifications`).
- `com.android.vending.BILLING` remains declared for Play Billing.
- Camera / media access continues to come from plugin manifests
  (`camera`, `image_picker`); no READ_EXTERNAL_STORAGE reintroduction.

### Not changed / residual risk

- **Store upload still required**: Console can keep showing target API **35**
  until a signed AAB built from this tree is published. `STORE_AUTODEPLOY` is
  currently disarmed — merging this branch alone does not update Play.
- **Billing Library 9**: Flutter `in_app_purchase_android` 0.5.x is built against
  Billing **8.0.0**. We floor at 8+ but do **not** force 9.x until the Flutter
  plugin documents support (API removals/renames in PBL 9).
- Runtime notification permission prompts remain the responsibility of the
  notifications flow; declaring the permission does not auto-grant on API 33+.
- Full UI QA on an API 36 emulator/device after the next store build is still
  recommended (cutouts, gesture nav, keyboard over chat/IAP sheets).

## Verification

```bash
bash scripts/verify-pro-play-compliance.sh
```

Optional light analyze (from `pro/`):

```bash
flutter analyze --no-pub --fatal-infos --fatal-warnings lib/main.dart
flutter test test/in_app_purchase_manager_test.dart
```
