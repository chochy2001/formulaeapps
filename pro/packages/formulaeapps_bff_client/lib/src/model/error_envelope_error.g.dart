// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_envelope_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ErrorEnvelopeError extends ErrorEnvelopeError {
  @override
  final ErrorKind kind;
  @override
  final String message;
  @override
  final String? code;
  @override
  final String requestId;

  factory _$ErrorEnvelopeError([
    void Function(ErrorEnvelopeErrorBuilder)? updates,
  ]) => (ErrorEnvelopeErrorBuilder()..update(updates))._build();

  _$ErrorEnvelopeError._({
    required this.kind,
    required this.message,
    this.code,
    required this.requestId,
  }) : super._();
  @override
  ErrorEnvelopeError rebuild(
    void Function(ErrorEnvelopeErrorBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ErrorEnvelopeErrorBuilder toBuilder() =>
      ErrorEnvelopeErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorEnvelopeError &&
        kind == other.kind &&
        message == other.message &&
        code == other.code &&
        requestId == other.requestId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorEnvelopeError')
          ..add('kind', kind)
          ..add('message', message)
          ..add('code', code)
          ..add('requestId', requestId))
        .toString();
  }
}

class ErrorEnvelopeErrorBuilder
    implements Builder<ErrorEnvelopeError, ErrorEnvelopeErrorBuilder> {
  _$ErrorEnvelopeError? _$v;

  ErrorKind? _kind;
  ErrorKind? get kind => _$this._kind;
  set kind(ErrorKind? kind) => _$this._kind = kind;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  ErrorEnvelopeErrorBuilder() {
    ErrorEnvelopeError._defaults(this);
  }

  ErrorEnvelopeErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _kind = $v.kind;
      _message = $v.message;
      _code = $v.code;
      _requestId = $v.requestId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorEnvelopeError other) {
    _$v = other as _$ErrorEnvelopeError;
  }

  @override
  void update(void Function(ErrorEnvelopeErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorEnvelopeError build() => _build();

  _$ErrorEnvelopeError _build() {
    final _$result =
        _$v ??
        _$ErrorEnvelopeError._(
          kind: BuiltValueNullFieldError.checkNotNull(
            kind,
            r'ErrorEnvelopeError',
            'kind',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ErrorEnvelopeError',
            'message',
          ),
          code: code,
          requestId: BuiltValueNullFieldError.checkNotNull(
            requestId,
            r'ErrorEnvelopeError',
            'requestId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
