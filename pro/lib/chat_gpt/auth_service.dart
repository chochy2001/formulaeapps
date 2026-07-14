import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart' as uio;
import 'package:universal_platform/universal_platform.dart';

import 'api_consts.dart';

/// `AuthService` mints and caches BFF session JWTs. Replaces the FE-self-signed
/// pattern that lived in `jwt_service.dart` per research §R4 and FR-005.
///
/// Lifecycle:
///   1. First call to `getToken()` → load (or generate + persist) the stable
///      per-install `client_id` via SharedPreferences; compute `client_proof`
///      HMAC; POST to `/auth/token`; cache returned JWT + expiry in memory.
///   2. Subsequent calls → return cached token until it nears expiry, then
///      transparently refresh.
///   3. Tokens are NEVER persisted (memory only) — losing them means we just
///      re-mint; that's intentional, FR-022.
class AuthService {
  AuthService._();

  static const String _clientIdKey = 'formulae_bff_client_id';
  static const Duration _refreshBuffer = Duration(minutes: 5);

  static String? _cachedToken;
  static DateTime? _cachedExpiresAt;
  static Future<String>? _inflight;

  /// Returns a valid Bearer token. Mints a new one if no cache or near expiry.
  static Future<String> getToken({http.Client? client}) async {
    final now = DateTime.now().toUtc();
    if (_cachedToken != null &&
        _cachedExpiresAt != null &&
        _cachedExpiresAt!.isAfter(now.add(_refreshBuffer))) {
      return _cachedToken!;
    }
    // Coalesce concurrent callers onto a single refresh.
    _inflight ??= _refresh(client).whenComplete(() => _inflight = null);
    return _inflight!;
  }

  /// Clears the cached token. The next `getToken()` call mints fresh.
  static void invalidate() {
    _cachedToken = null;
    _cachedExpiresAt = null;
  }

  /// Stable per-install client UUID (SharedPreferences). Used when binding
  /// device entitlements to an account via optional `client_id` on register/login.
  static Future<String> stableClientId() => _stableClientId();

  /// Adopts a rotated token surfaced by the BFF in the `X-Auth-Refresh`
  /// response header. The expiry is derived from a fresh decode of the JWT
  /// payload — keeps the cache honest about how long the rotated token lasts.
  static void adoptRotatedToken(String token) {
    final exp = _exposeExp(token);
    if (exp == null) return;
    _cachedToken = token;
    _cachedExpiresAt = exp;
  }

  /// Adopts an account-auth JWT (register/login) into the session cache.
  static void adoptAccountToken(String token, {required DateTime expiresAt}) {
    _cachedToken = token;
    _cachedExpiresAt = expiresAt.toUtc();
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

  /// Loads a stable UUIDv4 from SharedPreferences, generating one on first run.
  static Future<String> _stableClientId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_clientIdKey);
    if (existing != null && existing.isNotEmpty) return existing;
    final fresh = _generateUuidV4();
    await prefs.setString(_clientIdKey, fresh);
    return fresh;
  }

  /// HMAC-SHA256(jwt_shared_secret, client_id ++ build_nonce) as lowercase hex.
  static String _clientProof(String clientId) {
    final hmac = Hmac(sha256, utf8.encode(jwtSharedSecret));
    final digest = hmac.convert(utf8.encode(clientId + buildNonce));
    return digest.toString();
  }

  /// Hand-rolled UUIDv4 (RFC 4122 §4.4). Avoids adding a `uuid` package dep.
  static String _generateUuidV4() {
    final r = Random.secure();
    final bytes = List<int>.generate(16, (_) => r.nextInt(256));
    // Set version (4) and variant (10xx) bits per RFC 4122.
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-'
        '${hex.substring(20, 32)}';
  }

  /// Detects platform value the BFF expects for the `platform` claim.
  static String _detectPlatform() {
    if (UniversalPlatform.isWeb) return 'web';
    if (UniversalPlatform.isAndroid) return 'android';
    if (UniversalPlatform.isIOS) return 'ios';
    if (UniversalPlatform.isMacOS) return 'macos';
    // Fallback for desktop targets not enumerated in the BFF schema.
    if (uio.Platform.isWindows || uio.Platform.isLinux) return 'web';
    return 'web';
  }

  /// Decodes the `exp` claim from a JWT (without verifying). Returns null if
  /// the token is malformed. Used only for rotated-token expiry hint.
  static DateTime? _exposeExp(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return null;
    try {
      final padded = parts[1].padRight(parts[1].length + (4 - parts[1].length % 4) % 4, '=');
      final payload = jsonDecode(utf8.decode(base64Url.decode(padded))) as Map<String, dynamic>;
      final exp = payload['exp'];
      if (exp is int) return DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
      return null;
    } catch (_) {
      return null;
    }
  }
}
