import 'dart:io';

import 'package:dio/dio.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';

import 'api_consts.dart';
import 'auth_service.dart';

export '../chat_gpt/api_consts.dart';

/// UI handoff struct produced by [ApiService.sendMessage] and consumed by
/// chats_provider.dart + chat_widget.dart + chat_screen.dart. [chatIndex]
/// is a UI-only flag distinguishing user (0) vs assistant (1) messages —
/// no backend representation. The BFF's generated `ChatResponse` only
/// carries the message text and has no role enum, so the speaker concern
/// stays here. Mirror of pro/lib/chat_gpt/api_service.dart.
class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({required this.msg, required this.chatIndex});
}

/// Dropdown option for the model selector in drop_down.dart. The BFF
/// contract v1.0.0 has no `/openai/models` route, so the list is populated
/// from a hardcoded stub in [ApiService.getModels]. [id] is forwarded to
/// the BFF as the OpenRouter `provider/model` selector.
class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({required this.id, required this.created, required this.root});
}

typedef ChatTokenProvider = Future<String> Function();
typedef RotatedTokenHandler = void Function(String token);

/// Community-side BFF chat client — adapter around the generated `ChatApi`
/// from `packages/formulaeapps_bff_client/`. Mirror of pro/api_service.dart.
///
/// - Bearer auth via `AuthService.getToken()` (FR-005).
/// - System prompts live server-side (`bff/src/schemas/prompts.ts`).
/// - Reads `X-Auth-Refresh` and rotates the cached token (research §R4).
/// - Translates the generated `ChatResponse` to the local UI struct
///   `ChatModel { msg, chatIndex }` so chats_provider stays unchanged.
/// - Optional [tokenProvider] / [rotatedTokenHandler] / [dioOverride] keep
///   unit tests free of SharedPreferences + live auth minting.
class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    // BFF contract v1.0.0 does not expose /openai/models. Stub list keeps
    // the existing models_provider.dart + drop_down.dart UI working.
    return [
      ModelsModel(id: 'openai/gpt-4o-mini', created: 0, root: 'formulae-bff'),
    ];
  }

  static Future<List<ChatModel>> sendMessage({
    required String message,
    required String modelId,
    BaseOptions? dioOptionsOverride,
    Dio? dioForTest,
    Dio? dioOverride,
    ChatTokenProvider? tokenProvider,
    RotatedTokenHandler? rotatedTokenHandler,
  }) async {
    final token = await (tokenProvider ?? AuthService.getToken)();

    final dio =
        dioOverride ??
        dioForTest ??
        Dio(
          dioOptionsOverride ??
              BaseOptions(
                baseUrl: bffBaseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 60),
              ),
        );

    final client = FormulaeappsBffClient(
      basePathOverride: bffBaseUrl,
      dio: dio,
    );
    client.setBearerAuth('bearerAuth', token);

    try {
      final response = await client.getChatApi().openaiChatPost(
        chatRequest: ChatRequest(
          (ChatRequestBuilder b) => b
            ..message = message
            ..modelId = modelId,
        ),
      );

      final rotated = response.headers.value('x-auth-refresh');
      if (rotated != null && rotated.isNotEmpty) {
        (rotatedTokenHandler ?? AuthService.adoptRotatedToken)(rotated);
      }

      final data = response.data;
      if (data == null || data.message.isEmpty) {
        throw const HttpException('BFF returned no message content');
      }

      return [ChatModel(msg: data.message, chatIndex: 1)];
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
