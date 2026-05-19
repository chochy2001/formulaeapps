//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_token_request.g.dart';

/// AuthTokenRequest
///
/// Properties:
/// * [clientId] - Per-install client identifier, stable across launches.
/// * [clientProof] - HMAC-SHA256(JWT_SHARED_SECRET, client_id || build_nonce) hex (64 chars).
/// * [buildNonce] - Per-build constant baked into the app bundle (32 hex chars).
/// * [platform] - Client platform identifier.
/// * [appVersion] - Client app version (semver-ish).
@BuiltValue()
abstract class AuthTokenRequest implements Built<AuthTokenRequest, AuthTokenRequestBuilder> {
  /// Per-install client identifier, stable across launches.
  @BuiltValueField(wireName: r'client_id')
  String get clientId;

  /// HMAC-SHA256(JWT_SHARED_SECRET, client_id || build_nonce) hex (64 chars).
  @BuiltValueField(wireName: r'client_proof')
  String get clientProof;

  /// Per-build constant baked into the app bundle (32 hex chars).
  @BuiltValueField(wireName: r'build_nonce')
  String get buildNonce;

  /// Client platform identifier.
  @BuiltValueField(wireName: r'platform')
  AuthTokenRequestPlatformEnum get platform;
  // enum platformEnum {  web,  android,  ios,  macos,  };

  /// Client app version (semver-ish).
  @BuiltValueField(wireName: r'app_version')
  String get appVersion;

  AuthTokenRequest._();

  factory AuthTokenRequest([void updates(AuthTokenRequestBuilder b)]) = _$AuthTokenRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthTokenRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthTokenRequest> get serializer => _$AuthTokenRequestSerializer();
}

class _$AuthTokenRequestSerializer implements PrimitiveSerializer<AuthTokenRequest> {
  @override
  final Iterable<Type> types = const [AuthTokenRequest, _$AuthTokenRequest];

  @override
  final String wireName = r'AuthTokenRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'client_id';
    yield serializers.serialize(
      object.clientId,
      specifiedType: const FullType(String),
    );
    yield r'client_proof';
    yield serializers.serialize(
      object.clientProof,
      specifiedType: const FullType(String),
    );
    yield r'build_nonce';
    yield serializers.serialize(
      object.buildNonce,
      specifiedType: const FullType(String),
    );
    yield r'platform';
    yield serializers.serialize(
      object.platform,
      specifiedType: const FullType(AuthTokenRequestPlatformEnum),
    );
    yield r'app_version';
    yield serializers.serialize(
      object.appVersion,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthTokenRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'client_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientId = valueDes;
          break;
        case r'client_proof':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientProof = valueDes;
          break;
        case r'build_nonce':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.buildNonce = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthTokenRequestPlatformEnum),
          ) as AuthTokenRequestPlatformEnum;
          result.platform = valueDes;
          break;
        case r'app_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.appVersion = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthTokenRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthTokenRequestBuilder();
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

class AuthTokenRequestPlatformEnum extends EnumClass {

  /// Client platform identifier.
  @BuiltValueEnumConst(wireName: r'web')
  static const AuthTokenRequestPlatformEnum web = _$authTokenRequestPlatformEnum_web;
  /// Client platform identifier.
  @BuiltValueEnumConst(wireName: r'android')
  static const AuthTokenRequestPlatformEnum android = _$authTokenRequestPlatformEnum_android;
  /// Client platform identifier.
  @BuiltValueEnumConst(wireName: r'ios')
  static const AuthTokenRequestPlatformEnum ios = _$authTokenRequestPlatformEnum_ios;
  /// Client platform identifier.
  @BuiltValueEnumConst(wireName: r'macos')
  static const AuthTokenRequestPlatformEnum macos = _$authTokenRequestPlatformEnum_macos;

  static Serializer<AuthTokenRequestPlatformEnum> get serializer => _$authTokenRequestPlatformEnumSerializer;

  const AuthTokenRequestPlatformEnum._(String name): super(name);

  static BuiltSet<AuthTokenRequestPlatformEnum> get values => _$authTokenRequestPlatformEnumValues;
  static AuthTokenRequestPlatformEnum valueOf(String name) => _$authTokenRequestPlatformEnumValueOf(name);
}

