// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_auth_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountAuthResponse extends AccountAuthResponse {
  @override
  final String token;
  @override
  final DateTime expiresAt;
  @override
  final String userId;

  factory _$AccountAuthResponse(
          [void Function(AccountAuthResponseBuilder)? updates]) =>
      (AccountAuthResponseBuilder()..update(updates))._build();

  _$AccountAuthResponse._(
      {required this.token, required this.expiresAt, required this.userId})
      : super._();
  @override
  AccountAuthResponse rebuild(
          void Function(AccountAuthResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountAuthResponseBuilder toBuilder() =>
      AccountAuthResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountAuthResponse &&
        token == other.token &&
        expiresAt == other.expiresAt &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountAuthResponse')
          ..add('token', token)
          ..add('expiresAt', expiresAt)
          ..add('userId', userId))
        .toString();
  }
}

class AccountAuthResponseBuilder
    implements Builder<AccountAuthResponse, AccountAuthResponseBuilder> {
  _$AccountAuthResponse? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  AccountAuthResponseBuilder() {
    AccountAuthResponse._defaults(this);
  }

  AccountAuthResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _expiresAt = $v.expiresAt;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountAuthResponse other) {
    _$v = other as _$AccountAuthResponse;
  }

  @override
  void update(void Function(AccountAuthResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountAuthResponse build() => _build();

  _$AccountAuthResponse _build() {
    final _$result = _$v ??
        _$AccountAuthResponse._(
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'AccountAuthResponse', 'token'),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'AccountAuthResponse', 'expiresAt'),
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'AccountAuthResponse', 'userId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
