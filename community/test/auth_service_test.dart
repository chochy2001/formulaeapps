import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:formulae/chat_gpt/api_consts.dart';
import 'package:formulae/chat_gpt/auth_service.dart';

/// Minimal unsigned JWT for exercising [AuthService.adoptRotatedToken] /
/// cache hits without calling the live BFF.
String testJwt({required int expUnix}) {
  final header = base64Url
      .encode(utf8.encode('{"alg":"HS256","typ":"JWT"}'))
      .replaceAll('=', '');
  final payload =
      base64Url.encode(utf8.encode('{"exp":$expUnix}')).replaceAll('=', '');
  return '$header.$payload.test-signature';
}

void main() {
  setUp(() {
    AuthService.invalidate();
    SharedPreferences.setMockInitialValues({});
  });

  group('AuthService token cache', () {
    test('adoptRotatedToken seeds cache from JWT exp claim', () async {
      final exp = DateTime.now().toUtc().add(const Duration(hours: 2));
      final jwt = testJwt(expUnix: exp.millisecondsSinceEpoch ~/ 1000);

      AuthService.adoptRotatedToken(jwt);

      var httpCalled = false;
      final client = MockClient((_) async {
        httpCalled = true;
        return http.Response('unexpected', 500);
      });

      final token = await AuthService.getToken(client: client);
      expect(token, jwt);
      expect(httpCalled, isFalse);
    });

    test('invalidate clears cache so refresh is attempted', () async {
      final exp = DateTime.now().toUtc().add(const Duration(hours: 2));
      AuthService.adoptRotatedToken(
        testJwt(expUnix: exp.millisecondsSinceEpoch ~/ 1000),
      );
      AuthService.invalidate();

      if (jwtSharedSecret.isEmpty) {
        await expectLater(
          AuthService.getToken(),
          throwsA(
            isA<StateError>().having(
              (e) => e.message,
              'message',
              contains('JWT_SHARED_SECRET'),
            ),
          ),
        );
        return;
      }

      var requestCount = 0;
      final client = MockClient((request) async {
        requestCount++;
        return http.Response('auth failed', 500);
      });

      await expectLater(
        AuthService.getToken(client: client),
        throwsA(isA<StateError>()),
      );
      expect(requestCount, 1);
    });

    test('ignores malformed rotated tokens', () async {
      AuthService.adoptRotatedToken('not-a-jwt');

      if (jwtSharedSecret.isEmpty) {
        await expectLater(
          AuthService.getToken(),
          throwsA(isA<StateError>()),
        );
        return;
      }

      await expectLater(
        AuthService.getToken(
          client: MockClient((_) async => http.Response('nope', 500)),
        ),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('AuthService BFF refresh', () {
    test('getToken posts client proof to /auth/token when cache is cold',
        () async {
      if (jwtSharedSecret.isEmpty) {
        // CI/local: flutter test --dart-define=JWT_SHARED_SECRET=unit-test-secret
        return;
      }

      final expiresAt =
          DateTime.now().toUtc().add(const Duration(hours: 1)).toIso8601String();
      final issuedToken = testJwt(
        expUnix: DateTime.now()
                .toUtc()
                .add(const Duration(hours: 1))
                .millisecondsSinceEpoch ~/
            1000,
      );

      http.Request? captured;
      final client = MockClient((request) async {
        captured = request;
        return http.Response(
          jsonEncode({'token': issuedToken, 'expires_at': expiresAt}),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final token = await AuthService.getToken(client: client);

      expect(token, issuedToken);
      expect(captured, isNotNull);
      expect(captured!.method, 'POST');
      expect(captured!.url.path, endsWith('/auth/token'));

      final body = jsonDecode(captured!.body) as Map<String, dynamic>;
      expect(body['client_id'], isNotEmpty);
      expect(body['client_proof'], isNotEmpty);
      expect(body['build_nonce'], buildNonce);
      expect(body['platform'], isNotEmpty);
      expect(body['app_version'], appVersion);
    });
  });
}
