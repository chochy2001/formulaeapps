// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthTokenRequestPlatformEnum _$authTokenRequestPlatformEnum_web =
    const AuthTokenRequestPlatformEnum._('web');
const AuthTokenRequestPlatformEnum _$authTokenRequestPlatformEnum_android =
    const AuthTokenRequestPlatformEnum._('android');
const AuthTokenRequestPlatformEnum _$authTokenRequestPlatformEnum_ios =
    const AuthTokenRequestPlatformEnum._('ios');
const AuthTokenRequestPlatformEnum _$authTokenRequestPlatformEnum_macos =
    const AuthTokenRequestPlatformEnum._('macos');

AuthTokenRequestPlatformEnum _$authTokenRequestPlatformEnumValueOf(
    String name) {
  switch (name) {
    case 'web':
      return _$authTokenRequestPlatformEnum_web;
    case 'android':
      return _$authTokenRequestPlatformEnum_android;
    case 'ios':
      return _$authTokenRequestPlatformEnum_ios;
    case 'macos':
      return _$authTokenRequestPlatformEnum_macos;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthTokenRequestPlatformEnum>
    _$authTokenRequestPlatformEnumValues =
    BuiltSet<AuthTokenRequestPlatformEnum>(const <AuthTokenRequestPlatformEnum>[
  _$authTokenRequestPlatformEnum_web,
  _$authTokenRequestPlatformEnum_android,
  _$authTokenRequestPlatformEnum_ios,
  _$authTokenRequestPlatformEnum_macos,
]);

Serializer<AuthTokenRequestPlatformEnum>
    _$authTokenRequestPlatformEnumSerializer =
    _$AuthTokenRequestPlatformEnumSerializer();

class _$AuthTokenRequestPlatformEnumSerializer
    implements PrimitiveSerializer<AuthTokenRequestPlatformEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'web': 'web',
    'android': 'android',
    'ios': 'ios',
    'macos': 'macos',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'web': 'web',
    'android': 'android',
    'ios': 'ios',
    'macos': 'macos',
  };

  @override
  final Iterable<Type> types = const <Type>[AuthTokenRequestPlatformEnum];
  @override
  final String wireName = 'AuthTokenRequestPlatformEnum';

  @override
  Object serialize(Serializers serializers, AuthTokenRequestPlatformEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AuthTokenRequestPlatformEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AuthTokenRequestPlatformEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AuthTokenRequest extends AuthTokenRequest {
  @override
  final String clientId;
  @override
  final String clientProof;
  @override
  final String buildNonce;
  @override
  final AuthTokenRequestPlatformEnum platform;
  @override
  final String appVersion;

  factory _$AuthTokenRequest(
          [void Function(AuthTokenRequestBuilder)? updates]) =>
      (AuthTokenRequestBuilder()..update(updates))._build();

  _$AuthTokenRequest._(
      {required this.clientId,
      required this.clientProof,
      required this.buildNonce,
      required this.platform,
      required this.appVersion})
      : super._();
  @override
  AuthTokenRequest rebuild(void Function(AuthTokenRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthTokenRequestBuilder toBuilder() =>
      AuthTokenRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthTokenRequest &&
        clientId == other.clientId &&
        clientProof == other.clientProof &&
        buildNonce == other.buildNonce &&
        platform == other.platform &&
        appVersion == other.appVersion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, clientProof.hashCode);
    _$hash = $jc(_$hash, buildNonce.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, appVersion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthTokenRequest')
          ..add('clientId', clientId)
          ..add('clientProof', clientProof)
          ..add('buildNonce', buildNonce)
          ..add('platform', platform)
          ..add('appVersion', appVersion))
        .toString();
  }
}

class AuthTokenRequestBuilder
    implements Builder<AuthTokenRequest, AuthTokenRequestBuilder> {
  _$AuthTokenRequest? _$v;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _clientProof;
  String? get clientProof => _$this._clientProof;
  set clientProof(String? clientProof) => _$this._clientProof = clientProof;

  String? _buildNonce;
  String? get buildNonce => _$this._buildNonce;
  set buildNonce(String? buildNonce) => _$this._buildNonce = buildNonce;

  AuthTokenRequestPlatformEnum? _platform;
  AuthTokenRequestPlatformEnum? get platform => _$this._platform;
  set platform(AuthTokenRequestPlatformEnum? platform) =>
      _$this._platform = platform;

  String? _appVersion;
  String? get appVersion => _$this._appVersion;
  set appVersion(String? appVersion) => _$this._appVersion = appVersion;

  AuthTokenRequestBuilder() {
    AuthTokenRequest._defaults(this);
  }

  AuthTokenRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientId = $v.clientId;
      _clientProof = $v.clientProof;
      _buildNonce = $v.buildNonce;
      _platform = $v.platform;
      _appVersion = $v.appVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthTokenRequest other) {
    _$v = other as _$AuthTokenRequest;
  }

  @override
  void update(void Function(AuthTokenRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthTokenRequest build() => _build();

  _$AuthTokenRequest _build() {
    final _$result = _$v ??
        _$AuthTokenRequest._(
          clientId: BuiltValueNullFieldError.checkNotNull(
              clientId, r'AuthTokenRequest', 'clientId'),
          clientProof: BuiltValueNullFieldError.checkNotNull(
              clientProof, r'AuthTokenRequest', 'clientProof'),
          buildNonce: BuiltValueNullFieldError.checkNotNull(
              buildNonce, r'AuthTokenRequest', 'buildNonce'),
          platform: BuiltValueNullFieldError.checkNotNull(
              platform, r'AuthTokenRequest', 'platform'),
          appVersion: BuiltValueNullFieldError.checkNotNull(
              appVersion, r'AuthTokenRequest', 'appVersion'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
