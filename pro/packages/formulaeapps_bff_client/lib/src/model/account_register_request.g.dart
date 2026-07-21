// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_register_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountRegisterRequestPlatformEnum
_$accountRegisterRequestPlatformEnum_web =
    const AccountRegisterRequestPlatformEnum._('web');
const AccountRegisterRequestPlatformEnum
_$accountRegisterRequestPlatformEnum_android =
    const AccountRegisterRequestPlatformEnum._('android');
const AccountRegisterRequestPlatformEnum
_$accountRegisterRequestPlatformEnum_ios =
    const AccountRegisterRequestPlatformEnum._('ios');
const AccountRegisterRequestPlatformEnum
_$accountRegisterRequestPlatformEnum_macos =
    const AccountRegisterRequestPlatformEnum._('macos');

AccountRegisterRequestPlatformEnum _$accountRegisterRequestPlatformEnumValueOf(
  String name,
) {
  switch (name) {
    case 'web':
      return _$accountRegisterRequestPlatformEnum_web;
    case 'android':
      return _$accountRegisterRequestPlatformEnum_android;
    case 'ios':
      return _$accountRegisterRequestPlatformEnum_ios;
    case 'macos':
      return _$accountRegisterRequestPlatformEnum_macos;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccountRegisterRequestPlatformEnum>
_$accountRegisterRequestPlatformEnumValues =
    BuiltSet<AccountRegisterRequestPlatformEnum>(
      const <AccountRegisterRequestPlatformEnum>[
        _$accountRegisterRequestPlatformEnum_web,
        _$accountRegisterRequestPlatformEnum_android,
        _$accountRegisterRequestPlatformEnum_ios,
        _$accountRegisterRequestPlatformEnum_macos,
      ],
    );

Serializer<AccountRegisterRequestPlatformEnum>
_$accountRegisterRequestPlatformEnumSerializer =
    _$AccountRegisterRequestPlatformEnumSerializer();

class _$AccountRegisterRequestPlatformEnumSerializer
    implements PrimitiveSerializer<AccountRegisterRequestPlatformEnum> {
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
  final Iterable<Type> types = const <Type>[AccountRegisterRequestPlatformEnum];
  @override
  final String wireName = 'AccountRegisterRequestPlatformEnum';

  @override
  Object serialize(
    Serializers serializers,
    AccountRegisterRequestPlatformEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AccountRegisterRequestPlatformEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AccountRegisterRequestPlatformEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AccountRegisterRequest extends AccountRegisterRequest {
  @override
  final String email;
  @override
  final String password;
  @override
  final AccountRegisterRequestPlatformEnum? platform;
  @override
  final String? appVersion;

  factory _$AccountRegisterRequest([
    void Function(AccountRegisterRequestBuilder)? updates,
  ]) => (AccountRegisterRequestBuilder()..update(updates))._build();

  _$AccountRegisterRequest._({
    required this.email,
    required this.password,
    this.platform,
    this.appVersion,
  }) : super._();
  @override
  AccountRegisterRequest rebuild(
    void Function(AccountRegisterRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountRegisterRequestBuilder toBuilder() =>
      AccountRegisterRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountRegisterRequest &&
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
    return (newBuiltValueToStringHelper(r'AccountRegisterRequest')
          ..add('email', email)
          ..add('password', password)
          ..add('platform', platform)
          ..add('appVersion', appVersion))
        .toString();
  }
}

class AccountRegisterRequestBuilder
    implements Builder<AccountRegisterRequest, AccountRegisterRequestBuilder> {
  _$AccountRegisterRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  AccountRegisterRequestPlatformEnum? _platform;
  AccountRegisterRequestPlatformEnum? get platform => _$this._platform;
  set platform(AccountRegisterRequestPlatformEnum? platform) =>
      _$this._platform = platform;

  String? _appVersion;
  String? get appVersion => _$this._appVersion;
  set appVersion(String? appVersion) => _$this._appVersion = appVersion;

  AccountRegisterRequestBuilder() {
    AccountRegisterRequest._defaults(this);
  }

  AccountRegisterRequestBuilder get _$this {
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
  void replace(AccountRegisterRequest other) {
    _$v = other as _$AccountRegisterRequest;
  }

  @override
  void update(void Function(AccountRegisterRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountRegisterRequest build() => _build();

  _$AccountRegisterRequest _build() {
    final _$result =
        _$v ??
        _$AccountRegisterRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'AccountRegisterRequest',
            'email',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'AccountRegisterRequest',
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
