import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';

import 'package:formulae/chat_gpt/api_service.dart';
import 'package:formulae/chat_gpt/auth_service.dart';

import 'auth_service_test.dart' show testJwt;

class _MockChatAdapter implements HttpClientAdapter {
  _MockChatAdapter({
    required this.responseBody,
    this.rotatedToken,
  });

  final Map<String, dynamic> responseBody;
  final String? rotatedToken;

  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    return ResponseBody.fromString(
      jsonEncode(responseBody),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        if (rotatedToken != null) 'x-auth-refresh': [rotatedToken!],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  setUp(() {
    AuthService.invalidate();
  });

  group('ApiService.getModels', () {
    test('returns hardcoded OpenRouter model stub', () async {
      final models = await ApiService.getModels();

      expect(models, hasLength(1));
      expect(models.first.id, 'openai/gpt-4o-mini');
      expect(models.first.root, 'formulae-bff');
    });
  });

  group('ApiService.sendMessage', () {
    test('maps BFF ChatResponse to assistant ChatModel', () async {
      final exp = DateTime.now().toUtc().add(const Duration(hours: 2));
      AuthService.adoptRotatedToken(
        testJwt(expUnix: exp.millisecondsSinceEpoch ~/ 1000),
      );

      final adapter = _MockChatAdapter(
        responseBody: {
          'message': 'The derivative of x^2 is 2x.',
          'model_id': 'openai/gpt-4o-mini',
          'usage': {
            'prompt_tokens': 10,
            'completion_tokens': 12,
            'total_tokens': 22,
          },
          'prompts_version': 'test-v1',
        },
      );

      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://example.test',
          validateStatus: (_) => true,
        ),
      )..httpClientAdapter = adapter;

      final replies = await ApiService.sendMessage(
        message: 'What is the derivative of x^2?',
        modelId: 'openai/gpt-4o-mini',
        dioForTest: dio,
      );

      expect(replies, hasLength(1));
      expect(replies.first.msg, 'The derivative of x^2 is 2x.');
      expect(replies.first.chatIndex, 1);
      expect(adapter.lastRequest?.path, '/openai/chat');
      expect(
        adapter.lastRequest?.headers['Authorization'],
        startsWith('Bearer '),
      );
    });

    test('adopts X-Auth-Refresh rotated bearer token', () async {
      final seedExp = DateTime.now().toUtc().add(const Duration(minutes: 10));
      AuthService.adoptRotatedToken(
        testJwt(expUnix: seedExp.millisecondsSinceEpoch ~/ 1000),
      );

      final rotatedExp = DateTime.now().toUtc().add(const Duration(hours: 3));
      final rotated = testJwt(
        expUnix: rotatedExp.millisecondsSinceEpoch ~/ 1000,
      );

      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://example.test',
          validateStatus: (_) => true,
        ),
      )..httpClientAdapter = _MockChatAdapter(
          rotatedToken: rotated,
          responseBody: {
            'message': 'ok',
            'model_id': 'openai/gpt-4o-mini',
            'usage': {
              'prompt_tokens': 1,
              'completion_tokens': 1,
              'total_tokens': 2,
            },
            'prompts_version': 'test-v1',
          },
        );

      await ApiService.sendMessage(
        message: 'ping',
        modelId: 'openai/gpt-4o-mini',
        dioForTest: dio,
      );

      var httpCalled = false;
      final token = await AuthService.getToken(
        client: MockClient((_) async {
          httpCalled = true;
          throw StateError('should not refresh');
        }),
      );

      expect(token, rotated);
      expect(httpCalled, isFalse);
    });
  });
}
