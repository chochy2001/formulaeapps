// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iap_validate_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const IapValidateRequestPlatformEnum _$iapValidateRequestPlatformEnum_apple =
    const IapValidateRequestPlatformEnum._('apple');
const IapValidateRequestPlatformEnum _$iapValidateRequestPlatformEnum_google =
    const IapValidateRequestPlatformEnum._('google');

IapValidateRequestPlatformEnum _$iapValidateRequestPlatformEnumValueOf(
    String name) {
  switch (name) {
    case 'apple':
      return _$iapValidateRequestPlatformEnum_apple;
    case 'google':
      return _$iapValidateRequestPlatformEnum_google;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<IapValidateRequestPlatformEnum>
    _$iapValidateRequestPlatformEnumValues = BuiltSet<
        IapValidateRequestPlatformEnum>(const <IapValidateRequestPlatformEnum>[
  _$iapValidateRequestPlatformEnum_apple,
  _$iapValidateRequestPlatformEnum_google,
]);

Serializer<IapValidateRequestPlatformEnum>
    _$iapValidateRequestPlatformEnumSerializer =
    _$IapValidateRequestPlatformEnumSerializer();

class _$IapValidateRequestPlatformEnumSerializer
    implements PrimitiveSerializer<IapValidateRequestPlatformEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'apple': 'apple',
    'google': 'google',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'apple': 'apple',
    'google': 'google',
  };

  @override
  final Iterable<Type> types = const <Type>[IapValidateRequestPlatformEnum];
  @override
  final String wireName = 'IapValidateRequestPlatformEnum';

  @override
  Object serialize(
          Serializers serializers, IapValidateRequestPlatformEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  IapValidateRequestPlatformEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      IapValidateRequestPlatformEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$IapValidateRequest extends IapValidateRequest {
  @override
  final IapValidateRequestPlatformEnum platform;
  @override
  final String productId;
  @override
  final String transactionId;
  @override
  final String receiptData;
  @override
  final bool subscription;

  factory _$IapValidateRequest(
          [void Function(IapValidateRequestBuilder)? updates]) =>
      (IapValidateRequestBuilder()..update(updates))._build();

  _$IapValidateRequest._(
      {required this.platform,
      required this.productId,
      required this.transactionId,
      required this.receiptData,
      required this.subscription})
      : super._();
  @override
  IapValidateRequest rebuild(
          void Function(IapValidateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IapValidateRequestBuilder toBuilder() =>
      IapValidateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IapValidateRequest &&
        platform == other.platform &&
        productId == other.productId &&
        transactionId == other.transactionId &&
        receiptData == other.receiptData &&
        subscription == other.subscription;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, receiptData.hashCode);
    _$hash = $jc(_$hash, subscription.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IapValidateRequest')
          ..add('platform', platform)
          ..add('productId', productId)
          ..add('transactionId', transactionId)
          ..add('receiptData', receiptData)
          ..add('subscription', subscription))
        .toString();
  }
}

class IapValidateRequestBuilder
    implements Builder<IapValidateRequest, IapValidateRequestBuilder> {
  _$IapValidateRequest? _$v;

  IapValidateRequestPlatformEnum? _platform;
  IapValidateRequestPlatformEnum? get platform => _$this._platform;
  set platform(IapValidateRequestPlatformEnum? platform) =>
      _$this._platform = platform;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  String? _receiptData;
  String? get receiptData => _$this._receiptData;
  set receiptData(String? receiptData) => _$this._receiptData = receiptData;

  bool? _subscription;
  bool? get subscription => _$this._subscription;
  set subscription(bool? subscription) => _$this._subscription = subscription;

  IapValidateRequestBuilder() {
    IapValidateRequest._defaults(this);
  }

  IapValidateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _platform = $v.platform;
      _productId = $v.productId;
      _transactionId = $v.transactionId;
      _receiptData = $v.receiptData;
      _subscription = $v.subscription;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IapValidateRequest other) {
    _$v = other as _$IapValidateRequest;
  }

  @override
  void update(void Function(IapValidateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IapValidateRequest build() => _build();

  _$IapValidateRequest _build() {
    final _$result = _$v ??
        _$IapValidateRequest._(
          platform: BuiltValueNullFieldError.checkNotNull(
              platform, r'IapValidateRequest', 'platform'),
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'IapValidateRequest', 'productId'),
          transactionId: BuiltValueNullFieldError.checkNotNull(
              transactionId, r'IapValidateRequest', 'transactionId'),
          receiptData: BuiltValueNullFieldError.checkNotNull(
              receiptData, r'IapValidateRequest', 'receiptData'),
          subscription: BuiltValueNullFieldError.checkNotNull(
              subscription, r'IapValidateRequest', 'subscription'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
