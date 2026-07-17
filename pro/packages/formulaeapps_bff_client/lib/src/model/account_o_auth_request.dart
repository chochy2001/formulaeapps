//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_o_auth_request.g.dart';

/// AccountOAuthRequest
///
/// Properties:
/// * [provider] - Identity provider. Only google and apple are in scope.
/// * [idToken] - Provider ID token. Never logged. Stub does not verify signatures.
/// * [platform] - Client platform for the issued session JWT (default: web).
/// * [appVersion] - Client app version for the session JWT (default: 0.0.0).
@BuiltValue()
abstract class AccountOAuthRequest implements Built<AccountOAuthRequest, AccountOAuthRequestBuilder> {
  /// Identity provider. Only google and apple are in scope.
  @BuiltValueField(wireName: r'provider')
  AccountOAuthRequestProviderEnum get provider;
  // enum providerEnum {  google,  apple,  };

  /// Provider ID token. Never logged. Stub does not verify signatures.
  @BuiltValueField(wireName: r'id_token')
  String get idToken;

  /// Client platform for the issued session JWT (default: web).
  @BuiltValueField(wireName: r'platform')
  AccountOAuthRequestPlatformEnum? get platform;
  // enum platformEnum {  web,  android,  ios,  macos,  };

  /// Client app version for the session JWT (default: 0.0.0).
  @BuiltValueField(wireName: r'app_version')
  String? get appVersion;

  AccountOAuthRequest._();

  factory AccountOAuthRequest([void updates(AccountOAuthRequestBuilder b)]) = _$AccountOAuthRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountOAuthRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountOAuthRequest> get serializer => _$AccountOAuthRequestSerializer();
}

class _$AccountOAuthRequestSerializer implements PrimitiveSerializer<AccountOAuthRequest> {
  @override
  final Iterable<Type> types = const [AccountOAuthRequest, _$AccountOAuthRequest];

  @override
  final String wireName = r'AccountOAuthRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountOAuthRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'provider';
    yield serializers.serialize(
      object.provider,
      specifiedType: const FullType(AccountOAuthRequestProviderEnum),
    );
    yield r'id_token';
    yield serializers.serialize(
      object.idToken,
      specifiedType: const FullType(String),
    );
    if (object.platform != null) {
      yield r'platform';
      yield serializers.serialize(
        object.platform,
        specifiedType: const FullType(AccountOAuthRequestPlatformEnum),
      );
    }
    if (object.appVersion != null) {
      yield r'app_version';
      yield serializers.serialize(
        object.appVersion,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountOAuthRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountOAuthRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountOAuthRequestProviderEnum),
          ) as AccountOAuthRequestProviderEnum;
          result.provider = valueDes;
          break;
        case r'id_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idToken = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountOAuthRequestPlatformEnum),
          ) as AccountOAuthRequestPlatformEnum;
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
  AccountOAuthRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountOAuthRequestBuilder();
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

class AccountOAuthRequestProviderEnum extends EnumClass {

  /// Identity provider. Only google and apple are in scope.
  @BuiltValueEnumConst(wireName: r'google')
  static const AccountOAuthRequestProviderEnum google = _$accountOAuthRequestProviderEnum_google;
  /// Identity provider. Only google and apple are in scope.
  @BuiltValueEnumConst(wireName: r'apple')
  static const AccountOAuthRequestProviderEnum apple = _$accountOAuthRequestProviderEnum_apple;

  static Serializer<AccountOAuthRequestProviderEnum> get serializer => _$accountOAuthRequestProviderEnumSerializer;

  const AccountOAuthRequestProviderEnum._(String name): super(name);

  static BuiltSet<AccountOAuthRequestProviderEnum> get values => _$accountOAuthRequestProviderEnumValues;
  static AccountOAuthRequestProviderEnum valueOf(String name) => _$accountOAuthRequestProviderEnumValueOf(name);
}

class AccountOAuthRequestPlatformEnum extends EnumClass {

  /// Client platform for the issued session JWT (default: web).
  @BuiltValueEnumConst(wireName: r'web')
  static const AccountOAuthRequestPlatformEnum web = _$accountOAuthRequestPlatformEnum_web;
  /// Client platform for the issued session JWT (default: web).
  @BuiltValueEnumConst(wireName: r'android')
  static const AccountOAuthRequestPlatformEnum android = _$accountOAuthRequestPlatformEnum_android;
  /// Client platform for the issued session JWT (default: web).
  @BuiltValueEnumConst(wireName: r'ios')
  static const AccountOAuthRequestPlatformEnum ios = _$accountOAuthRequestPlatformEnum_ios;
  /// Client platform for the issued session JWT (default: web).
  @BuiltValueEnumConst(wireName: r'macos')
  static const AccountOAuthRequestPlatformEnum macos = _$accountOAuthRequestPlatformEnum_macos;

  static Serializer<AccountOAuthRequestPlatformEnum> get serializer => _$accountOAuthRequestPlatformEnumSerializer;

  const AccountOAuthRequestPlatformEnum._(String name): super(name);

  static BuiltSet<AccountOAuthRequestPlatformEnum> get values => _$accountOAuthRequestPlatformEnumValues;
  static AccountOAuthRequestPlatformEnum valueOf(String name) => _$accountOAuthRequestPlatformEnumValueOf(name);
}

