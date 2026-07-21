import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/iap_validation_service.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';

import 'helpers/fake_iap_platform.dart';

class _RecordingClient extends FormulaeappsBffClient {
  _RecordingClient(this.onValidate)
    : super(
        basePathOverride: 'http://test-bff',
        dio: Dio(BaseOptions(baseUrl: 'http://test-bff')),
      );

  final void Function(IapValidateRequest request) onValidate;
  bool called = false;

  @override
  IapApi getIapApi() => _RecordingIapApi(this);
}

class _RecordingIapApi extends IapApi {
  _RecordingIapApi(this._parent) : super(_parent.dio, standardSerializers);

  final _RecordingClient _parent;

  @override
  Future<Response<IapValidateResponse>> iapValidatePost({
    required IapValidateRequest iapValidateRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _parent.called = true;
    _parent.onValidate(iapValidateRequest);
    return Response<IapValidateResponse>(
      data: IapValidateResponse((b) {
        b.valid = true;
        b.productId = iapValidateRequest.productId;
        b.transactionId = iapValidateRequest.transactionId;
        b.environment = IapValidateResponseEnvironmentEnum.sandbox;
      }),
      requestOptions: RequestOptions(path: '/iap/validate'),
      statusCode: 200,
    );
  }
}

void main() {
  test(
    'validatePurchase returns null when BFF validation flag is off',
    () async {
      final service = IapValidationService(
        tokenProvider: () async => 'token',
        clientFactory: (_) => throw StateError('should not build client'),
      );

      final result = await service.validatePurchase(
        fakePurchase(
          productId: 'chat_mensual_2023_01',
          status: PurchaseStatus.purchased,
        ),
        platformOverride: 'apple',
      );

      expect(result, isNull);
    },
  );

  test(
    'validatePurchase builds Apple subscription request when flag is on',
    () async {
      IapValidateRequest? captured;
      final recording = _RecordingClient((req) => captured = req);

      final service = IapValidationService(
        enabled: true,
        tokenProvider: () async => 'session-jwt',
        clientFactory: (_) => recording,
      );

      final purchase = fakePurchase(
        productId: 'chat_mensual_2023_01',
        status: PurchaseStatus.purchased,
      );

      final result = await service.validatePurchase(
        purchase,
        platformOverride: 'apple',
      );

      expect(recording.called, isTrue);
      expect(result, isNotNull);
      expect(result!.valid, isTrue);
      expect(captured, isNotNull);
      expect(captured!.platform, IapValidateRequestPlatformEnum.apple);
      expect(captured!.productId, 'chat_mensual_2023_01');
      expect(captured!.receiptData, 'server');
      expect(captured!.subscription, isTrue);
    },
  );
}
