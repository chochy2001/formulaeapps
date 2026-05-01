import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'api_consts.dart';

class JwtService {
  static String createToken({
    Duration ttl = const Duration(minutes: 5),
  }) {
    if (jwtSharedSecret.isEmpty) {
      throw StateError('JWT_SHARED_SECRET is not configured.');
    }

    final now = DateTime.now().toUtc();
    final iat = now.millisecondsSinceEpoch ~/ 1000;
    final exp = now.add(ttl).millisecondsSinceEpoch ~/ 1000;

    final header = <String, Object>{
      'alg': 'HS256',
      'typ': 'JWT',
    };
    final payload = <String, Object>{
      'iss': 'formulae-flutter',
      'aud': 'formulae-bff',
      'sub': 'formulae-chat',
      'iat': iat,
      'exp': exp,
    };

    final unsignedToken =
        '${_base64UrlJson(header)}.${_base64UrlJson(payload)}';
    final signature = Hmac(
      sha256,
      utf8.encode(jwtSharedSecret),
    ).convert(utf8.encode(unsignedToken));

    return '$unsignedToken.${_base64UrlBytes(signature.bytes)}';
  }

  static String _base64UrlJson(Map<String, Object> value) {
    return _base64UrlBytes(utf8.encode(jsonEncode(value)));
  }

  static String _base64UrlBytes(List<int> bytes) {
    return base64Url.encode(bytes).replaceAll('=', '');
  }
}
