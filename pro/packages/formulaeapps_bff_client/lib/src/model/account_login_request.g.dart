// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountLoginRequest extends AccountLoginRequest {
  @override
  final String email;
  @override
  final String password;

  factory _$AccountLoginRequest(
          [void Function(AccountLoginRequestBuilder)? updates]) =>
      (AccountLoginRequestBuilder()..update(updates))._build();

  _$AccountLoginRequest._({required this.email, required this.password})
      : super._();
  @override
  AccountLoginRequest rebuild(
          void Function(AccountLoginRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountLoginRequestBuilder toBuilder() =>
      AccountLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountLoginRequest &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountLoginRequest')
          ..add('email', email)
          ..add('password', password))
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

  AccountLoginRequestBuilder() {
    AccountLoginRequest._defaults(this);
  }

  AccountLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
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
    final _$result = _$v ??
        _$AccountLoginRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'AccountLoginRequest', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'AccountLoginRequest', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
