// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_source.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EntitlementSourcePaymentSourceEnum
_$entitlementSourcePaymentSourceEnum_appStore =
    const EntitlementSourcePaymentSourceEnum._('appStore');
const EntitlementSourcePaymentSourceEnum
_$entitlementSourcePaymentSourceEnum_playStore =
    const EntitlementSourcePaymentSourceEnum._('playStore');

EntitlementSourcePaymentSourceEnum _$entitlementSourcePaymentSourceEnumValueOf(
  String name,
) {
  switch (name) {
    case 'appStore':
      return _$entitlementSourcePaymentSourceEnum_appStore;
    case 'playStore':
      return _$entitlementSourcePaymentSourceEnum_playStore;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EntitlementSourcePaymentSourceEnum>
_$entitlementSourcePaymentSourceEnumValues =
    BuiltSet<EntitlementSourcePaymentSourceEnum>(
      const <EntitlementSourcePaymentSourceEnum>[
        _$entitlementSourcePaymentSourceEnum_appStore,
        _$entitlementSourcePaymentSourceEnum_playStore,
      ],
    );

Serializer<EntitlementSourcePaymentSourceEnum>
_$entitlementSourcePaymentSourceEnumSerializer =
    _$EntitlementSourcePaymentSourceEnumSerializer();

class _$EntitlementSourcePaymentSourceEnumSerializer
    implements PrimitiveSerializer<EntitlementSourcePaymentSourceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'appStore': 'app_store',
    'playStore': 'play_store',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'app_store': 'appStore',
    'play_store': 'playStore',
  };

  @override
  final Iterable<Type> types = const <Type>[EntitlementSourcePaymentSourceEnum];
  @override
  final String wireName = 'EntitlementSourcePaymentSourceEnum';

  @override
  Object serialize(
    Serializers serializers,
    EntitlementSourcePaymentSourceEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  EntitlementSourcePaymentSourceEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => EntitlementSourcePaymentSourceEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$EntitlementSource extends EntitlementSource {
  @override
  final EntitlementSourcePaymentSourceEnum paymentSource;
  @override
  final String productId;
  @override
  final DateTime grantedAt;

  factory _$EntitlementSource([
    void Function(EntitlementSourceBuilder)? updates,
  ]) => (EntitlementSourceBuilder()..update(updates))._build();

  _$EntitlementSource._({
    required this.paymentSource,
    required this.productId,
    required this.grantedAt,
  }) : super._();
  @override
  EntitlementSource rebuild(void Function(EntitlementSourceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EntitlementSourceBuilder toBuilder() =>
      EntitlementSourceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EntitlementSource &&
        paymentSource == other.paymentSource &&
        productId == other.productId &&
        grantedAt == other.grantedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, paymentSource.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, grantedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EntitlementSource')
          ..add('paymentSource', paymentSource)
          ..add('productId', productId)
          ..add('grantedAt', grantedAt))
        .toString();
  }
}

class EntitlementSourceBuilder
    implements Builder<EntitlementSource, EntitlementSourceBuilder> {
  _$EntitlementSource? _$v;

  EntitlementSourcePaymentSourceEnum? _paymentSource;
  EntitlementSourcePaymentSourceEnum? get paymentSource =>
      _$this._paymentSource;
  set paymentSource(EntitlementSourcePaymentSourceEnum? paymentSource) =>
      _$this._paymentSource = paymentSource;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  DateTime? _grantedAt;
  DateTime? get grantedAt => _$this._grantedAt;
  set grantedAt(DateTime? grantedAt) => _$this._grantedAt = grantedAt;

  EntitlementSourceBuilder() {
    EntitlementSource._defaults(this);
  }

  EntitlementSourceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _paymentSource = $v.paymentSource;
      _productId = $v.productId;
      _grantedAt = $v.grantedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EntitlementSource other) {
    _$v = other as _$EntitlementSource;
  }

  @override
  void update(void Function(EntitlementSourceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EntitlementSource build() => _build();

  _$EntitlementSource _build() {
    final _$result =
        _$v ??
        _$EntitlementSource._(
          paymentSource: BuiltValueNullFieldError.checkNotNull(
            paymentSource,
            r'EntitlementSource',
            'paymentSource',
          ),
          productId: BuiltValueNullFieldError.checkNotNull(
            productId,
            r'EntitlementSource',
            'productId',
          ),
          grantedAt: BuiltValueNullFieldError.checkNotNull(
            grantedAt,
            r'EntitlementSource',
            'grantedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
