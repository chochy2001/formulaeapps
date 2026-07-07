import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/api_consts.dart';
import 'package:formulae/chat_gpt/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AuthService.invalidate();
  });

  tearDown(AuthService.invalidate);

  test('mints a token, persists client id, and reuses the cached token',
      () async {
    var requestCount = 0;
    late Map<String, dynamic> requestBody;

    final client = MockClient((request) async {
      requestCount++;
      requestBody = jsonDecode(request.body) as Map<String, dynamic>;

      return http.Response(
        jsonEncode({
          'token': 'minted-token',
          'expires_at': DateTime.now()
              .toUtc()
              .add(const Duration(hours: 1))
              .toIso8601String(),
        }),
        200,
        headers: const {'content-type': 'application/json'},
      );
    });

    final first = await AuthService.getToken(client: client);
    final second = await AuthService.getToken(client: client);
    final prefs = await SharedPreferences.getInstance();
    final storedClientId = prefs.getString('formulae_bff_client_id');

    expect(first, 'minted-token');
    expect(second, 'minted-token');
    expect(requestCount, 1);
    expect(storedClientId, isNotNull);
    expect(
      storedClientId,
      matches(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        ),
      ),
    );
    expect(requestBody['client_id'], storedClientId);
    expect(
      requestBody['client_proof'],
      Hmac(sha256, utf8.encode(jwtSharedSecret))
          .convert(utf8.encode('$storedClientId$buildNonce'))
          .toString(),
    );
    expect(requestBody['build_nonce'], buildNonce);
    expect(requestBody['app_version'], appVersion);
  });

  test('coalesces concurrent refreshes into a single auth request', () async {
    final responseCompleter = Completer<http.Response>();
    var requestCount = 0;

    final client = MockClient((request) {
      requestCount++;
      return responseCompleter.future;
    });

    final firstFuture = AuthService.getToken(client: client);
    final secondFuture = AuthService.getToken(client: client);

    responseCompleter.complete(
      http.Response(
        jsonEncode({
          'token': 'shared-token',
          'expires_at': DateTime.now()
              .toUtc()
              .add(const Duration(hours: 1))
              .toIso8601String(),
        }),
        200,
        headers: const {'content-type': 'application/json'},
      ),
    );

    expect(await firstFuture, 'shared-token');
    expect(await secondFuture, 'shared-token');
    expect(requestCount, 1);
  });

  test('adopts valid rotated tokens and ignores malformed ones', () async {
    final validRotatedToken = _jwtWithExp(
      DateTime.now().toUtc().add(const Duration(hours: 1)),
    );

    AuthService.adoptRotatedToken(validRotatedToken);

    final cached = await AuthService.getToken(
      client: MockClient((request) async {
        fail('cached rotated token should avoid a network refresh');
      }),
    );

    expect(cached, validRotatedToken);

    AuthService.invalidate();
    AuthService.adoptRotatedToken('not-a-jwt');

    var requestCount = 0;
    final refreshed = await AuthService.getToken(
      client: MockClient((request) async {
        requestCount++;
        return http.Response(
          jsonEncode({
            'token': 'fresh-token',
            'expires_at': DateTime.now()
                .toUtc()
                .add(const Duration(hours: 1))
                .toIso8601String(),
          }),
          200,
          headers: const {'content-type': 'application/json'},
        );
      }),
    );

    expect(refreshed, 'fresh-token');
    expect(requestCount, 1);
  });

  test('surfaces truncated auth failures from the BFF', () async {
    final longBody = 'x' * 250;

    expect(
      () => AuthService.getToken(
        client: MockClient((request) async {
          return http.Response(longBody, 500);
        }),
      ),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          contains('${'x' * 197}...'),
        ),
      ),
    );
  });
}

String _jwtWithExp(DateTime expiresAt) {
  final header = base64Url.encode(utf8.encode('{"alg":"none","typ":"JWT"}'));
  final payload = base64Url.encode(
    utf8.encode(
      jsonEncode({
        'exp': expiresAt.millisecondsSinceEpoch ~/ 1000,
      }),
    ),
  );
  return '$header.$payload.signature';
}
