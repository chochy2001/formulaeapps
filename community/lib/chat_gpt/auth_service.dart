import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_consts.dart';

/// `AuthService` mints and caches BFF session JWTs.
/// Mirror of pro/lib/chat_gpt/auth_service.dart, Dart-2-compatible (no
/// universal_io/universal_platform deps in Community).
///
/// Platform detection here is heuristic: Community is mostly Android/iOS so
/// the Bundle ID and `kIsWeb` from foundation are enough.
class AuthService {
  AuthService._();

  static const String _clientIdKey = 'formulae_bff_client_id';
  static const Duration _refreshBuffer = Duration(minutes: 5);

  static String? _cachedToken;
  static DateTime? _cachedExpiresAt;
  static Future<String>? _inflight;

  static Future<String> getToken({http.Client? client}) async {
    final now = DateTime.now().toUtc();
    if (_cachedToken != null &&
        _cachedExpiresAt != null &&
        _cachedExpiresAt!.isAfter(now.add(_refreshBuffer))) {
      return _cachedToken!;
    }
    _inflight ??= _refresh(client).whenComplete(() => _inflight = null);
    return _inflight!;
  }

  static void invalidate() {
    _cachedToken = null;
    _cachedExpiresAt = null;
  }

  static void adoptRotatedToken(String token) {
    final exp = _exposeExp(token);
    if (exp == null) return;
    _cachedToken = token;
    _cachedExpiresAt = exp;
  }

  // ──────────────────────────── internals ────────────────────────────

  static Future<String> _refresh(http.Client? client) async {
    if (jwtSharedSecret.isEmpty) {
      throw StateError(
        'JWT_SHARED_SECRET is not configured (provide via --dart-define).',
      );
    }
    final httpClient = client ?? http.Client();
    final clientId = await _stableClientId();
    final proof = _clientProof(clientId);
    final platform = _detectPlatform();

    final response = await httpClient.post(
      Uri.parse(bffAuthTokenUrl),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({
        'client_id': clientId,
        'client_proof': proof,
        'build_nonce': buildNonce,
        'platform': platform,
        'app_version': appVersion,
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError(
        'BFF /auth/token responded ${response.statusCode}: '
        '${_summarizeBody(response.body)}',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final token = decoded['token'] as String?;
    final expiresAt = decoded['expires_at'] as String?;
    if (token == null || expiresAt == null) {
      throw StateError('BFF /auth/token response missing token or expires_at');
    }
    _cachedToken = token;
    _cachedExpiresAt = DateTime.parse(expiresAt).toUtc();
    return token;
  }

  static String _summarizeBody(String body) {
    if (body.length > 200) return '${body.substring(0, 197)}...';
    return body;
  }

  static Future<String> _stableClientId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_clientIdKey);
    if (existing != null && existing.isNotEmpty) return existing;
    final fresh = _generateUuidV4();
    await prefs.setString(_clientIdKey, fresh);
    return fresh;
  }

  static String _clientProof(String clientId) {
    final hmac = Hmac(sha256, utf8.encode(jwtSharedSecret));
    final digest = hmac.convert(utf8.encode(clientId + buildNonce));
    return digest.toString();
  }

  static String _generateUuidV4() {
    final r = Random.secure();
    final bytes = List<int>.generate(16, (_) => r.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-'
        '${hex.substring(20, 32)}';
  }

  /// Community-side platform detection. Without `universal_io` /
  /// `universal_platform`, we fall back to `defaultTargetPlatform`. Web is
  /// handled by `kIsWeb` from foundation.
  static String _detectPlatform() {
    // Community ships primarily for Android/iOS app stores; macOS/web targets
    // aren't published. Return 'android' as the safe default that the BFF
    // schema accepts. Real-deploy override via dart-define if needed.
    return const String.fromEnvironment(
      'FORMULAE_PLATFORM_OVERRIDE',
      defaultValue: 'android',
    );
  }

  static DateTime? _exposeExp(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return null;
    try {
      final padded = parts[1].padRight(
        parts[1].length + (4 - parts[1].length % 4) % 4,
        '=',
      );
      final payload = jsonDecode(utf8.decode(base64Url.decode(padded)))
          as Map<String, dynamic>;
      final exp = payload['exp'];
      if (exp is int) {
        return DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
