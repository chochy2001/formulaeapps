import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/api_service.dart';

void main() {
  test(
    'sendMessage returns assistant output and adopts rotated tokens',
    () async {
      late RequestOptions capturedOptions;
      String? rotatedToken;

      final dio = Dio(BaseOptions(baseUrl: bffBaseUrl));
      dio.httpClientAdapter = _FakeAdapter((
        options,
        requestStream,
        cancelFuture,
      ) async {
        capturedOptions = options;
        return ResponseBody.fromString(
          jsonEncode({
            'message': 'Respuesta del BFF',
            'model_id': 'openai/gpt-4o-mini',
            'usage': {
              'prompt_tokens': 10,
              'completion_tokens': 5,
              'total_tokens': 15,
            },
            'prompts_version': '1.0.0',
          }),
          200,
          headers: const {
            Headers.contentTypeHeader: ['application/json'],
            'x-auth-refresh': ['rotated-token'],
          },
        );
      });

      final response = await ApiService.sendMessage(
        message: 'Hola',
        modelId: 'openai/gpt-4o-mini',
        dioOverride: dio,
        tokenProvider: () async => 'session-token',
        rotatedTokenHandler: (token) => rotatedToken = token,
      );

      expect(response, hasLength(1));
      expect(response.single.msg, 'Respuesta del BFF');
      expect(response.single.chatIndex, 1);
      expect(rotatedToken, 'rotated-token');
      expect(capturedOptions.path, '/openai/chat');
      expect(capturedOptions.headers['Authorization'], 'Bearer session-token');
      expect(capturedOptions.data, isA<Map<String, dynamic>>());
      expect(capturedOptions.data['message'], 'Hola');
      expect(capturedOptions.data['model_id'], 'openai/gpt-4o-mini');
    },
  );

  test('sendMessage rejects empty assistant payloads', () async {
    final dio = Dio(BaseOptions(baseUrl: bffBaseUrl));
    dio.httpClientAdapter = _FakeAdapter((
      options,
      requestStream,
      cancelFuture,
    ) async {
      return ResponseBody.fromString(
        jsonEncode({
          'message': '',
          'model_id': 'openai/gpt-4o-mini',
          'usage': {
            'prompt_tokens': 1,
            'completion_tokens': 1,
            'total_tokens': 2,
          },
          'prompts_version': '1.0.0',
        }),
        200,
        headers: const {
          Headers.contentTypeHeader: ['application/json'],
        },
      );
    });

    expect(
      () => ApiService.sendMessage(
        message: 'Hola',
        modelId: 'openai/gpt-4o-mini',
        dioOverride: dio,
        tokenProvider: () async => 'session-token',
      ),
      throwsA(
        isA<HttpException>().having(
          (error) => error.message,
          'message',
          contains('BFF returned no message content'),
        ),
      ),
    );
  });

  test('sendMessage surfaces redacted BFF errors', () async {
    final dio = Dio(BaseOptions(baseUrl: bffBaseUrl));
    dio.httpClientAdapter = _FakeAdapter((
      options,
      requestStream,
      cancelFuture,
    ) async {
      return ResponseBody.fromString(
        jsonEncode({
          'error': {
            'kind': 'validation_error',
            'message': 'model_id is not allowed',
            'request_id': 'req_123',
          },
        }),
        422,
        headers: const {
          Headers.contentTypeHeader: ['application/json'],
        },
      );
    });

    expect(
      () => ApiService.sendMessage(
        message: 'Hola',
        modelId: 'legacy-model',
        dioOverride: dio,
        tokenProvider: () async => 'session-token',
      ),
      throwsA(
        isA<HttpException>().having(
          (error) => error.message,
          'message',
          contains('model_id is not allowed'),
        ),
      ),
    );
  });
}

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this._handler);

  final Future<ResponseBody> Function(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  )
  _handler;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options, requestStream, cancelFuture);
  }
}
