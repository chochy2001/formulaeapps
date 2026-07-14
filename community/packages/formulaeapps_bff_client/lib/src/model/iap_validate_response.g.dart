// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iap_validate_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const IapValidateResponseEnvironmentEnum
    _$iapValidateResponseEnvironmentEnum_sandbox =
    const IapValidateResponseEnvironmentEnum._('sandbox');
const IapValidateResponseEnvironmentEnum
    _$iapValidateResponseEnvironmentEnum_production =
    const IapValidateResponseEnvironmentEnum._('production');

IapValidateResponseEnvironmentEnum _$iapValidateResponseEnvironmentEnumValueOf(
    String name) {
  switch (name) {
    case 'sandbox':
      return _$iapValidateResponseEnvironmentEnum_sandbox;
    case 'production':
      return _$iapValidateResponseEnvironmentEnum_production;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<IapValidateResponseEnvironmentEnum>
    _$iapValidateResponseEnvironmentEnumValues = BuiltSet<
        IapValidateResponseEnvironmentEnum>(const <IapValidateResponseEnvironmentEnum>[
  _$iapValidateResponseEnvironmentEnum_sandbox,
  _$iapValidateResponseEnvironmentEnum_production,
]);

Serializer<IapValidateResponseEnvironmentEnum>
    _$iapValidateResponseEnvironmentEnumSerializer =
    _$IapValidateResponseEnvironmentEnumSerializer();

class _$IapValidateResponseEnvironmentEnumSerializer
    implements PrimitiveSerializer<IapValidateResponseEnvironmentEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'sandbox': 'sandbox',
    'production': 'production',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'sandbox': 'sandbox',
    'production': 'production',
  };

  @override
  final Iterable<Type> types = const <Type>[IapValidateResponseEnvironmentEnum];
  @override
  final String wireName = 'IapValidateResponseEnvironmentEnum';

  @override
  Object serialize(
          Serializers serializers, IapValidateResponseEnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  IapValidateResponseEnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      IapValidateResponseEnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$IapValidateResponse extends IapValidateResponse {
  @override
  final bool valid;
  @override
  final DateTime? expiresAt;
  @override
  final String productId;
  @override
  final String transactionId;
  @override
  final IapValidateResponseEnvironmentEnum environment;
  @override
  final String? providerReason;

  factory _$IapValidateResponse(
          [void Function(IapValidateResponseBuilder)? updates]) =>
      (IapValidateResponseBuilder()..update(updates))._build();

  _$IapValidateResponse._(
      {required this.valid,
      this.expiresAt,
      required this.productId,
      required this.transactionId,
      required this.environment,
      this.providerReason})
      : super._();
  @override
  IapValidateResponse rebuild(
          void Function(IapValidateResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IapValidateResponseBuilder toBuilder() =>
      IapValidateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IapValidateResponse &&
        valid == other.valid &&
        expiresAt == other.expiresAt &&
        productId == other.productId &&
        transactionId == other.transactionId &&
        environment == other.environment &&
        providerReason == other.providerReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, valid.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, providerReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IapValidateResponse')
          ..add('valid', valid)
          ..add('expiresAt', expiresAt)
          ..add('productId', productId)
          ..add('transactionId', transactionId)
          ..add('environment', environment)
          ..add('providerReason', providerReason))
        .toString();
  }
}

class IapValidateResponseBuilder
    implements Builder<IapValidateResponse, IapValidateResponseBuilder> {
  _$IapValidateResponse? _$v;

  bool? _valid;
  bool? get valid => _$this._valid;
  set valid(bool? valid) => _$this._valid = valid;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  IapValidateResponseEnvironmentEnum? _environment;
  IapValidateResponseEnvironmentEnum? get environment => _$this._environment;
  set environment(IapValidateResponseEnvironmentEnum? environment) =>
      _$this._environment = environment;

  String? _providerReason;
  String? get providerReason => _$this._providerReason;
  set providerReason(String? providerReason) =>
      _$this._providerReason = providerReason;

  IapValidateResponseBuilder() {
    IapValidateResponse._defaults(this);
  }

  IapValidateResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _valid = $v.valid;
      _expiresAt = $v.expiresAt;
      _productId = $v.productId;
      _transactionId = $v.transactionId;
      _environment = $v.environment;
      _providerReason = $v.providerReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IapValidateResponse other) {
    _$v = other as _$IapValidateResponse;
  }

  @override
  void update(void Function(IapValidateResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IapValidateResponse build() => _build();

  _$IapValidateResponse _build() {
    final _$result = _$v ??
        _$IapValidateResponse._(
          valid: BuiltValueNullFieldError.checkNotNull(
              valid, r'IapValidateResponse', 'valid'),
          expiresAt: expiresAt,
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'IapValidateResponse', 'productId'),
          transactionId: BuiltValueNullFieldError.checkNotNull(
              transactionId, r'IapValidateResponse', 'transactionId'),
          environment: BuiltValueNullFieldError.checkNotNull(
              environment, r'IapValidateResponse', 'environment'),
          providerReason: providerReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
