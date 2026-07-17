import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';

import 'api_consts.dart';
import 'auth_service.dart';
import 'iap_validation_service.dart';

typedef BffEntitlementClientFactory = FormulaeappsBffClient Function(
  String bearerToken,
);

/// Reads channel-scoped mobile entitlements from BFF `GET /entitlement`.
///
/// Used by the paywall pre-IAP guard when [kEnableBffIapValidation] is on
/// (default **off**). Local store gating is unchanged until accounts land —
/// see `docs/ENTITLEMENT_CHANNEL_SYNC.md`.
class EntitlementService {
  EntitlementService({
    BffEntitlementClientFactory? clientFactory,
    Future<String> Function()? tokenProvider,
  })  : _clientFactory = clientFactory ?? _defaultClientFactory,
        _tokenProvider = tokenProvider ?? AuthService.getToken;

  final BffEntitlementClientFactory _clientFactory;
  final Future<String> Function() _tokenProvider;

  static FormulaeappsBffClient _defaultClientFactory(String bearerToken) {
    final client = FormulaeappsBffClient(basePathOverride: bffBaseUrl);
    client.setBearerAuth('bearerAuth', bearerToken);
    return client;
  }

  /// Fetches mobile entitlements for the current JWT subject.
  ///
  /// Returns `null` on auth/network/parse errors (callers that gate purchases
  /// behind [kEnableBffIapValidation] must treat null as fail-closed).
  Future<EntitlementResponse?> fetchEntitlement() async {
    try {
      final token = await _tokenProvider();
      if (token.isEmpty) {
        if (kDebugMode) {
          debugPrint('Entitlement: empty token, skipping GET /entitlement');
        }
        return null;
      }

      final client = _clientFactory(token);
      final response = await client.getEntitlementApi().entitlementGet();

      final rotated = response.headers.value('x-auth-refresh');
      if (rotated != null && rotated.isNotEmpty) {
        AuthService.adoptRotatedToken(rotated);
      }

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return response.data;
      }

      if (kDebugMode) {
        debugPrint(
          'Entitlement: GET /entitlement failed HTTP ${response.statusCode}',
        );
      }
      return null;
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint(
          'Entitlement: GET /entitlement DioException '
          '(${e.response?.statusCode}): ${e.message}',
        );
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Entitlement: GET /entitlement error: $e');
      }
      return null;
    }
  }
}
