//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:formulaeapps_bff_client/src/model/chat_usage.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat_response.g.dart';

/// ChatResponse
///
/// Properties:
/// * [message] - Assistant's text.
/// * [modelId] - Echo of the model that produced the response (`provider/model` format).
/// * [usage] 
/// * [conversationId] - Echo of request conversation_id if supplied.
/// * [promptsVersion] 
@BuiltValue()
abstract class ChatResponse implements Built<ChatResponse, ChatResponseBuilder> {
  /// Assistant's text.
  @BuiltValueField(wireName: r'message')
  String get message;

  /// Echo of the model that produced the response (`provider/model` format).
  @BuiltValueField(wireName: r'model_id')
  String get modelId;

  @BuiltValueField(wireName: r'usage')
  ChatUsage get usage;

  /// Echo of request conversation_id if supplied.
  @BuiltValueField(wireName: r'conversation_id')
  String? get conversationId;

  @BuiltValueField(wireName: r'prompts_version')
  String get promptsVersion;

  ChatResponse._();

  factory ChatResponse([void updates(ChatResponseBuilder b)]) = _$ChatResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChatResponse> get serializer => _$ChatResponseSerializer();
}

class _$ChatResponseSerializer implements PrimitiveSerializer<ChatResponse> {
  @override
  final Iterable<Type> types = const [ChatResponse, _$ChatResponse];

  @override
  final String wireName = r'ChatResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChatResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'model_id';
    yield serializers.serialize(
      object.modelId,
      specifiedType: const FullType(String),
    );
    yield r'usage';
    yield serializers.serialize(
      object.usage,
      specifiedType: const FullType(ChatUsage),
    );
    if (object.conversationId != null) {
      yield r'conversation_id';
      yield serializers.serialize(
        object.conversationId,
        specifiedType: const FullType(String),
      );
    }
    yield r'prompts_version';
    yield serializers.serialize(
      object.promptsVersion,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChatResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChatResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'model_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.modelId = valueDes;
          break;
        case r'usage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChatUsage),
          ) as ChatUsage;
          result.usage.replace(valueDes);
          break;
        case r'conversation_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.conversationId = valueDes;
          break;
        case r'prompts_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.promptsVersion = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChatResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

