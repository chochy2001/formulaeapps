import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:universal_io/io.dart' as uio;

import 'api_consts.dart';
import 'auth_service.dart';

/// Opt-in server validation of store receipts via BFF `POST /iap/validate`.
///
/// Default **off** (`ENABLE_BFF_IAP_VALIDATION=false`). When enabled, this is a
/// best-effort telemetry/contract step only — [InAppPurchaseManager] still gates
/// locally until account-bound entitlements ship (see
/// `docs/ENTITLEMENT_CHANNEL_SYNC.md`).
const bool kEnableBffIapValidation = bool.fromEnvironment(
  'ENABLE_BFF_IAP_VALIDATION',
  defaultValue: false,
);

typedef BffClientFactory = FormulaeappsBffClient Function(String bearerToken);

class IapValidationService {
  IapValidationService({
    BffClientFactory? clientFactory,
    Future<String> Function()? tokenProvider,
    bool? enabled,
  }) : _clientFactory = clientFactory ?? _defaultClientFactory,
       _tokenProvider = tokenProvider ?? AuthService.getToken,
       _enabled = enabled ?? kEnableBffIapValidation;

  final BffClientFactory _clientFactory;
  final Future<String> Function() _tokenProvider;
  final bool _enabled;

  static FormulaeappsBffClient _defaultClientFactory(String bearerToken) {
    final client = FormulaeappsBffClient(basePathOverride: bffBaseUrl);
    client.setBearerAuth('bearerAuth', bearerToken);
    return client;
  }

  /// Returns the BFF validation payload, or `null` when disabled / skipped.
  Future<IapValidateResponse?> validatePurchase(
    PurchaseDetails purchase, {
    String? platformOverride,
  }) async {
    if (!_enabled) {
      return null;
    }

    final platform = platformOverride ?? _detectPlatform();
    if (platform == null) {
      if (kDebugMode) {
        debugPrint(
          'IapValidation: unsupported platform, skipping BFF validate',
        );
      }
      return null;
    }

    final receipt = purchase.verificationData.serverVerificationData;
    if (receipt.isEmpty) {
      if (kDebugMode) {
        debugPrint('IapValidation: empty receipt, skipping BFF validate');
      }
      return null;
    }

    final token = await _tokenProvider();
    final client = _clientFactory(token);

    final request = IapValidateRequest(
      (b) => b
        ..platform = platform == 'apple'
            ? IapValidateRequestPlatformEnum.apple
            : IapValidateRequestPlatformEnum.google
        ..productId = purchase.productID
        ..transactionId = purchase.purchaseID ?? ''
        ..receiptData = receipt
        ..subscription = _isSubscriptionProduct(purchase.productID),
    );

    try {
      final response = await client.getIapApi().iapValidatePost(
        iapValidateRequest: request,
      );

      final rotated = response.headers.value('x-auth-refresh');
      if (rotated != null && rotated.isNotEmpty) {
        AuthService.adoptRotatedToken(rotated);
      }

      return response.data;
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint(
          'IapValidation: BFF validate failed (${e.response?.statusCode}): ${e.message}',
        );
      }
      return null;
    }
  }

  static String? _detectPlatform() {
    if (uio.Platform.isIOS || uio.Platform.isMacOS) return 'apple';
    if (uio.Platform.isAndroid) return 'google';
    return null;
  }

  static bool _isSubscriptionProduct(String productId) {
    final id = productId.toLowerCase();
    return id.contains('mensual') ||
        id.contains('semanal') ||
        id.contains('anual');
  }
}
