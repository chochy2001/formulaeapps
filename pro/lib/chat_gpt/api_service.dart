import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_consts.dart';
import 'auth_service.dart';
import 'chat_model.dart';
import 'models_model.dart';

export '../chat_gpt/api_consts.dart';
export '../chat_gpt/chat_model.dart';
export '../chat_gpt/models_model.dart';

/// `ApiService` — thin client around the FormulaeApps BFF chat endpoint.
///
/// - Bearer auth is obtained from `AuthService.getToken()` (BFF-issued JWT,
///   replaces the old FE-self-signed pattern in `jwt_service.dart` per FR-005).
/// - System prompts live server-side (`bff/src/schemas/prompts.ts`); the client
///   sends only the user's message (spec §FR-019 + SC-009 — prompts updates
///   ship without app-store releases).
/// - The response shape matches the BFF contract `ChatResponse` (data-model §E5).
/// - If the BFF emits an `X-Auth-Refresh` header, the rotated token is adopted
///   automatically (research §R4).
class ApiService {
  /// Stub list — the BFF contract v1.0.0 does not expose `/openai/models`.
  /// Kept for backward compatibility with the existing `models_provider.dart`
  /// + `drop_down.dart` UI. Replace with a real BFF route if/when model
  /// selection ships through the contract.
  static Future<List<ModelsModel>> getModels() async {
    return [
      ModelsModel(
        id: 'gpt-3.5-turbo',
        created: 0,
        root: 'formulae-bff',
      ),
    ];
  }

  /// Sends a chat message through the BFF.
  ///
  /// On success: returns a list with one `ChatModel` carrying the assistant's
  /// reply. On failure: throws `HttpException` with a redacted error summary.
  ///
  /// `modelId` is passed to the BFF as the `model_id` request field; the BFF
  /// enforces an allowlist server-side (research §R1) and may default to its
  /// configured `gpt-4o-mini` if the value is rejected — see contract `ChatRequest`.
  static Future<List<ChatModel>> sendMessage({
    required String message,
    required String modelId,
    http.Client? client,
  }) async {
    final httpClient = client ?? http.Client();
    final token = await AuthService.getToken(client: httpClient);

    try {
      final response = await httpClient.post(
        Uri.parse(bffChatUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': message,
          'model_id': modelId,
        }),
      );

      // Adopt rotated JWT if the BFF surfaced one (research §R4 + spec FR-005).
      final rotated = response.headers['x-auth-refresh'];
      if (rotated != null && rotated.isNotEmpty) {
        AuthService.adoptRotatedToken(rotated);
      }

      final decodedBody = utf8.decode(response.bodyBytes, allowMalformed: true);
      final Map<String, dynamic> jsonResponse =
          jsonDecode(decodedBody) as Map<String, dynamic>;

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpException(
          'BFF ${response.statusCode}: ${_errorEnvelopeMessage(jsonResponse)}',
        );
      }

      // Contract ChatResponse: { message, model_id, usage, prompts_version, conversation_id? }
      final assistant = jsonResponse['message'];
      if (assistant is! String || assistant.isEmpty) {
        throw HttpException('BFF returned no message content');
      }

      return [
        ChatModel(msg: assistant, chatIndex: 1),
      ];
    } catch (e) {
      rethrow;
    }
  }

  // ─────────────────────── helpers ───────────────────────

  /// Extracts the human-readable message from the contract's ErrorEnvelope
  /// shape: `{ error: { kind, message, code?, request_id } }`. Falls back to
  /// older shapes for forward-compat with hand-edited BFFs.
  static String _errorEnvelopeMessage(Map<String, dynamic> jsonResponse) {
    final err = jsonResponse['error'];
    if (err is Map) {
      final msg = err['message'];
      if (msg is String) return msg;
      final reason = err.toString();
      return reason;
    }
    if (err is String) return err;
    final topMessage = jsonResponse['message'];
    if (topMessage is String) return topMessage;
    return 'BFF request failed';
  }
}
