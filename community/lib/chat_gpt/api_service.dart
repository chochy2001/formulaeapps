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

/// Community-side BFF chat client.
/// Mirror of pro/lib/chat_gpt/api_service.dart with the same responsibilities:
/// - Bearer auth from `AuthService.getToken()` (replaces FE-self-signed JWT
///   per FR-005).
/// - System prompts live BFF-side (FR-019); client sends only user message.
/// - Response shape matches the BFF contract `ChatResponse` (data-model §E5).
/// - Adopts rotated tokens from `X-Auth-Refresh` header (research §R4).
class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    // BFF contract v1.0.0 does not expose /openai/models. Stub list keeps
    // the existing models_provider.dart + drop_down.dart UI working.
    return [
      ModelsModel(
        id: 'gpt-3.5-turbo',
        created: 0,
        root: 'formulae-bff',
      ),
    ];
  }

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

      // Adopt rotated JWT if the BFF surfaced one.
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

  static String _errorEnvelopeMessage(Map<String, dynamic> jsonResponse) {
    final err = jsonResponse['error'];
    if (err is Map) {
      final msg = err['message'];
      if (msg is String) return msg;
      return err.toString();
    }
    if (err is String) return err;
    final topMessage = jsonResponse['message'];
    if (topMessage is String) return topMessage;
    return 'BFF request failed';
  }
}
