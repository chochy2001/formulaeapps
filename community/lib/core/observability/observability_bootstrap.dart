import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

/// Fleet provider lock (2026-07-13, `FLEET_PROVIDER_UNIFICATION_2026-07-13.md`):
/// Firebase Crashlytics is the primary Flutter/mobile crash standard; PostHog
/// is the single shared analytics project, tagged per app via the `app`
/// super property. Both are **off by default** and only activate when the
/// matching `--dart-define` values are supplied at build time, so this file
/// introduces zero behavior change until Formulae Community has Firebase +
/// PostHog credentials wired in CI. No key is hardcoded here.
///
/// Crashlytics is initialized with explicit [FirebaseOptions] built from
/// dart-defines instead of the native `google-services.json` /
/// `GoogleService-Info.plist` path, so no native config files or Gradle
/// plugin changes are required to wire this up later.
///
/// Pattern mirrors CapGym#79 / Formulae Pro (`observability_bootstrap.dart`).
const String _kFirebaseApiKey = String.fromEnvironment('FIREBASE_API_KEY');
const String _kFirebaseAppId = String.fromEnvironment('FIREBASE_APP_ID');
const String _kFirebaseMessagingSenderId = String.fromEnvironment(
  'FIREBASE_MESSAGING_SENDER_ID',
);
const String _kFirebaseProjectId = String.fromEnvironment(
  'FIREBASE_PROJECT_ID',
);

const bool _kEnableCrashlytics = bool.fromEnvironment('ENABLE_CRASHLYTICS');
const bool _kEnablePostHog = bool.fromEnvironment('ENABLE_POSTHOG');
const String _kPostHogApiKey = String.fromEnvironment('POSTHOG_API_KEY');
const String _kPostHogHost = String.fromEnvironment(
  'POSTHOG_HOST',
  defaultValue: 'https://us.i.posthog.com',
);

/// PostHog fleet-lock super property: distinguishes Formulae Community events
/// from other apps sharing the single PostHog project. Not a secret.
@visibleForTesting
const String postHogAppProperty = 'formulae-community';

@visibleForTesting
bool hasFirebaseCredentials({
  String apiKey = _kFirebaseApiKey,
  String appId = _kFirebaseAppId,
  String messagingSenderId = _kFirebaseMessagingSenderId,
  String projectId = _kFirebaseProjectId,
}) =>
    apiKey.isNotEmpty &&
    appId.isNotEmpty &&
    messagingSenderId.isNotEmpty &&
    projectId.isNotEmpty;

/// Initializes Crashlytics + PostHog when explicitly enabled via
/// `--dart-define`. Safe no-op by default: existing builds are unaffected
/// until `ENABLE_CRASHLYTICS` / `ENABLE_POSTHOG` (+ their credentials) are
/// set.
Future<void> bootstrapObservability() async {
  await bootstrapCrashlytics();
  await bootstrapPostHog();
}

/// Returns `true` when Crashlytics was actually initialized (so callers can
/// decide whether to keep Flutter's default error presentation).
Future<bool> bootstrapCrashlytics() async {
  if (!_kEnableCrashlytics) return false;
  if (kIsWeb) {
    // Crashlytics has no web SDK; skip rather than fail at runtime.
    debugPrint(
      '[Observability] Crashlytics is not supported on web; skipping.',
    );
    return false;
  }
  if (!hasFirebaseCredentials()) {
    debugPrint(
      '[Observability] ENABLE_CRASHLYTICS=true but one or more FIREBASE_* '
      'dart-defines are missing; skipping Crashlytics init.',
    );
    return false;
  }
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: _kFirebaseApiKey,
        appId: _kFirebaseAppId,
        messagingSenderId: _kFirebaseMessagingSenderId,
        projectId: _kFirebaseProjectId,
      ),
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    return true;
  } catch (e) {
    debugPrint('[Observability] Crashlytics init failed: $e');
    return false;
  }
}

Future<void> bootstrapPostHog() async {
  if (!_kEnablePostHog) return;
  if (_kPostHogApiKey.isEmpty) {
    debugPrint(
      '[Observability] ENABLE_POSTHOG=true but POSTHOG_API_KEY is missing; '
      'skipping PostHog init.',
    );
    return;
  }
  try {
    final config = PostHogConfig(_kPostHogApiKey)
      ..host = _kPostHogHost
      ..captureApplicationLifecycleEvents = true
      ..debug = kDebugMode;
    await Posthog().setup(config);
    await Posthog().register('app', postHogAppProperty);
  } catch (e) {
    debugPrint('[Observability] PostHog init failed: $e');
  }
}
