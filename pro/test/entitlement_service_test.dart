import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/entitlement_service.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';

class _RecordingClient extends FormulaeappsBffClient {
  _RecordingClient({this.response, this.throwDio = false})
      : super(
          basePathOverride: 'http://test-bff',
          dio: Dio(BaseOptions(baseUrl: 'http://test-bff')),
        );

  final EntitlementResponse? response;
  final bool throwDio;
  bool called = false;

  @override
  EntitlementApi getEntitlementApi() => _RecordingEntitlementApi(this);
}

class _RecordingEntitlementApi extends EntitlementApi {
  _RecordingEntitlementApi(this._parent)
      : super(_parent.dio, standardSerializers);

  final _RecordingClient _parent;

  @override
  Future<Response<EntitlementResponse>> entitlementGet({
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _parent.called = true;
    if (_parent.throwDio) {
      throw DioException(
        requestOptions: RequestOptions(path: '/entitlement'),
        type: DioExceptionType.connectionError,
        message: 'unreachable',
      );
    }
    return Response<EntitlementResponse>(
      data: _parent.response,
      requestOptions: RequestOptions(path: '/entitlement'),
      statusCode: 200,
    );
  }
}

void main() {
  group('EntitlementService', () {
    test('fetchEntitlement returns BFF payload on 200', () async {
      final payload = EntitlementResponse(
        (b) => b
          ..scope = EntitlementResponseScopeEnum.mobile
          ..sources = ListBuilder<EntitlementSource>([
            EntitlementSource(
              (s) => s
                ..paymentSource = EntitlementSourcePaymentSourceEnum.appStore
                ..productId = 'chat_mensual_2023_01'
                ..grantedAt = DateTime.utc(2026, 7, 13),
            ),
          ]),
      );
      final recording = _RecordingClient(response: payload);

      final service = EntitlementService(
        tokenProvider: () async => 'session-jwt',
        clientFactory: (_) => recording,
      );

      final result = await service.fetchEntitlement();

      expect(recording.called, isTrue);
      expect(result, isNotNull);
      expect(result!.scope, EntitlementResponseScopeEnum.mobile);
      expect(result.sources, hasLength(1));
      expect(
        result.sources.first.paymentSource,
        EntitlementSourcePaymentSourceEnum.appStore,
      );
    });

    test('fetchEntitlement returns null on empty token', () async {
      final service = EntitlementService(
        tokenProvider: () async => '',
        clientFactory: (_) => throw StateError('should not build client'),
      );

      expect(await service.fetchEntitlement(), isNull);
    });

    test('fetchEntitlement returns null on DioException (fail-closed)',
        () async {
      final recording = _RecordingClient(throwDio: true);
      final service = EntitlementService(
        tokenProvider: () async => 'session-jwt',
        clientFactory: (_) => recording,
      );

      expect(await service.fetchEntitlement(), isNull);
      expect(recording.called, isTrue);
    });

    test('fetchEntitlement returns empty sources when none granted', () async {
      final payload = EntitlementResponse(
        (b) => b
          ..scope = EntitlementResponseScopeEnum.mobile
          ..sources = ListBuilder<EntitlementSource>(),
      );
      final recording = _RecordingClient(response: payload);
      final service = EntitlementService(
        tokenProvider: () async => 'session-jwt',
        clientFactory: (_) => recording,
      );

      final result = await service.fetchEntitlement();
      expect(result, isNotNull);
      expect(result!.sources, isEmpty);
    });
  });
}
