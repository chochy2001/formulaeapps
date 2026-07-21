import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/api_consts.dart';

void main() {
  group('resolveBffBaseUrl', () {
    test('prefers FORMULAE_BFF_BASE_URL when set', () {
      expect(
        resolveBffBaseUrl(
          formulae: 'https://pro.example',
          legacy: 'https://legacy.example',
        ),
        'https://pro.example',
      );
    });

    test('falls back to BFF_BASE_URL when FORMULAE_ is empty', () {
      expect(
        resolveBffBaseUrl(formulae: '', legacy: 'https://legacy.example'),
        'https://legacy.example',
      );
    });

    test('uses production default when both empty', () {
      expect(
        resolveBffBaseUrl(formulae: '', legacy: ''),
        'https://api.formulaeapps.com',
      );
    });
  });

  group('resolveBuildNonce', () {
    test('prefers FORMULAE_BUILD_NONCE when set', () {
      expect(
        resolveBuildNonce(formulae: 'pro-nonce', legacy: 'legacy-nonce'),
        'pro-nonce',
      );
    });

    test('falls back to BUILD_NONCE when FORMULAE_ is empty', () {
      expect(
        resolveBuildNonce(formulae: '', legacy: 'legacy-nonce'),
        'legacy-nonce',
      );
    });
  });

  group('resolveAppVersion', () {
    test('prefers FORMULAE_APP_VERSION when set', () {
      expect(
        resolveAppVersion(formulae: '9.9.9', legacy: '0.0.0-dev'),
        '9.9.9',
      );
    });

    test('falls back to APP_VERSION when FORMULAE_ is empty', () {
      expect(resolveAppVersion(formulae: '', legacy: '2.2.9'), '2.2.9');
    });
  });

  test('compile-time defaults resolve to production BFF host', () {
    expect(bffBaseUrl, 'https://api.formulaeapps.com');
    expect(bffAuthTokenUrl, 'https://api.formulaeapps.com/auth/token');
  });
}
