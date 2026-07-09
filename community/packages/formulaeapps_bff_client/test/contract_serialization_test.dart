import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';
import 'package:test/test.dart';

void main() {
  final jsonSerializers =
      (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

  group('ChatRequest / ChatResponse', () {
    test('serializes chat request with snake_case wire names', () {
      final request = ChatRequest(
        (b) => b
          ..message = 'What is the derivative of x^2?'
          ..modelId = 'openai/gpt-4o-mini'
          ..conversationId = 'conv-1',
      );

      final encoded = jsonSerializers.serializeWith(
        ChatRequest.serializer,
        request,
      );

      expect(
        encoded,
        {
          'message': 'What is the derivative of x^2?',
          'model_id': 'openai/gpt-4o-mini',
          'conversation_id': 'conv-1',
        },
      );
    });

    test('round-trips chat response with usage', () {
      final payload = {
        'message': '2x',
        'model_id': 'openai/gpt-4o-mini',
        'usage': {
          'prompt_tokens': 10,
          'completion_tokens': 3,
          'total_tokens': 13,
        },
        'prompts_version': '1.0.0',
      };

      final decoded = jsonSerializers.deserializeWith(
        ChatResponse.serializer,
        payload,
      )!;

      expect(decoded.message, '2x');
      expect(decoded.modelId, 'openai/gpt-4o-mini');
      expect(decoded.promptsVersion, '1.0.0');
      expect(decoded.usage.promptTokens, 10);
      expect(decoded.usage.completionTokens, 3);
      expect(decoded.usage.totalTokens, 13);

      final reencoded = jsonSerializers.serializeWith(
        ChatResponse.serializer,
        decoded,
      );
      expect(reencoded, payload);
    });
  });

  group('AuthTokenRequest / AuthTokenResponse', () {
    test('serializes auth token request', () {
      final request = AuthTokenRequest(
        (b) => b
          ..clientId = '11111111-2222-4333-8444-555555555555'
          ..clientProof = 'abc123'
          ..buildNonce = 'nonce'
          ..platform = AuthTokenRequestPlatformEnum.ios
          ..appVersion = '2.2.9',
      );

      final encoded = jsonSerializers.serializeWith(
        AuthTokenRequest.serializer,
        request,
      );

      expect(
        encoded,
        {
          'client_id': '11111111-2222-4333-8444-555555555555',
          'client_proof': 'abc123',
          'build_nonce': 'nonce',
          'platform': 'ios',
          'app_version': '2.2.9',
        },
      );
    });

    test('deserializes auth token response', () {
      final decoded = jsonSerializers.deserializeWith(
        AuthTokenResponse.serializer,
        {
          'token': 'jwt.token.value',
          'expires_at': '2030-01-01T00:00:00.000Z',
          'refresh_after': '2029-12-31T23:55:00.000Z',
          'prompts_version': '1.0.0',
        },
      )!;

      expect(decoded.token, 'jwt.token.value');
      expect(decoded.expiresAt.toUtc().toIso8601String(),
          '2030-01-01T00:00:00.000Z');
      expect(decoded.refreshAfter.toUtc().toIso8601String(),
          '2029-12-31T23:55:00.000Z');
      expect(decoded.promptsVersion, '1.0.0');
    });
  });

  group('IapValidateRequest / IapValidateResponse', () {
    test('serializes apple validate request', () {
      final request = IapValidateRequest(
        (b) => b
          ..platform = IapValidateRequestPlatformEnum.apple
          ..productId = 'chat_mensual_2023_01'
          ..transactionId = 'txn-1'
          ..receiptData = 'base64-receipt'
          ..subscription = true,
      );

      final encoded = jsonSerializers.serializeWith(
        IapValidateRequest.serializer,
        request,
      );

      expect(
        encoded,
        {
          'platform': 'apple',
          'product_id': 'chat_mensual_2023_01',
          'transaction_id': 'txn-1',
          'receipt_data': 'base64-receipt',
          'subscription': true,
        },
      );
    });

    test('deserializes validate response', () {
      final decoded = jsonSerializers.deserializeWith(
        IapValidateResponse.serializer,
        {
          'valid': true,
          'product_id': 'chat_mensual_2023_01',
          'transaction_id': 'txn-1',
          'environment': 'production',
          'expires_at': '2030-06-01T00:00:00.000Z',
        },
      )!;

      expect(decoded.valid, isTrue);
      expect(decoded.productId, 'chat_mensual_2023_01');
      expect(decoded.transactionId, 'txn-1');
      expect(decoded.environment, IapValidateResponseEnvironmentEnum.production);
    });
  });
}
