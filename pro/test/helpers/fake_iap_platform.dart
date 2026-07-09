import 'dart:async';

import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';

/// Fake store used by IAP unit tests. Emits purchase updates on demand.
class FakeInAppPurchasePlatform extends InAppPurchasePlatform {
  FakeInAppPurchasePlatform({
    this.available = true,
    List<ProductDetails>? products,
    this.notFoundIds = const <String>{},
    this.buyThrows = false,
    this.restoreThrows = false,
  }) : products = products ?? <ProductDetails>[];

  bool available;
  List<ProductDetails> products;
  Set<String> notFoundIds;
  bool buyThrows;
  bool restoreThrows;

  final StreamController<List<PurchaseDetails>> _purchaseController =
      StreamController<List<PurchaseDetails>>.broadcast();

  final List<PurchaseDetails> completedPurchases = <PurchaseDetails>[];
  int buyCalls = 0;
  int restoreCalls = 0;
  Set<String>? lastQueriedIds;

  @override
  Stream<List<PurchaseDetails>> get purchaseStream =>
      _purchaseController.stream;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<ProductDetailsResponse> queryProductDetails(
    Set<String> identifiers,
  ) async {
    lastQueriedIds = identifiers;
    return ProductDetailsResponse(
      productDetails: products,
      notFoundIDs: notFoundIds.toList(),
    );
  }

  @override
  Future<bool> buyNonConsumable({
    required PurchaseParam purchaseParam,
  }) async {
    buyCalls++;
    if (buyThrows) {
      throw StateError('buy failed');
    }
    return true;
  }

  @override
  Future<bool> buyConsumable({
    required PurchaseParam purchaseParam,
    bool autoConsume = true,
  }) async {
    return buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  Future<void> completePurchase(PurchaseDetails purchase) async {
    completedPurchases.add(purchase);
  }

  @override
  Future<void> restorePurchases({String? applicationUserName}) async {
    restoreCalls++;
    if (restoreThrows) {
      throw StateError('restore failed');
    }
  }

  void emit(List<PurchaseDetails> purchases) {
    _purchaseController.add(purchases);
  }

  Future<void> close() => _purchaseController.close();
}

PurchaseDetails fakePurchase({
  required String productId,
  required PurchaseStatus status,
  bool pendingCompletePurchase = false,
  IAPError? error,
}) {
  final details = PurchaseDetails(
    productID: productId,
    verificationData: PurchaseVerificationData(
      localVerificationData: 'local',
      serverVerificationData: 'server',
      source: 'test',
    ),
    transactionDate: '0',
    status: status,
  )..pendingCompletePurchase = pendingCompletePurchase;
  if (error != null) {
    details.error = error;
  }
  return details;
}

ProductDetails fakeProduct(String id) {
  return ProductDetails(
    id: id,
    title: 'Title $id',
    description: 'Description $id',
    price: '\$9.99',
    rawPrice: 9.99,
    currencyCode: 'USD',
  );
}
