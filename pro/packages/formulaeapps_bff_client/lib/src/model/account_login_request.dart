//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_login_request.g.dart';

/// AccountLoginRequest
///
/// Properties:
/// * [email] 
/// * [password] - Password. Never logged.
/// * [platform] - Client platform for the issued session JWT (default: web).
/// * [appVersion] - Client app version for the session JWT (default: 0.0.0).
/// * [clientId] - Optional device client_id — when present, prior mobile entitlements for that device subject are bound to the new user_id.
@BuiltValue()
abstract class AccountLoginRequest implements Built<AccountLoginRequest, AccountLoginRequestBuilder> {
  @BuiltValueField(wireName: r'email')
  String get email;

  /// Password. Never logged.
  @BuiltValueField(wireName: r'password')
  String get password;

  /// Client platform for the issued session JWT (default: web).
  @BuiltValueField(wireName: r'platform')
  AccountLoginRequestPlatformEnum? get platform;
  // enum platformEnum {  web,  android,  ios,  macos,  };

  /// Client app version for the session JWT (default: 0.0.0).
  @BuiltValueField(wireName: r'app_version')
  String? get appVersion;

  /// Optional device client_id — when present, prior mobile entitlements for that device subject are bound to the new user_id.
  @BuiltValueField(wireName: r'client_id')
  String? get clientId;

  AccountLoginRequest._();

  factory AccountLoginRequest([void updates(AccountLoginRequestBuilder b)]) = _$AccountLoginRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountLoginRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountLoginRequest> get serializer => _$AccountLoginRequestSerializer();
}

class _$AccountLoginRequestSerializer implements PrimitiveSerializer<AccountLoginRequest> {
  @override
  final Iterable<Type> types = const [AccountLoginRequest, _$AccountLoginRequest];

  @override
  final String wireName = r'AccountLoginRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    if (object.platform != null) {
      yield r'platform';
      yield serializers.serialize(
        object.platform,
        specifiedType: const FullType(AccountLoginRequestPlatformEnum),
      );
    }
    if (object.appVersion != null) {
      yield r'app_version';
      yield serializers.serialize(
        object.appVersion,
        specifiedType: const FullType(String),
      );
    }
    if (object.clientId != null) {
      yield r'client_id';
      yield serializers.serialize(
        object.clientId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountLoginRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountLoginRequestPlatformEnum),
          ) as AccountLoginRequestPlatformEnum;
          result.platform = valueDes;
          break;
        case r'app_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.appVersion = valueDes;
          break;
        case r'client_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountLoginRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountLoginRequestBuilder();
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

class AccountLoginRequestPlatformEnum extends EnumClass {

  /// Client platform for the issued session JWT (default: web).
  @BuiltValueEnumConst(wireName: r'web')
  static const AccountLoginRequestPlatformEnum web = _$accountLoginRequestPlatformEnum_web;
  /// Client platform for the issued session JWT (default: web).
  @BuiltValueEnumConst(wireName: r'android')
  static const AccountLoginRequestPlatformEnum android = _$accountLoginRequestPlatformEnum_android;
  /// Client platform for the issued session JWT (default: web).
  @BuiltValueEnumConst(wireName: r'ios')
  static const AccountLoginRequestPlatformEnum ios = _$accountLoginRequestPlatformEnum_ios;
  /// Client platform for the issued session JWT (default: web).
  @BuiltValueEnumConst(wireName: r'macos')
  static const AccountLoginRequestPlatformEnum macos = _$accountLoginRequestPlatformEnum_macos;

  static Serializer<AccountLoginRequestPlatformEnum> get serializer => _$accountLoginRequestPlatformEnumSerializer;

  const AccountLoginRequestPlatformEnum._(String name): super(name);

  static BuiltSet<AccountLoginRequestPlatformEnum> get values => _$accountLoginRequestPlatformEnumValues;
  static AccountLoginRequestPlatformEnum valueOf(String name) => _$accountLoginRequestPlatformEnumValueOf(name);
}

