import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/api_service.dart';

/// Recreated from closed draft #35: DioException / error-envelope edge cases
/// that main's `api_service_test.dart` does not cover (401, 429 top-level
/// message, plain-string bodies, truncation, no-response, tokenProvider fail).
void main() {
  group('ApiService.sendMessage — edge cases', () {
    test('handles 401 with error envelope', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
      dio.httpClientAdapter = _FakeAdapter((options, _, __) async {
        return ResponseBody.fromString(
          jsonEncode({
            'error': {
              'kind': 'auth_error',
              'message': 'token expired',
              'request_id': 'req_456',
            },
          }),
          401,
          headers: const {
            Headers.contentTypeHeader: ['application/json'],
          },
        );
      });

      expect(
        () => ApiService.sendMessage(
          message: 'test',
          modelId: 'openai/gpt-4o-mini',
          dioOverride: dio,
          tokenProvider: () async => 'expired-token',
        ),
        throwsA(
          isA<HttpException>().having(
            (e) => e.message,
            'message',
            contains('token expired'),
          ),
        ),
      );
    });

    test('handles top-level message error', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
      dio.httpClientAdapter = _FakeAdapter((options, _, __) async {
        return ResponseBody.fromString(
          jsonEncode({'message': 'rate limit exceeded'}),
          429,
          headers: const {
            Headers.contentTypeHeader: ['application/json'],
          },
        );
      });

      expect(
        () => ApiService.sendMessage(
          message: 'test',
          modelId: 'openai/gpt-4o-mini',
          dioOverride: dio,
          tokenProvider: () async => 'token',
        ),
        throwsA(
          isA<HttpException>().having(
            (e) => e.message,
            'message',
            contains('rate limit exceeded'),
          ),
        ),
      );
    });

    test('handles string response errors', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
      dio.httpClientAdapter = _FakeAdapter((options, _, __) async {
        return ResponseBody.fromString(
          'Internal Server Error',
          500,
          headers: const {
            Headers.contentTypeHeader: ['text/plain'],
          },
        );
      });

      expect(
        () => ApiService.sendMessage(
          message: 'test',
          modelId: 'openai/gpt-4o-mini',
          dioOverride: dio,
          tokenProvider: () async => 'token',
        ),
        throwsA(
          isA<HttpException>().having(
            (e) => e.message,
            'message',
            contains('Internal Server Error'),
          ),
        ),
      );
    });

    test('handles long string response errors with truncation', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
      final longBody = 'x' * 250;
      dio.httpClientAdapter = _FakeAdapter((options, _, __) async {
        return ResponseBody.fromString(
          longBody,
          500,
          headers: const {
            Headers.contentTypeHeader: ['text/plain'],
          },
        );
      });

      expect(
        () => ApiService.sendMessage(
          message: 'test',
          modelId: 'openai/gpt-4o-mini',
          dioOverride: dio,
          tokenProvider: () async => 'token',
        ),
        throwsA(
          isA<HttpException>().having(
            (e) => e.message,
            'message',
            contains('${'x' * 197}...'),
          ),
        ),
      );
    });

    test('handles DioException with no response', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
      dio.httpClientAdapter = _FakeAdapter((options, _, __) async {
        throw DioException(
          requestOptions: options,
          message: 'Connection refused',
          type: DioExceptionType.connectionTimeout,
        );
      });

      expect(
        () => ApiService.sendMessage(
          message: 'test',
          modelId: 'openai/gpt-4o-mini',
          dioOverride: dio,
          tokenProvider: () async => 'token',
        ),
        throwsA(
          isA<HttpException>().having(
            (e) => e.message,
            'message',
            contains('BFF ??'),
          ),
        ),
      );
    });

    test('handles token provider exceptions gracefully', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
      dio.httpClientAdapter = _FakeAdapter((options, _, __) async {
        return ResponseBody.fromString(
          jsonEncode({'message': 'ok'}),
          200,
          headers: const {
            Headers.contentTypeHeader: ['application/json'],
          },
        );
      });

      expect(
        () => ApiService.sendMessage(
          message: 'test',
          modelId: 'openai/gpt-4o-mini',
          dioOverride: dio,
          tokenProvider: () async => throw Exception('no token'),
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this._handler);

  final Future<ResponseBody> Function(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) _handler;

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
