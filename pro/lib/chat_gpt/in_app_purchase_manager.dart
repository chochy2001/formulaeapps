// ignore_for_file: unnecessary_getters_setters

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:universal_io/io.dart';

import '../constantes/export_constantes.dart';
import '../widgets_personalizados/textos_personalizados.dart';
import '../widgets_personalizados/zoom_image_personalizado.dart';
import 'entitlement_channel.dart';
import 'entitlement_service.dart';
import 'iap_validation_service.dart';

/// Product catalog + purchase stream handler for Pro IAP.
///
/// [platform] is injectable so unit tests can drive purchase updates without
/// the real store. Production callers keep using the zero-arg constructor.
class InAppPurchaseManager extends ChangeNotifier {
  InAppPurchaseManager({
    InAppPurchasePlatform? platform,
    bool listenToPurchases = true,
    this.platformOverride,
    EntitlementService? entitlementService,
    bool? bffIapValidationEnabled,
  }) : _platform = platform ?? _defaultPlatform(),
       _entitlementService = entitlementService ?? EntitlementService(),
       _bffIapValidationEnabled =
           bffIapValidationEnabled ?? kEnableBffIapValidation {
    if (listenToPurchases) {
      _purchaseSubscription = _platform.purchaseStream.listen(
        handlePurchaseUpdates,
      );
    }
  }

  /// Ensures the public [InAppPurchase] facade registers a platform first.
  static InAppPurchasePlatform _defaultPlatform() {
    InAppPurchase.instance;
    return InAppPurchasePlatform.instance;
  }

  final InAppPurchasePlatform _platform;
  final String? platformOverride;
  final EntitlementService _entitlementService;
  final bool _bffIapValidationEnabled;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  bool disposed = false;
  late String device;
  bool _hasValidPurchase = false;
  List<ProductDetails> _products = [];

  /// Last pre-purchase block reason when [ENABLE_BFF_IAP_VALIDATION] is on.
  /// Anti double-pay UX stub — callers may surface this in UI later.
  MobileIapPurchaseDecision? lastPurchaseBlockReason;

  @override
  void dispose() {
    disposed = true;
    _purchaseSubscription?.cancel();
    super.dispose();
  }

  @visibleForTesting
  InAppPurchasePlatform get platform => _platform;

  /// Compatibility alias for callers that previously used `inAppPurchase`.
  InAppPurchasePlatform get inAppPurchase => _platform;

  bool get hasValidPurchase => _hasValidPurchase;
  List<ProductDetails> get products => _products;

  void handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (kDebugMode) {
        print(
          'Product ID: ${purchaseDetails.productID}, status: ${purchaseDetails.status}, pending complete purchase: ${purchaseDetails.pendingCompletePurchase}',
        );
      }
      if ((purchaseDetails.status == PurchaseStatus.purchased ||
              purchaseDetails.status == PurchaseStatus.restored) &&
          purchaseDetails.pendingCompletePurchase) {
        _platform.completePurchase(purchaseDetails);
        if (kDebugMode) {
          print(
            'Completing purchase for product ID: ${purchaseDetails.productID}',
          );
        }
        _hasValidPurchase = true;

        if (_bffIapValidationEnabled) {
          unawaited(
            IapValidationService(
              enabled: true,
            ).validatePurchase(purchaseDetails),
          );
        }

        if (!disposed) {
          notifyListeners();
        }
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        _handlePurchaseError(purchaseDetails);
      }
    }
  }

  void _handlePurchaseError(PurchaseDetails purchaseDetails) {
    if (kDebugMode) {
      print('Error en la compra: ${purchaseDetails.error}');
    }
  }

  Future<void> buyProduct(ProductDetails productDetails) async {
    lastPurchaseBlockReason = null;

    // Opt-in fail-closed anti double-pay guard (fleet §10 / WP5 steps 3–4).
    // Default off via ENABLE_BFF_IAP_VALIDATION — local gating unchanged.
    if (_bffIapValidationEnabled) {
      final decision = await _evaluatePrePurchaseGuard();
      if (decision != MobileIapPurchaseDecision.allow) {
        lastPurchaseBlockReason = decision;
        if (kDebugMode) {
          debugPrint(
            'IAP: pre-purchase blocked ($decision) — anti double-pay stub',
          );
        }
        if (!disposed) {
          notifyListeners();
        }
        return;
      }
    }

    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: productDetails,
    );

    try {
      final bool available = await _platform.isAvailable();
      if (!available) {
        return;
      }
      await _platform.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      if (kDebugMode) {
        print('Error al comprar el producto: $e');
      }
    }
  }

  /// Fail-closed: network/auth errors block the charge when the flag is on.
  Future<MobileIapPurchaseDecision> _evaluatePrePurchaseGuard() async {
    try {
      final entitlement = await _entitlementService.fetchEntitlement();
      return evaluateMobileIapPurchase(
        entitlement: entitlement,
        fetchFailed: entitlement == null,
      );
    } catch (_) {
      return MobileIapPurchaseDecision.blockCheckFailed;
    }
  }

  Future<void> getProducts() async {
    Set<String> productIds = platformProductIds();
    if (productIds.isNotEmpty) {
      final ProductDetailsResponse response = await _platform
          .queryProductDetails(productIds);
      if (response.notFoundIDs.isEmpty) {
        _products = response.productDetails;
        notifyListeners();
      }
    }
  }

  /// Store product IDs for the current (or overridden) platform.
  @visibleForTesting
  Set<String> platformProductIds() {
    final name = platformOverride ?? _detectPlatformName();
    if (name == 'android') {
      return {
        'chat_anual_2023',
        'android_chat_mensual_2023',
        'chat_semanal_2023',
      };
    }
    if (name == 'ios' || name == 'macos') {
      return {
        'chat_anual_2023_01',
        'chat_mensual_2023_01',
        'chat_semanal_2023_01',
      };
    }
    return {};
  }

  String _detectPlatformName() {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isWindows) return 'windows';
    return 'other';
  }

  void showProductsDialog(BuildContext context) {
    final name = platformOverride ?? _detectPlatformName();
    if (name == 'android') {
      device = 'Google';
    } else if (name == 'ios' || name == 'macos') {
      device = 'Apple';
    } else if (name == 'windows') {
      device = 'Microsoft';
    } else {
      device = AppLocalizations.of(context)!.tuDispositivo;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          backgroundColor: kColorBotones,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            AppLocalizations.of(context)!.chatIlimitadoPremium,
            style: kEstiloBotones,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: products.map((product) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.pagoCargaraCuenta} $device${AppLocalizations.of(context)!.renovacionAutomatica}',
                      style: kEstiloSubMenu,
                    ),
                    Row(
                      children: [
                        const ImagenRemotaRobusta(
                          height: 50.0,
                          width: 50.0,
                          urlImagen: kUrlImagenFormulae,
                        ),
                        Expanded(child: TextoEcuaciones(product.title)),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(product.description, style: kEstiloSubMenu),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.price, style: kTextoEcuaciones),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(
                              color: kColorFondo,
                              width: 2.0,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            buyProduct(product);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.comprar,
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : kColorFondo,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: kColorBlanco, thickness: 1.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ],
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.restaurarCompras,
                style: kTexto,
              ),
              onPressed: () {
                _platform.restorePurchases();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.cancelar,
                style: kTextoCerrar,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> checkValidPurchase() async {
    Completer<bool> purchaseCompleter = Completer();

    StreamSubscription<List<PurchaseDetails>>? purchaseUpdatedSubscription;
    purchaseUpdatedSubscription = _platform.purchaseStream.listen(
      (purchaseDetailsList) {
        for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
          if (purchaseDetails.status == PurchaseStatus.restored &&
              !_hasValidPurchase) {
            _hasValidPurchase = true;
          }
        }
        purchaseCompleter.complete(_hasValidPurchase);
        purchaseUpdatedSubscription?.cancel();
      },
      onError: (error) {
        purchaseCompleter.completeError(error);
        purchaseUpdatedSubscription?.cancel();
      },
    );

    try {
      await _platform.restorePurchases();
    } catch (e) {
      purchaseCompleter.completeError(e);
      purchaseUpdatedSubscription.cancel();
    }

    return purchaseCompleter.future;
  }

  set hasValidPurchase(bool value) {
    _hasValidPurchase = value;
  }

  set products(List<ProductDetails> value) {
    _products = value;
  }
}
