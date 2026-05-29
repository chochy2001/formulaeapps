# iOS 26.5 device SDK blocker (Community release builds)

**Status:** Environment blocker — not a Flutter/code defect.  
**Scope:** `flutter build ios --release` / device-targeted iOS archives for Community.  
**Do not fix in-repo:** requires a manual Xcode UI download on the build Mac.

## Symptom

```
error: iOS 26.5 is not installed. Please download and install the platform from Xcode > Settings > Components.
```

Xcode 26.5 IDE may be present while the **iOS 26.5 device support package** (distinct from simulator runtime / SDK headers) is missing.

## What still works

| Gate | Status |
|------|--------|
| `flutter analyze` | Passes (Community) |
| `flutter test` | Passes (unit/widget tests under `test/`) |
| `flutter build apk --release` | Passes |
| `flutter build ipa --release --no-codesign` | May work via archive path (see Pro T086 notes) |
| Direct `flutter build ios --release --no-codesign` | **Blocked** until device SDK installed |

## Unblock (operator, ~30 s)

1. Open **Xcode → Settings → Platforms** (or **Components** on older Xcode).
2. Download **iOS 26.5** device support.
3. Re-run: `cd community && flutter build ios --release --no-codesign`

## Canonical audit evidence

- `specs/002-formulae-fe-be-sync/audit/us2-community-builds-2026-05-19.md`
- `specs/002-formulae-fe-be-sync/tasks.md` — T097 partial (Android pass, iOS blocked)
