// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealthResponse extends HealthResponse {
  @override
  final HealthStatus status;
  @override
  final String version;
  @override
  final String promptsVersion;
  @override
  final num uptimeSeconds;

  factory _$HealthResponse([void Function(HealthResponseBuilder)? updates]) =>
      (HealthResponseBuilder()..update(updates))._build();

  _$HealthResponse._({
    required this.status,
    required this.version,
    required this.promptsVersion,
    required this.uptimeSeconds,
  }) : super._();
  @override
  HealthResponse rebuild(void Function(HealthResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealthResponseBuilder toBuilder() => HealthResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealthResponse &&
        status == other.status &&
        version == other.version &&
        promptsVersion == other.promptsVersion &&
        uptimeSeconds == other.uptimeSeconds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, promptsVersion.hashCode);
    _$hash = $jc(_$hash, uptimeSeconds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HealthResponse')
          ..add('status', status)
          ..add('version', version)
          ..add('promptsVersion', promptsVersion)
          ..add('uptimeSeconds', uptimeSeconds))
        .toString();
  }
}

class HealthResponseBuilder
    implements Builder<HealthResponse, HealthResponseBuilder> {
  _$HealthResponse? _$v;

  HealthStatus? _status;
  HealthStatus? get status => _$this._status;
  set status(HealthStatus? status) => _$this._status = status;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  String? _promptsVersion;
  String? get promptsVersion => _$this._promptsVersion;
  set promptsVersion(String? promptsVersion) =>
      _$this._promptsVersion = promptsVersion;

  num? _uptimeSeconds;
  num? get uptimeSeconds => _$this._uptimeSeconds;
  set uptimeSeconds(num? uptimeSeconds) =>
      _$this._uptimeSeconds = uptimeSeconds;

  HealthResponseBuilder() {
    HealthResponse._defaults(this);
  }

  HealthResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _version = $v.version;
      _promptsVersion = $v.promptsVersion;
      _uptimeSeconds = $v.uptimeSeconds;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthResponse other) {
    _$v = other as _$HealthResponse;
  }

  @override
  void update(void Function(HealthResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HealthResponse build() => _build();

  _$HealthResponse _build() {
    final _$result =
        _$v ??
        _$HealthResponse._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HealthResponse',
            'status',
          ),
          version: BuiltValueNullFieldError.checkNotNull(
            version,
            r'HealthResponse',
            'version',
          ),
          promptsVersion: BuiltValueNullFieldError.checkNotNull(
            promptsVersion,
            r'HealthResponse',
            'promptsVersion',
          ),
          uptimeSeconds: BuiltValueNullFieldError.checkNotNull(
            uptimeSeconds,
            r'HealthResponse',
            'uptimeSeconds',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
