// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EntitlementResponseScopeEnum _$entitlementResponseScopeEnum_mobile =
    const EntitlementResponseScopeEnum._('mobile');

EntitlementResponseScopeEnum _$entitlementResponseScopeEnumValueOf(
    String name) {
  switch (name) {
    case 'mobile':
      return _$entitlementResponseScopeEnum_mobile;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EntitlementResponseScopeEnum>
    _$entitlementResponseScopeEnumValues =
    BuiltSet<EntitlementResponseScopeEnum>(const <EntitlementResponseScopeEnum>[
  _$entitlementResponseScopeEnum_mobile,
]);

Serializer<EntitlementResponseScopeEnum>
    _$entitlementResponseScopeEnumSerializer =
    _$EntitlementResponseScopeEnumSerializer();

class _$EntitlementResponseScopeEnumSerializer
    implements PrimitiveSerializer<EntitlementResponseScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mobile': 'mobile',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mobile': 'mobile',
  };

  @override
  final Iterable<Type> types = const <Type>[EntitlementResponseScopeEnum];
  @override
  final String wireName = 'EntitlementResponseScopeEnum';

  @override
  Object serialize(Serializers serializers, EntitlementResponseScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EntitlementResponseScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EntitlementResponseScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$EntitlementResponse extends EntitlementResponse {
  @override
  final EntitlementResponseScopeEnum scope;
  @override
  final BuiltList<EntitlementSource> sources;

  factory _$EntitlementResponse(
          [void Function(EntitlementResponseBuilder)? updates]) =>
      (EntitlementResponseBuilder()..update(updates))._build();

  _$EntitlementResponse._({required this.scope, required this.sources})
      : super._();
  @override
  EntitlementResponse rebuild(
          void Function(EntitlementResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EntitlementResponseBuilder toBuilder() =>
      EntitlementResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EntitlementResponse &&
        scope == other.scope &&
        sources == other.sources;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, sources.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EntitlementResponse')
          ..add('scope', scope)
          ..add('sources', sources))
        .toString();
  }
}

class EntitlementResponseBuilder
    implements Builder<EntitlementResponse, EntitlementResponseBuilder> {
  _$EntitlementResponse? _$v;

  EntitlementResponseScopeEnum? _scope;
  EntitlementResponseScopeEnum? get scope => _$this._scope;
  set scope(EntitlementResponseScopeEnum? scope) => _$this._scope = scope;

  ListBuilder<EntitlementSource>? _sources;
  ListBuilder<EntitlementSource> get sources =>
      _$this._sources ??= ListBuilder<EntitlementSource>();
  set sources(ListBuilder<EntitlementSource>? sources) =>
      _$this._sources = sources;

  EntitlementResponseBuilder() {
    EntitlementResponse._defaults(this);
  }

  EntitlementResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _scope = $v.scope;
      _sources = $v.sources.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EntitlementResponse other) {
    _$v = other as _$EntitlementResponse;
  }

  @override
  void update(void Function(EntitlementResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EntitlementResponse build() => _build();

  _$EntitlementResponse _build() {
    _$EntitlementResponse _$result;
    try {
      _$result = _$v ??
          _$EntitlementResponse._(
            scope: BuiltValueNullFieldError.checkNotNull(
                scope, r'EntitlementResponse', 'scope'),
            sources: sources.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sources';
        sources.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'EntitlementResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
