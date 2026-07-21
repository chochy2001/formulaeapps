import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/core/observability/observability_bootstrap.dart';

void main() {
  group('hasFirebaseCredentials', () {
    test('is false when every dart-define is empty (default CI/dev build)', () {
      expect(
        hasFirebaseCredentials(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
        ),
        isFalse,
      );
    });

    test('is false when only some dart-defines are set', () {
      expect(
        hasFirebaseCredentials(
          apiKey: 'key',
          appId: '',
          messagingSenderId: 'sender',
          projectId: 'project',
        ),
        isFalse,
      );
    });

    test('is true only when all four dart-defines are set', () {
      expect(
        hasFirebaseCredentials(
          apiKey: 'key',
          appId: 'app',
          messagingSenderId: 'sender',
          projectId: 'project',
        ),
        isTrue,
      );
    });
  });

  group('bootstrapCrashlytics', () {
    test(
      'no-ops and returns false when ENABLE_CRASHLYTICS is unset '
      '(default; no google-services.json / GoogleService-Info.plist yet)',
      () async {
        final initialized = await bootstrapCrashlytics();
        expect(initialized, isFalse);
      },
    );
  });

  group('bootstrapPostHog', () {
    test(
      'no-ops when ENABLE_POSTHOG is unset (default; no key configured)',
      () async {
        await bootstrapPostHog();
        // No exception thrown, no PostHog SDK call attempted without a key.
      },
    );
  });

  group('bootstrapObservability', () {
    test('completes without throwing when both flags default to off', () async {
      await expectLater(bootstrapObservability(), completes);
    });
  });

  test('postHogAppProperty is the fleet-lock Formulae Community tag', () {
    expect(postHogAppProperty, 'formulae-community');
  });
}
