import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';

void main() {
  group('subscriptionCancellationSupportUrl', () {
    test('keeps the localized Google Play support flow on Android', () {
      expect(
        subscriptionCancellationSupportUrl(
          const Locale('es'),
          targetPlatform: TargetPlatform.android,
          isWeb: false,
        ),
        'https://support.google.com/googleplay/answer/7018481?hl=ES',
      );
      expect(
        subscriptionCancellationSupportUrl(
          const Locale('en'),
          targetPlatform: TargetPlatform.android,
          isWeb: false,
        ),
        'https://support.google.com/googleplay/answer/7018481?hl=EN',
      );
    });

    test('keeps the localized Apple support flow on iOS and macOS', () {
      expect(
        subscriptionCancellationSupportUrl(
          const Locale('es'),
          targetPlatform: TargetPlatform.iOS,
          isWeb: false,
        ),
        'https://support.apple.com/es-lamr/HT202039',
      );
      expect(
        subscriptionCancellationSupportUrl(
          const Locale('en'),
          targetPlatform: TargetPlatform.macOS,
          isWeb: false,
        ),
        'https://support.apple.com/en-us/HT202039',
      );
    });

    test('uses Formulae localized support on web, Windows, and Linux', () {
      for (final targetPlatform in [
        TargetPlatform.windows,
        TargetPlatform.linux,
      ]) {
        expect(
          subscriptionCancellationSupportUrl(
            const Locale('es'),
            targetPlatform: targetPlatform,
            isWeb: false,
          ),
          'https://formulaeapps.com/soporte/',
        );
      }

      expect(
        subscriptionCancellationSupportUrl(
          const Locale('en'),
          targetPlatform: TargetPlatform.android,
          isWeb: true,
        ),
        'https://formulaeapps.com/en/support/',
      );
    });
  });
}
