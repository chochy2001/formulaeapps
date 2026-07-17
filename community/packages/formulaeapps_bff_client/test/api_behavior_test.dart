import 'dart:convert';
import 'dart:typed_data';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';
import 'package:formulaeapps_bff_client/src/date_serializer.dart';
import 'package:test/test.dart';

class _RecordingAdapter implements HttpClientAdapter {
  _RecordingAdapter(this.responses);

  final Map<String, Object?> responses;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode(responses[options.path]),
      200,
      headers: const {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

FormulaeappsBffClient _clientFor(_RecordingAdapter adapter) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://bff.example.test',
      validateStatus: (_) => true,
    ),
  )..httpClientAdapter = adapter;
  return FormulaeappsBffClient(dio: dio);
}

void _expectRoundTrip<T>(T value, Serializer<T> serializer) {
  final encoded = standardSerializers.serializeWith(serializer, value);
  final decoded = standardSerializers.deserializeWith(serializer, encoded)!;

  expect(decoded, value);
  expect(decoded.hashCode, value.hashCode);
  expect(decoded.toString(), value.toString());
  final dynamic rebuilt = (value as dynamic).rebuild((dynamic builder) {});
  expect(rebuilt, value);
  expect((value as dynamic).toBuilder().build(), value);
}

void main() {
  final accountResponse = {
    'token': 'account.jwt',
    'expires_at': '2030-01-01T00:00:00.000Z',
    'user_id': 'user-42',
  };

  group('generated BFF API operations', () {
    test('serializes requests and parses all exposed endpoint responses',
        () async {
      final adapter = _RecordingAdapter({
        '/health': {
          'status': 'ok',
          'version': '1.2.3',
          'prompts_version': 'prompts-v4',
          'uptime_seconds': 42,
        },
        '/auth/login': accountResponse,
        '/auth/oauth': accountResponse,
        '/auth/register': accountResponse,
        '/auth/token': {
          'token': 'device.jwt',
          'expires_at': '2030-01-01T00:00:00.000Z',
          'refresh_after': '2029-12-31T23:55:00.000Z',
          'prompts_version': 'prompts-v4',
        },
        '/openai/chat': {
          'message': '2x',
          'model_id': 'openai/gpt-4o-mini',
          'usage': {
            'prompt_tokens': 3,
            'completion_tokens': 2,
            'total_tokens': 5,
          },
          'prompts_version': 'prompts-v4',
        },
        '/entitlement': {
          'scope': 'mobile',
          'sources': [
            {
              'payment_source': 'app_store',
              'product_id': 'formulae.monthly',
              'granted_at': '2030-01-01T00:00:00.000Z',
            },
          ],
        },
        '/iap/validate': {
          'valid': true,
          'product_id': 'formulae.monthly',
          'transaction_id': 'txn-7',
          'environment': 'production',
          'expires_at': '2030-02-01T00:00:00.000Z',
        },
      });
      final client = _clientFor(adapter)
        ..setBearerAuth('bearerAuth', 'device.jwt');

      final health = await client.getHealthApi().healthGet();
      final login = await client.getAuthApi().authLoginPost(
            accountLoginRequest: AccountLoginRequest(
              (b) => b
                ..email = 'learner@example.test'
                ..password = 'correct-horse-battery-staple'
                ..platform = AccountLoginRequestPlatformEnum.ios
                ..appVersion = '1.2.3',
            ),
          );
      final oauth = await client.getAuthApi().authOauthPost(
            accountOAuthRequest: AccountOAuthRequest(
              (b) => b
                ..provider = AccountOAuthRequestProviderEnum.apple
                ..idToken = 'apple-id-token'
                ..platform = AccountOAuthRequestPlatformEnum.ios,
            ),
          );
      final register = await client.getAuthApi().authRegisterPost(
            accountRegisterRequest: AccountRegisterRequest(
              (b) => b
                ..email = 'new@example.test'
                ..password = 'correct-horse-battery-staple'
                ..platform = AccountRegisterRequestPlatformEnum.android,
            ),
          );
      final token = await client.getAuthApi().authTokenPost(
            authTokenRequest: AuthTokenRequest(
              (b) => b
                ..clientId = '11111111-2222-4333-8444-555555555555'
                ..clientProof = 'proof'
                ..buildNonce = 'nonce'
                ..platform = AuthTokenRequestPlatformEnum.ios
                ..appVersion = '1.2.3',
            ),
          );
      final chat = await client.getChatApi().openaiChatPost(
            chatRequest: ChatRequest(
              (b) => b
                ..message = 'differentiate x squared'
                ..modelId = 'openai/gpt-4o-mini',
            ),
          );
      final entitlement = await client.getEntitlementApi().entitlementGet();
      final validation = await client.getIapApi().iapValidatePost(
            iapValidateRequest: IapValidateRequest(
              (b) => b
                ..platform = IapValidateRequestPlatformEnum.apple
                ..productId = 'formulae.monthly'
                ..transactionId = 'txn-7'
                ..receiptData = 'base64-receipt'
                ..subscription = true,
            ),
          );

      expect(health.data?.status, HealthStatus.ok);
      expect(login.data?.userId, 'user-42');
      expect(oauth.data?.token, 'account.jwt');
      expect(register.data?.expiresAt.toUtc().year, 2030);
      expect(token.data?.refreshAfter.toUtc().minute, 55);
      expect(chat.data?.usage.totalTokens, 5);
      expect(entitlement.data?.sources.single.paymentSource,
          EntitlementSourcePaymentSourceEnum.appStore);
      expect(validation.data?.environment,
          IapValidateResponseEnvironmentEnum.production);

      final requestsByPath = {
        for (final request in adapter.requests) request.path: request,
      };
      expect(requestsByPath['/health']?.method, 'GET');
      expect(requestsByPath['/auth/login']?.data, {
        'email': 'learner@example.test',
        'password': 'correct-horse-battery-staple',
        'platform': 'ios',
        'app_version': '1.2.3',
      });
      expect(requestsByPath['/auth/oauth']?.data, {
        'provider': 'apple',
        'id_token': 'apple-id-token',
        'platform': 'ios',
      });
      expect(requestsByPath['/auth/register']?.data, {
        'email': 'new@example.test',
        'password': 'correct-horse-battery-staple',
        'platform': 'android',
      });
      expect(requestsByPath['/auth/token']?.data,
          containsPair('client_proof', 'proof'));
      expect(requestsByPath['/openai/chat']?.headers['Authorization'],
          'Bearer device.jwt');
      expect(requestsByPath['/entitlement']?.headers['Authorization'],
          'Bearer device.jwt');
      expect(requestsByPath['/iap/validate']?.headers['Authorization'],
          'Bearer device.jwt');
      expect(requestsByPath['/iap/validate']?.data,
          containsPair('receipt_data', 'base64-receipt'));
    });

    test('round-trips every generated contract model including error envelopes',
        () {
      _expectRoundTrip(
        AccountAuthResponse(
          (b) => b
            ..token = 'account.jwt'
            ..expiresAt = DateTime.utc(2030)
            ..userId = 'user-42',
        ),
        AccountAuthResponse.serializer,
      );
      _expectRoundTrip(
        AccountLoginRequest(
          (b) => b
            ..email = 'learner@example.test'
            ..password = 'password'
            ..platform = AccountLoginRequestPlatformEnum.web,
        ),
        AccountLoginRequest.serializer,
      );
      _expectRoundTrip(
        AccountOAuthRequest(
          (b) => b
            ..provider = AccountOAuthRequestProviderEnum.google
            ..idToken = 'id-token'
            ..appVersion = '1.2.3',
        ),
        AccountOAuthRequest.serializer,
      );
      _expectRoundTrip(
        AccountRegisterRequest(
          (b) => b
            ..email = 'new@example.test'
            ..password = 'password'
            ..appVersion = '1.2.3',
        ),
        AccountRegisterRequest.serializer,
      );
      _expectRoundTrip(
        AuthTokenRequest(
          (b) => b
            ..clientId = '11111111-2222-4333-8444-555555555555'
            ..clientProof = 'proof'
            ..buildNonce = 'nonce'
            ..platform = AuthTokenRequestPlatformEnum.android
            ..appVersion = '1.2.3',
        ),
        AuthTokenRequest.serializer,
      );
      _expectRoundTrip(
        AuthTokenResponse(
          (b) => b
            ..token = 'device.jwt'
            ..expiresAt = DateTime.utc(2030)
            ..refreshAfter = DateTime.utc(2029, 12, 31, 23, 55)
            ..promptsVersion = 'prompts-v4',
        ),
        AuthTokenResponse.serializer,
      );
      _expectRoundTrip(
        ChatRequest(
          (b) => b
            ..message = 'derive x squared'
            ..modelId = 'openai/gpt-4o-mini'
            ..conversationId = 'conversation-1',
        ),
        ChatRequest.serializer,
      );
      _expectRoundTrip(
        ChatResponse(
          (b) => b
            ..message = '2x'
            ..modelId = 'openai/gpt-4o-mini'
            ..usage.replace(
              ChatUsage(
                (b) => b
                  ..promptTokens = 3
                  ..completionTokens = 2
                  ..totalTokens = 5,
              ),
            )
            ..promptsVersion = 'prompts-v4',
        ),
        ChatResponse.serializer,
      );
      _expectRoundTrip(
        EntitlementResponse(
          (b) => b
            ..scope = EntitlementResponseScopeEnum.mobile
            ..sources.add(
              EntitlementSource(
                (b) => b
                  ..paymentSource = EntitlementSourcePaymentSourceEnum.playStore
                  ..productId = 'formulae.monthly'
                  ..grantedAt = DateTime.utc(2030),
              ),
            ),
        ),
        EntitlementResponse.serializer,
      );
      _expectRoundTrip(
        ErrorEnvelope(
          (b) => b.error.replace(
            ErrorEnvelopeError(
              (b) => b
                ..kind = ErrorKind.unauthorized
                ..message = 'Sesión expirada'
                ..code = 'E_AUTH_EXPIRED'
                ..requestId = 'request-7',
            ),
          ),
        ),
        ErrorEnvelope.serializer,
      );
      _expectRoundTrip(
        HealthResponse(
          (b) => b
            ..status = HealthStatus.degraded
            ..version = '1.2.3'
            ..promptsVersion = 'prompts-v4'
            ..uptimeSeconds = 42,
        ),
        HealthResponse.serializer,
      );
      _expectRoundTrip(
        IapValidateRequest(
          (b) => b
            ..platform = IapValidateRequestPlatformEnum.google
            ..productId = 'formulae.monthly'
            ..transactionId = 'txn-7'
            ..receiptData = 'base64-receipt'
            ..subscription = false,
        ),
        IapValidateRequest.serializer,
      );
      _expectRoundTrip(
        IapValidateResponse(
          (b) => b
            ..valid = false
            ..productId = 'formulae.monthly'
            ..transactionId = 'txn-7'
            ..environment = IapValidateResponseEnvironmentEnum.sandbox,
        ),
        IapValidateResponse.serializer,
      );

      final date = Date(2030, 2, 3);
      expect(
        DateSerializer().serialize(standardSerializers, date),
        '2030-02-03',
      );
      expect(
        DateSerializer().deserialize(standardSerializers, '2030-02-03'),
        date,
      );
    });

    test('applies OAuth, basic, and API-key credentials from route metadata',
        () async {
      final adapter = _RecordingAdapter({
        '/oauth': null,
        '/basic': null,
        '/api-key': null,
      });
      final client = _clientFor(adapter)
        ..setOAuthToken('oauth-token', 'oauth-value')
        ..setBasicAuth('basic-auth', 'user', 'password')
        ..setApiKey('client-key', 'key-value');

      await client.dio.get(
        '/oauth',
        options: Options(
          extra: {
            'secure': [
              {'type': 'oauth2', 'name': 'oauth-token'},
            ],
          },
        ),
      );
      await client.dio.get(
        '/basic',
        options: Options(
          extra: {
            'secure': [
              {'type': 'http', 'scheme': 'basic', 'name': 'basic-auth'},
            ],
          },
        ),
      );
      await client.dio.get(
        '/api-key',
        options: Options(
          extra: {
            'secure': [
              {
                'type': 'apiKey',
                'name': 'client-key',
                'keyName': 'X-Client-Key',
                'where': 'header',
              },
            ],
          },
        ),
      );

      final requestsByPath = {
        for (final request in adapter.requests) request.path: request,
      };
      expect(requestsByPath['/oauth']?.headers['Authorization'],
          'Bearer oauth-value');
      expect(requestsByPath['/basic']?.headers['Authorization'],
          'Basic dXNlcjpwYXNzd29yZA==');
      expect(requestsByPath['/api-key']?.headers['X-Client-Key'], 'key-value');
    });

    test('surfaces malformed successful responses as serialization failures',
        () async {
      final adapter = _RecordingAdapter({
        '/health': {'status': 'not-a-health-status'},
      });
      final client = _clientFor(adapter);

      await expectLater(
        client.getHealthApi().healthGet(),
        throwsA(
          isA<DioException>()
              .having((error) => error.type, 'type', DioExceptionType.unknown)
              .having((error) => error.response?.statusCode, 'status', 200),
        ),
      );
    });
  });
}
