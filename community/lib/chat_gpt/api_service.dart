import 'dart:io';

import 'package:dio/dio.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';

import 'api_consts.dart';
import 'auth_service.dart';
import 'chat_model.dart';
import 'models_model.dart';

export '../chat_gpt/api_consts.dart';
export '../chat_gpt/chat_model.dart';
export '../chat_gpt/models_model.dart';

/// Community-side BFF chat client — adapter around the generated `ChatApi`
/// from `packages/formulaeapps_bff_client/`. Mirror of pro/api_service.dart.
///
/// - Bearer auth via `AuthService.getToken()` (FR-005).
/// - System prompts live server-side (`bff/src/schemas/prompts.ts`).
/// - Reads `X-Auth-Refresh` and rotates the cached token (research §R4).
/// - Translates the generated `ChatResponse` to the local UI struct
///   `ChatModel { msg, chatIndex }` so chats_provider stays unchanged.
class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    // BFF contract v1.0.0 does not expose /openai/models. Stub list keeps
    // the existing models_provider.dart + drop_down.dart UI working.
    return [
      ModelsModel(
        id: 'openai/gpt-4o-mini',
        created: 0,
        root: 'formulae-bff',
      ),
    ];
  }

  static Future<List<ChatModel>> sendMessage({
    required String message,
    required String modelId,
    BaseOptions? dioOptionsOverride,
  }) async {
    final token = await AuthService.getToken();

    final client = FormulaeappsBffClient(
      basePathOverride: bffBaseUrl,
      dio: Dio(
        dioOptionsOverride ??
            BaseOptions(
              baseUrl: bffBaseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 60),
            ),
      ),
    );
    client.setBearerAuth('bearerAuth', token);

    try {
      final response = await client.getChatApi().openaiChatPost(
            chatRequest: ChatRequest(
              (b) => b
                ..message = message
                ..modelId = modelId,
            ),
          );

      final rotated = response.headers.value('x-auth-refresh');
      if (rotated != null && rotated.isNotEmpty) {
        AuthService.adoptRotatedToken(rotated);
      }

      final data = response.data;
      if (data == null || data.message.isEmpty) {
        throw const HttpException('BFF returned no message content');
      }

      return [
        ChatModel(msg: data.message, chatIndex: 1),
      ];
    } on DioException catch (e) {
      throw HttpException(
        'BFF ${e.response?.statusCode ?? "??"}: ${_summarizeDioError(e)}',
      );
    }
  }

  static String _summarizeDioError(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final err = data['error'];
      if (err is Map) {
        final msg = err['message'];
        if (msg is String) return msg;
      }
      final topMsg = data['message'];
      if (topMsg is String) return topMsg;
    }
    if (data is String && data.isNotEmpty) {
      return data.length > 200 ? '${data.substring(0, 197)}...' : data;
    }
    return e.message ?? 'BFF request failed';
  }
}
