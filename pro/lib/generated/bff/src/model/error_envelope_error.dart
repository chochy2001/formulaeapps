//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:formulaeapps_bff_client/src/model/error_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'error_envelope_error.g.dart';

/// ErrorEnvelopeError
///
/// Properties:
/// * [kind] 
/// * [message] - Short user-presentable message in ES (default) or _en. No secrets.
/// * [code] - Stable error code for client branching.
/// * [requestId] - Matches the request_id in BFF logs.
@BuiltValue()
abstract class ErrorEnvelopeError implements Built<ErrorEnvelopeError, ErrorEnvelopeErrorBuilder> {
  @BuiltValueField(wireName: r'kind')
  ErrorKind get kind;
  // enum kindEnum {  unauthorized,  forbidden,  not_found,  bad_request,  upstream_error,  rate_limited,  internal_error,  };

  /// Short user-presentable message in ES (default) or _en. No secrets.
  @BuiltValueField(wireName: r'message')
  String get message;

  /// Stable error code for client branching.
  @BuiltValueField(wireName: r'code')
  String? get code;

  /// Matches the request_id in BFF logs.
  @BuiltValueField(wireName: r'request_id')
  String get requestId;

  ErrorEnvelopeError._();

  factory ErrorEnvelopeError([void updates(ErrorEnvelopeErrorBuilder b)]) = _$ErrorEnvelopeError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ErrorEnvelopeErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ErrorEnvelopeError> get serializer => _$ErrorEnvelopeErrorSerializer();
}

class _$ErrorEnvelopeErrorSerializer implements PrimitiveSerializer<ErrorEnvelopeError> {
  @override
  final Iterable<Type> types = const [ErrorEnvelopeError, _$ErrorEnvelopeError];

  @override
  final String wireName = r'ErrorEnvelopeError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ErrorEnvelopeError object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(ErrorKind),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(String),
      );
    }
    yield r'request_id';
    yield serializers.serialize(
      object.requestId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ErrorEnvelopeError object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ErrorEnvelopeErrorBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ErrorKind),
          ) as ErrorKind;
          result.kind = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'request_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.requestId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ErrorEnvelopeError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ErrorEnvelopeErrorBuilder();
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

