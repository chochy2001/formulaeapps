// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_o_auth_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountOAuthRequestProviderEnum _$accountOAuthRequestProviderEnum_google =
    const AccountOAuthRequestProviderEnum._('google');
const AccountOAuthRequestProviderEnum _$accountOAuthRequestProviderEnum_apple =
    const AccountOAuthRequestProviderEnum._('apple');

AccountOAuthRequestProviderEnum _$accountOAuthRequestProviderEnumValueOf(
    String name) {
  switch (name) {
    case 'google':
      return _$accountOAuthRequestProviderEnum_google;
    case 'apple':
      return _$accountOAuthRequestProviderEnum_apple;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccountOAuthRequestProviderEnum>
    _$accountOAuthRequestProviderEnumValues = BuiltSet<
        AccountOAuthRequestProviderEnum>(const <AccountOAuthRequestProviderEnum>[
  _$accountOAuthRequestProviderEnum_google,
  _$accountOAuthRequestProviderEnum_apple,
]);

const AccountOAuthRequestPlatformEnum _$accountOAuthRequestPlatformEnum_web =
    const AccountOAuthRequestPlatformEnum._('web');
const AccountOAuthRequestPlatformEnum
    _$accountOAuthRequestPlatformEnum_android =
    const AccountOAuthRequestPlatformEnum._('android');
const AccountOAuthRequestPlatformEnum _$accountOAuthRequestPlatformEnum_ios =
    const AccountOAuthRequestPlatformEnum._('ios');
const AccountOAuthRequestPlatformEnum _$accountOAuthRequestPlatformEnum_macos =
    const AccountOAuthRequestPlatformEnum._('macos');

AccountOAuthRequestPlatformEnum _$accountOAuthRequestPlatformEnumValueOf(
    String name) {
  switch (name) {
    case 'web':
      return _$accountOAuthRequestPlatformEnum_web;
    case 'android':
      return _$accountOAuthRequestPlatformEnum_android;
    case 'ios':
      return _$accountOAuthRequestPlatformEnum_ios;
    case 'macos':
      return _$accountOAuthRequestPlatformEnum_macos;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccountOAuthRequestPlatformEnum>
    _$accountOAuthRequestPlatformEnumValues = BuiltSet<
        AccountOAuthRequestPlatformEnum>(const <AccountOAuthRequestPlatformEnum>[
  _$accountOAuthRequestPlatformEnum_web,
  _$accountOAuthRequestPlatformEnum_android,
  _$accountOAuthRequestPlatformEnum_ios,
  _$accountOAuthRequestPlatformEnum_macos,
]);

Serializer<AccountOAuthRequestProviderEnum>
    _$accountOAuthRequestProviderEnumSerializer =
    _$AccountOAuthRequestProviderEnumSerializer();
Serializer<AccountOAuthRequestPlatformEnum>
    _$accountOAuthRequestPlatformEnumSerializer =
    _$AccountOAuthRequestPlatformEnumSerializer();

class _$AccountOAuthRequestProviderEnumSerializer
    implements PrimitiveSerializer<AccountOAuthRequestProviderEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'google': 'google',
    'apple': 'apple',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'google': 'google',
    'apple': 'apple',
  };

  @override
  final Iterable<Type> types = const <Type>[AccountOAuthRequestProviderEnum];
  @override
  final String wireName = 'AccountOAuthRequestProviderEnum';

  @override
  Object serialize(
          Serializers serializers, AccountOAuthRequestProviderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AccountOAuthRequestProviderEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AccountOAuthRequestProviderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AccountOAuthRequestPlatformEnumSerializer
    implements PrimitiveSerializer<AccountOAuthRequestPlatformEnum> {
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
  final Iterable<Type> types = const <Type>[AccountOAuthRequestPlatformEnum];
  @override
  final String wireName = 'AccountOAuthRequestPlatformEnum';

  @override
  Object serialize(
          Serializers serializers, AccountOAuthRequestPlatformEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AccountOAuthRequestPlatformEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AccountOAuthRequestPlatformEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AccountOAuthRequest extends AccountOAuthRequest {
  @override
  final AccountOAuthRequestProviderEnum provider;
  @override
  final String idToken;
  @override
  final AccountOAuthRequestPlatformEnum? platform;
  @override
  final String? appVersion;

  factory _$AccountOAuthRequest(
          [void Function(AccountOAuthRequestBuilder)? updates]) =>
      (AccountOAuthRequestBuilder()..update(updates))._build();

  _$AccountOAuthRequest._(
      {required this.provider,
      required this.idToken,
      this.platform,
      this.appVersion})
      : super._();
  @override
  AccountOAuthRequest rebuild(
          void Function(AccountOAuthRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountOAuthRequestBuilder toBuilder() =>
      AccountOAuthRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountOAuthRequest &&
        provider == other.provider &&
        idToken == other.idToken &&
        platform == other.platform &&
        appVersion == other.appVersion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, idToken.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, appVersion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountOAuthRequest')
          ..add('provider', provider)
          ..add('idToken', idToken)
          ..add('platform', platform)
          ..add('appVersion', appVersion))
        .toString();
  }
}

class AccountOAuthRequestBuilder
    implements Builder<AccountOAuthRequest, AccountOAuthRequestBuilder> {
  _$AccountOAuthRequest? _$v;

  AccountOAuthRequestProviderEnum? _provider;
  AccountOAuthRequestProviderEnum? get provider => _$this._provider;
  set provider(AccountOAuthRequestProviderEnum? provider) =>
      _$this._provider = provider;

  String? _idToken;
  String? get idToken => _$this._idToken;
  set idToken(String? idToken) => _$this._idToken = idToken;

  AccountOAuthRequestPlatformEnum? _platform;
  AccountOAuthRequestPlatformEnum? get platform => _$this._platform;
  set platform(AccountOAuthRequestPlatformEnum? platform) =>
      _$this._platform = platform;

  String? _appVersion;
  String? get appVersion => _$this._appVersion;
  set appVersion(String? appVersion) => _$this._appVersion = appVersion;

  AccountOAuthRequestBuilder() {
    AccountOAuthRequest._defaults(this);
  }

  AccountOAuthRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _provider = $v.provider;
      _idToken = $v.idToken;
      _platform = $v.platform;
      _appVersion = $v.appVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountOAuthRequest other) {
    _$v = other as _$AccountOAuthRequest;
  }

  @override
  void update(void Function(AccountOAuthRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountOAuthRequest build() => _build();

  _$AccountOAuthRequest _build() {
    final _$result = _$v ??
        _$AccountOAuthRequest._(
          provider: BuiltValueNullFieldError.checkNotNull(
              provider, r'AccountOAuthRequest', 'provider'),
          idToken: BuiltValueNullFieldError.checkNotNull(
              idToken, r'AccountOAuthRequest', 'idToken'),
          platform: platform,
          appVersion: appVersion,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
