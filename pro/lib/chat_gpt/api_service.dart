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
/// stays here.
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

/// `ApiService` — thin adapter around the generated `ChatApi` from the
/// BFF OpenAPI codegen (`packages/formulaeapps_bff_client`).
///
/// Why an adapter and not the raw client?
/// - The UI in `chats_provider.dart`, `chat_widget.dart`, `chat_screen.dart`
///   consumes `ChatModel { msg, chatIndex }` — a UI struct with `chatIndex`
///   distinguishing user (0) and assistant (1) messages. This concern has no
///   backend representation, so it stays local even though the BFF contract
///   is now the source of truth for payloads.
/// - The generated `openaiChatPost` returns a typed `Response<ChatResponse>`
///   from Dio. We unwrap that and translate to `ChatModel` so the UI is
///   unchanged.
///
/// Behavior:
/// - Bearer auth via `AuthService.getToken()` (BFF-issued JWT, FR-005).
/// - System prompts live server-side (`bff/src/schemas/prompts.ts`).
/// - Reads `X-Auth-Refresh` from the Dio response headers and adopts a
///   rotated token (research §R4 + FR-005).
/// - Maps `DioException` to `HttpException` with redacted summary.
class ApiService {
  /// Stub list — the BFF contract v1.0.0 does not expose `/openai/models`.
  /// Kept for backward compatibility with the existing `models_provider.dart`
  /// + `drop_down.dart` UI. Replace with a real BFF route if/when model
  /// selection ships through the contract.
  static Future<List<ModelsModel>> getModels() async {
    return [
      ModelsModel(
        id: 'openai/gpt-4o-mini',
        created: 0,
        root: 'formulae-bff',
      ),
    ];
  }

  /// Sends a chat message through the BFF using the generated `ChatApi`.
  ///
  /// `modelId` is forwarded as the OpenRouter `provider/model` selector (the
  /// BFF allowlist gates it, see `bff/src/services/openrouter-proxy.ts`).
  /// Callers may pass legacy bare model ids like `'gpt-3.5-turbo'`; the
  /// underlying allowlist will reject them with a 4xx — that's an explicit
  /// signal that the allowlist needs updating, not a silent fallback.
  static Future<List<ChatModel>> sendMessage({
    required String message,
    required String modelId,
    BaseOptions? dioOptionsOverride,
    Dio? dioOverride,
    ChatTokenProvider? tokenProvider,
    RotatedTokenHandler? rotatedTokenHandler,
  }) async {
    final token = await (tokenProvider ?? AuthService.getToken)();

    final client = FormulaeappsBffClient(
      basePathOverride: bffBaseUrl,
      dio: dioOverride ??
          Dio(
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

      // Adopt rotated JWT if the BFF surfaced one (research §R4 + FR-005).
      final rotated = response.headers.value('x-auth-refresh');
      if (rotated != null && rotated.isNotEmpty) {
        (rotatedTokenHandler ?? AuthService.adoptRotatedToken)(rotated);
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

  // ─────────────────────── helpers ───────────────────────

  /// Extracts a short, redacted summary from a `DioException`. The BFF emits
  /// an `ErrorEnvelope { error: { kind, message, code?, request_id } }` shape
  /// on 4xx/5xx; older shapes fall through to a generic message.
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
