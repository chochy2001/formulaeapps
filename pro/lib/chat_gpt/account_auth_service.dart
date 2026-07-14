import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';

import 'api_consts.dart';
import 'auth_service.dart';

/// Opt-in FE wire for BFF email/password accounts (fleet #86).
///
/// Default **off** (`ENABLE_USER_ACCOUNT_AUTH=false`). When disabled, register/
/// login no-op with [AccountAuthDisabled]. No UI is wired yet — this is the
/// client stub for a later account screen. See `docs/ACCOUNTS_USER_ID_PLAN.md`.
const bool kEnableUserAccountAuth = bool.fromEnvironment(
  'ENABLE_USER_ACCOUNT_AUTH',
  defaultValue: false,
);

typedef BffAccountClientFactory = FormulaeappsBffClient Function();

/// Outcome of a register/login attempt.
sealed class AccountAuthResult {
  const AccountAuthResult();
}

class AccountAuthSuccess extends AccountAuthResult {
  const AccountAuthSuccess({
    required this.userId,
    required this.token,
    required this.expiresAt,
  });

  final String userId;
  final String token;
  final DateTime expiresAt;
}

class AccountAuthDisabled extends AccountAuthResult {
  const AccountAuthDisabled();
}

class AccountAuthFailure extends AccountAuthResult {
  const AccountAuthFailure({
    required this.statusCode,
    required this.message,
    this.code,
  });

  final int? statusCode;
  final String message;
  final String? code;
}

/// Calls BFF `POST /auth/register` and `POST /auth/login` when the flag is on.
class AccountAuthService {
  AccountAuthService({
    BffAccountClientFactory? clientFactory,
    Future<String> Function()? clientIdProvider,
    bool? enabled,
  })  : _clientFactory = clientFactory ?? _defaultClientFactory,
        _clientIdProvider = clientIdProvider ?? AuthService.stableClientId,
        _enabled = enabled ?? kEnableUserAccountAuth;

  final BffAccountClientFactory _clientFactory;
  final Future<String> Function() _clientIdProvider;
  final bool _enabled;

  static FormulaeappsBffClient _defaultClientFactory() {
    return FormulaeappsBffClient(basePathOverride: bffBaseUrl);
  }

  /// Registers an email/password account. Returns [AccountAuthDisabled] when
  /// the dart-define flag is off (default).
  Future<AccountAuthResult> register({
    required String email,
    required String password,
    bool bindDeviceClientId = true,
  }) async {
    if (!_enabled) {
      return const AccountAuthDisabled();
    }
    final clientId = bindDeviceClientId ? await _clientIdProvider() : null;
    final request = AccountRegisterRequest(
      (b) => b
        ..email = email
        ..password = password
        ..clientId = clientId,
    );
    try {
      final response = await _clientFactory().getAuthApi().authRegisterPost(
            accountRegisterRequest: request,
          );
      return _mapResponse(response);
    } on DioException catch (e) {
      return _mapDio(e);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AccountAuth: register error: $e');
      }
      return AccountAuthFailure(statusCode: null, message: e.toString());
    }
  }

  /// Logs in with email/password. Returns [AccountAuthDisabled] when the
  /// dart-define flag is off (default).
  Future<AccountAuthResult> login({
    required String email,
    required String password,
    bool bindDeviceClientId = true,
  }) async {
    if (!_enabled) {
      return const AccountAuthDisabled();
    }
    final clientId = bindDeviceClientId ? await _clientIdProvider() : null;
    final request = AccountLoginRequest(
      (b) => b
        ..email = email
        ..password = password
        ..clientId = clientId,
    );
    try {
      final response = await _clientFactory().getAuthApi().authLoginPost(
            accountLoginRequest: request,
          );
      return _mapResponse(response);
    } on DioException catch (e) {
      return _mapDio(e);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AccountAuth: login error: $e');
      }
      return AccountAuthFailure(statusCode: null, message: e.toString());
    }
  }

  AccountAuthResult _mapResponse(Response<AccountAuthResponse> response) {
    final data = response.data;
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300 &&
        data != null) {
      AuthService.adoptAccountToken(
        data.token,
        expiresAt: data.expiresAt.toUtc(),
      );
      return AccountAuthSuccess(
        userId: data.userId,
        token: data.token,
        expiresAt: data.expiresAt.toUtc(),
      );
    }
    return AccountAuthFailure(
      statusCode: response.statusCode,
      message: 'Account auth failed HTTP ${response.statusCode}',
    );
  }

  AccountAuthResult _mapDio(DioException e) {
    final status = e.response?.statusCode;
    String? code;
    var message = e.message ?? 'Account auth request failed';
    final body = e.response?.data;
    if (body is Map) {
      final error = body['error'];
      if (error is Map) {
        code = error['code'] as String?;
        final msg = error['message'];
        if (msg is String && msg.isNotEmpty) {
          message = msg;
        }
      }
    }
    if (kDebugMode) {
      debugPrint('AccountAuth: DioException HTTP $status code=$code: $message');
    }
    return AccountAuthFailure(statusCode: status, message: message, code: code);
  }
}
