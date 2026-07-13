// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_register_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountRegisterRequest extends AccountRegisterRequest {
  @override
  final String email;
  @override
  final String password;

  factory _$AccountRegisterRequest(
          [void Function(AccountRegisterRequestBuilder)? updates]) =>
      (AccountRegisterRequestBuilder()..update(updates))._build();

  _$AccountRegisterRequest._({required this.email, required this.password})
      : super._();
  @override
  AccountRegisterRequest rebuild(
          void Function(AccountRegisterRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountRegisterRequestBuilder toBuilder() =>
      AccountRegisterRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountRegisterRequest &&
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
    return (newBuiltValueToStringHelper(r'AccountRegisterRequest')
          ..add('email', email)
          ..add('password', password))
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

  AccountRegisterRequestBuilder() {
    AccountRegisterRequest._defaults(this);
  }

  AccountRegisterRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
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
    final _$result = _$v ??
        _$AccountRegisterRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'AccountRegisterRequest', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'AccountRegisterRequest', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
