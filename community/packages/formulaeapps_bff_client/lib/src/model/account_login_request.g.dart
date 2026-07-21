// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountLoginRequestPlatformEnum _$accountLoginRequestPlatformEnum_web =
    const AccountLoginRequestPlatformEnum._('web');
const AccountLoginRequestPlatformEnum
_$accountLoginRequestPlatformEnum_android =
    const AccountLoginRequestPlatformEnum._('android');
const AccountLoginRequestPlatformEnum _$accountLoginRequestPlatformEnum_ios =
    const AccountLoginRequestPlatformEnum._('ios');
const AccountLoginRequestPlatformEnum _$accountLoginRequestPlatformEnum_macos =
    const AccountLoginRequestPlatformEnum._('macos');

AccountLoginRequestPlatformEnum _$accountLoginRequestPlatformEnumValueOf(
  String name,
) {
  switch (name) {
    case 'web':
      return _$accountLoginRequestPlatformEnum_web;
    case 'android':
      return _$accountLoginRequestPlatformEnum_android;
    case 'ios':
      return _$accountLoginRequestPlatformEnum_ios;
    case 'macos':
      return _$accountLoginRequestPlatformEnum_macos;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccountLoginRequestPlatformEnum>
_$accountLoginRequestPlatformEnumValues =
    BuiltSet<AccountLoginRequestPlatformEnum>(
      const <AccountLoginRequestPlatformEnum>[
        _$accountLoginRequestPlatformEnum_web,
        _$accountLoginRequestPlatformEnum_android,
        _$accountLoginRequestPlatformEnum_ios,
        _$accountLoginRequestPlatformEnum_macos,
      ],
    );

Serializer<AccountLoginRequestPlatformEnum>
_$accountLoginRequestPlatformEnumSerializer =
    _$AccountLoginRequestPlatformEnumSerializer();

class _$AccountLoginRequestPlatformEnumSerializer
    implements PrimitiveSerializer<AccountLoginRequestPlatformEnum> {
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
  final Iterable<Type> types = const <Type>[AccountLoginRequestPlatformEnum];
  @override
  final String wireName = 'AccountLoginRequestPlatformEnum';

  @override
  Object serialize(
    Serializers serializers,
    AccountLoginRequestPlatformEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AccountLoginRequestPlatformEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AccountLoginRequestPlatformEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AccountLoginRequest extends AccountLoginRequest {
  @override
  final String email;
  @override
  final String password;
  @override
  final AccountLoginRequestPlatformEnum? platform;
  @override
  final String? appVersion;

  factory _$AccountLoginRequest([
    void Function(AccountLoginRequestBuilder)? updates,
  ]) => (AccountLoginRequestBuilder()..update(updates))._build();

  _$AccountLoginRequest._({
    required this.email,
    required this.password,
    this.platform,
    this.appVersion,
  }) : super._();
  @override
  AccountLoginRequest rebuild(
    void Function(AccountLoginRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountLoginRequestBuilder toBuilder() =>
      AccountLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountLoginRequest &&
        email == other.email &&
        password == other.password &&
        platform == other.platform &&
        appVersion == other.appVersion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, appVersion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountLoginRequest')
          ..add('email', email)
          ..add('password', password)
          ..add('platform', platform)
          ..add('appVersion', appVersion))
        .toString();
  }
}

class AccountLoginRequestBuilder
    implements Builder<AccountLoginRequest, AccountLoginRequestBuilder> {
  _$AccountLoginRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  AccountLoginRequestPlatformEnum? _platform;
  AccountLoginRequestPlatformEnum? get platform => _$this._platform;
  set platform(AccountLoginRequestPlatformEnum? platform) =>
      _$this._platform = platform;

  String? _appVersion;
  String? get appVersion => _$this._appVersion;
  set appVersion(String? appVersion) => _$this._appVersion = appVersion;

  AccountLoginRequestBuilder() {
    AccountLoginRequest._defaults(this);
  }

  AccountLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _platform = $v.platform;
      _appVersion = $v.appVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountLoginRequest other) {
    _$v = other as _$AccountLoginRequest;
  }

  @override
  void update(void Function(AccountLoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountLoginRequest build() => _build();

  _$AccountLoginRequest _build() {
    final _$result =
        _$v ??
        _$AccountLoginRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'AccountLoginRequest',
            'email',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'AccountLoginRequest',
            'password',
          ),
          platform: platform,
          appVersion: appVersion,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
