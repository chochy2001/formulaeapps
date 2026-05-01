// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:async';
import 'package:universal_io/io.dart';
import '../constantes/export_constantes.dart';
import '../widgets_personalizados/textos_personalizados.dart';

class InAppPurchaseManager extends ChangeNotifier {
  bool disposed = false;
  late String device;
  late final InAppPurchase _inAppPurchase;
  bool _hasValidPurchase = false;
  List<ProductDetails> _products = [];
  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  InAppPurchaseManager() {
    _inAppPurchase = InAppPurchase.instance;
    _inAppPurchase.purchaseStream.listen((purchases) {
      handlePurchaseUpdates(purchases);
    });
  }

  set inAppPurchase(InAppPurchase value) {
    _inAppPurchase = value;
  }

  InAppPurchase get inAppPurchase => _inAppPurchase;

  bool get hasValidPurchase => _hasValidPurchase;
  List<ProductDetails> get products => _products;

  void handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (kDebugMode) {
        print(
            'Product ID: ${purchaseDetails.productID}, status: ${purchaseDetails.status}, pending complete purchase: ${purchaseDetails.pendingCompletePurchase}');
      }
      if ((purchaseDetails.status == PurchaseStatus.purchased ||
              purchaseDetails.status == PurchaseStatus.restored) &&
          purchaseDetails.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchaseDetails);
        if (kDebugMode) {
          print(
              'Completing purchase for product ID: ${purchaseDetails.productID}');
        }
        _hasValidPurchase = true;

        // Verifica si el objeto aún existe antes de llamar a notifyListeners
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
    // Aquí podrías mostrar un mensaje al usuario o realizar otro tipo de manejo de errores
  }

  Future<void> buyProduct(ProductDetails productDetails) async {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);

    try {
      // Inicializa la API de in_app_purchase
      final bool available = await InAppPurchase.instance.isAvailable();
      if (!available) {
        // La tienda no está disponible, maneja este error aquí.
      }
      // Ahora intenta hacer la compra
      await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      if (kDebugMode) {
        print('Error al comprar el producto: $e');
      }
      // Aquí podrías mostrar un mensaje al usuario o realizar otro tipo de manejo de errores
    }
  }

  Future<void> getProducts() async {
    Set<String> productIds = _getPlatformProductIds();
    if (productIds.isNotEmpty) {
      final ProductDetailsResponse response =
          await _inAppPurchase.queryProductDetails(productIds);
      if (response.notFoundIDs.isEmpty) {
        _products = response.productDetails;
        notifyListeners();
      }
    }
  }

  Set<String> _getPlatformProductIds() {
    if (Platform.isAndroid) {
      return {
        'chat_anual_2023',
        'android_chat_mensual_2023',
        'chat_semanal_2023',
      };
    } else if (Platform.isIOS || Platform.isMacOS) {
      return {
        'chat_anual_2023_01',
        'chat_mensual_2023_01',
        'chat_semanal_2023_01',
      };
    } else {
      return {};
    }
  }

  void showProductsDialog(BuildContext context) {
    if (Platform.isAndroid) {
      device = 'Google';
    } else if (Platform.isIOS) {
      device = 'Apple';
    } else if (Platform.isMacOS) {
      device = 'Apple';
    } else if (Platform.isWindows) {
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
                        const FadeInImage(
                          height: 50.0,
                          width: 50.0,
                          placeholder: AssetImage(kUrlImagenGifCarga),
                          image: NetworkImage(kUrlImagenFormulae),
                        ),
                        Expanded(
                          child: TextoEcuaciones(
                            product.title,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      product.description,
                      style: kEstiloSubMenu,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.price,
                          style: kTextoEcuaciones,
                        ),
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
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : kColorFondo),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: kColorBlanco,
                      thickness: 1.0,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
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
                _inAppPurchase.restorePurchases();
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
    purchaseUpdatedSubscription = _inAppPurchase.purchaseStream.listen(
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
      await _inAppPurchase.restorePurchases();
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
