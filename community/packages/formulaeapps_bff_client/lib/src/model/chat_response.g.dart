// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatResponse extends ChatResponse {
  @override
  final String message;
  @override
  final String modelId;
  @override
  final ChatUsage usage;
  @override
  final String? conversationId;
  @override
  final String promptsVersion;

  factory _$ChatResponse([void Function(ChatResponseBuilder)? updates]) =>
      (ChatResponseBuilder()..update(updates))._build();

  _$ChatResponse._(
      {required this.message,
      required this.modelId,
      required this.usage,
      this.conversationId,
      required this.promptsVersion})
      : super._();
  @override
  ChatResponse rebuild(void Function(ChatResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatResponseBuilder toBuilder() => ChatResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatResponse &&
        message == other.message &&
        modelId == other.modelId &&
        usage == other.usage &&
        conversationId == other.conversationId &&
        promptsVersion == other.promptsVersion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, modelId.hashCode);
    _$hash = $jc(_$hash, usage.hashCode);
    _$hash = $jc(_$hash, conversationId.hashCode);
    _$hash = $jc(_$hash, promptsVersion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatResponse')
          ..add('message', message)
          ..add('modelId', modelId)
          ..add('usage', usage)
          ..add('conversationId', conversationId)
          ..add('promptsVersion', promptsVersion))
        .toString();
  }
}

class ChatResponseBuilder
    implements Builder<ChatResponse, ChatResponseBuilder> {
  _$ChatResponse? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _modelId;
  String? get modelId => _$this._modelId;
  set modelId(String? modelId) => _$this._modelId = modelId;

  ChatUsageBuilder? _usage;
  ChatUsageBuilder get usage => _$this._usage ??= ChatUsageBuilder();
  set usage(ChatUsageBuilder? usage) => _$this._usage = usage;

  String? _conversationId;
  String? get conversationId => _$this._conversationId;
  set conversationId(String? conversationId) =>
      _$this._conversationId = conversationId;

  String? _promptsVersion;
  String? get promptsVersion => _$this._promptsVersion;
  set promptsVersion(String? promptsVersion) =>
      _$this._promptsVersion = promptsVersion;

  ChatResponseBuilder() {
    ChatResponse._defaults(this);
  }

  ChatResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _modelId = $v.modelId;
      _usage = $v.usage.toBuilder();
      _conversationId = $v.conversationId;
      _promptsVersion = $v.promptsVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatResponse other) {
    _$v = other as _$ChatResponse;
  }

  @override
  void update(void Function(ChatResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatResponse build() => _build();

  _$ChatResponse _build() {
    _$ChatResponse _$result;
    try {
      _$result = _$v ??
          _$ChatResponse._(
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'ChatResponse', 'message'),
            modelId: BuiltValueNullFieldError.checkNotNull(
                modelId, r'ChatResponse', 'modelId'),
            usage: usage.build(),
            conversationId: conversationId,
            promptsVersion: BuiltValueNullFieldError.checkNotNull(
                promptsVersion, r'ChatResponse', 'promptsVersion'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'usage';
        usage.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ChatResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
