//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_token_response.g.dart';

/// AuthTokenResponse
///
/// Properties:
/// * [token] - Compact JWS (HS256). 60-min max lifetime.
/// * [expiresAt] - ISO-8601 UTC token expiry.
/// * [refreshAfter] - ISO-8601 UTC hint for proactive refresh.
/// * [promptsVersion] - Semver of system prompts in use.
@BuiltValue()
abstract class AuthTokenResponse implements Built<AuthTokenResponse, AuthTokenResponseBuilder> {
  /// Compact JWS (HS256). 60-min max lifetime.
  @BuiltValueField(wireName: r'token')
  String get token;

  /// ISO-8601 UTC token expiry.
  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  /// ISO-8601 UTC hint for proactive refresh.
  @BuiltValueField(wireName: r'refresh_after')
  DateTime get refreshAfter;

  /// Semver of system prompts in use.
  @BuiltValueField(wireName: r'prompts_version')
  String get promptsVersion;

  AuthTokenResponse._();

  factory AuthTokenResponse([void updates(AuthTokenResponseBuilder b)]) = _$AuthTokenResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthTokenResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthTokenResponse> get serializer => _$AuthTokenResponseSerializer();
}

class _$AuthTokenResponseSerializer implements PrimitiveSerializer<AuthTokenResponse> {
  @override
  final Iterable<Type> types = const [AuthTokenResponse, _$AuthTokenResponse];

  @override
  final String wireName = r'AuthTokenResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthTokenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'refresh_after';
    yield serializers.serialize(
      object.refreshAfter,
      specifiedType: const FullType(DateTime),
    );
    yield r'prompts_version';
    yield serializers.serialize(
      object.promptsVersion,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthTokenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthTokenResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'refresh_after':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.refreshAfter = valueDes;
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
  AuthTokenResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthTokenResponseBuilder();
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

