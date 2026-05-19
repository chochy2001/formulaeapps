//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat_usage.g.dart';

/// ChatUsage
///
/// Properties:
/// * [promptTokens] 
/// * [completionTokens] 
/// * [totalTokens] 
@BuiltValue()
abstract class ChatUsage implements Built<ChatUsage, ChatUsageBuilder> {
  @BuiltValueField(wireName: r'prompt_tokens')
  int get promptTokens;

  @BuiltValueField(wireName: r'completion_tokens')
  int get completionTokens;

  @BuiltValueField(wireName: r'total_tokens')
  int get totalTokens;

  ChatUsage._();

  factory ChatUsage([void updates(ChatUsageBuilder b)]) = _$ChatUsage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatUsageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChatUsage> get serializer => _$ChatUsageSerializer();
}

class _$ChatUsageSerializer implements PrimitiveSerializer<ChatUsage> {
  @override
  final Iterable<Type> types = const [ChatUsage, _$ChatUsage];

  @override
  final String wireName = r'ChatUsage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChatUsage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'prompt_tokens';
    yield serializers.serialize(
      object.promptTokens,
      specifiedType: const FullType(int),
    );
    yield r'completion_tokens';
    yield serializers.serialize(
      object.completionTokens,
      specifiedType: const FullType(int),
    );
    yield r'total_tokens';
    yield serializers.serialize(
      object.totalTokens,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChatUsage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChatUsageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'prompt_tokens':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.promptTokens = valueDes;
          break;
        case r'completion_tokens':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.completionTokens = valueDes;
          break;
        case r'total_tokens':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalTokens = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChatUsage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatUsageBuilder();
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

