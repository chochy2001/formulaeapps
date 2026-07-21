// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthTokenResponse extends AuthTokenResponse {
  @override
  final String token;
  @override
  final DateTime expiresAt;
  @override
  final DateTime refreshAfter;
  @override
  final String promptsVersion;

  factory _$AuthTokenResponse([
    void Function(AuthTokenResponseBuilder)? updates,
  ]) => (AuthTokenResponseBuilder()..update(updates))._build();

  _$AuthTokenResponse._({
    required this.token,
    required this.expiresAt,
    required this.refreshAfter,
    required this.promptsVersion,
  }) : super._();
  @override
  AuthTokenResponse rebuild(void Function(AuthTokenResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthTokenResponseBuilder toBuilder() =>
      AuthTokenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthTokenResponse &&
        token == other.token &&
        expiresAt == other.expiresAt &&
        refreshAfter == other.refreshAfter &&
        promptsVersion == other.promptsVersion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, refreshAfter.hashCode);
    _$hash = $jc(_$hash, promptsVersion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthTokenResponse')
          ..add('token', token)
          ..add('expiresAt', expiresAt)
          ..add('refreshAfter', refreshAfter)
          ..add('promptsVersion', promptsVersion))
        .toString();
  }
}

class AuthTokenResponseBuilder
    implements Builder<AuthTokenResponse, AuthTokenResponseBuilder> {
  _$AuthTokenResponse? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  DateTime? _refreshAfter;
  DateTime? get refreshAfter => _$this._refreshAfter;
  set refreshAfter(DateTime? refreshAfter) =>
      _$this._refreshAfter = refreshAfter;

  String? _promptsVersion;
  String? get promptsVersion => _$this._promptsVersion;
  set promptsVersion(String? promptsVersion) =>
      _$this._promptsVersion = promptsVersion;

  AuthTokenResponseBuilder() {
    AuthTokenResponse._defaults(this);
  }

  AuthTokenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _expiresAt = $v.expiresAt;
      _refreshAfter = $v.refreshAfter;
      _promptsVersion = $v.promptsVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthTokenResponse other) {
    _$v = other as _$AuthTokenResponse;
  }

  @override
  void update(void Function(AuthTokenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthTokenResponse build() => _build();

  _$AuthTokenResponse _build() {
    final _$result =
        _$v ??
        _$AuthTokenResponse._(
          token: BuiltValueNullFieldError.checkNotNull(
            token,
            r'AuthTokenResponse',
            'token',
          ),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
            expiresAt,
            r'AuthTokenResponse',
            'expiresAt',
          ),
          refreshAfter: BuiltValueNullFieldError.checkNotNull(
            refreshAfter,
            r'AuthTokenResponse',
            'refreshAfter',
          ),
          promptsVersion: BuiltValueNullFieldError.checkNotNull(
            promptsVersion,
            r'AuthTokenResponse',
            'promptsVersion',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
