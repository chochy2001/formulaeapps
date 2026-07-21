// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_usage.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatUsage extends ChatUsage {
  @override
  final int promptTokens;
  @override
  final int completionTokens;
  @override
  final int totalTokens;

  factory _$ChatUsage([void Function(ChatUsageBuilder)? updates]) =>
      (ChatUsageBuilder()..update(updates))._build();

  _$ChatUsage._({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  }) : super._();
  @override
  ChatUsage rebuild(void Function(ChatUsageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatUsageBuilder toBuilder() => ChatUsageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatUsage &&
        promptTokens == other.promptTokens &&
        completionTokens == other.completionTokens &&
        totalTokens == other.totalTokens;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, promptTokens.hashCode);
    _$hash = $jc(_$hash, completionTokens.hashCode);
    _$hash = $jc(_$hash, totalTokens.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatUsage')
          ..add('promptTokens', promptTokens)
          ..add('completionTokens', completionTokens)
          ..add('totalTokens', totalTokens))
        .toString();
  }
}

class ChatUsageBuilder implements Builder<ChatUsage, ChatUsageBuilder> {
  _$ChatUsage? _$v;

  int? _promptTokens;
  int? get promptTokens => _$this._promptTokens;
  set promptTokens(int? promptTokens) => _$this._promptTokens = promptTokens;

  int? _completionTokens;
  int? get completionTokens => _$this._completionTokens;
  set completionTokens(int? completionTokens) =>
      _$this._completionTokens = completionTokens;

  int? _totalTokens;
  int? get totalTokens => _$this._totalTokens;
  set totalTokens(int? totalTokens) => _$this._totalTokens = totalTokens;

  ChatUsageBuilder() {
    ChatUsage._defaults(this);
  }

  ChatUsageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _promptTokens = $v.promptTokens;
      _completionTokens = $v.completionTokens;
      _totalTokens = $v.totalTokens;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatUsage other) {
    _$v = other as _$ChatUsage;
  }

  @override
  void update(void Function(ChatUsageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatUsage build() => _build();

  _$ChatUsage _build() {
    final _$result =
        _$v ??
        _$ChatUsage._(
          promptTokens: BuiltValueNullFieldError.checkNotNull(
            promptTokens,
            r'ChatUsage',
            'promptTokens',
          ),
          completionTokens: BuiltValueNullFieldError.checkNotNull(
            completionTokens,
            r'ChatUsage',
            'completionTokens',
          ),
          totalTokens: BuiltValueNullFieldError.checkNotNull(
            totalTokens,
            r'ChatUsage',
            'totalTokens',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
