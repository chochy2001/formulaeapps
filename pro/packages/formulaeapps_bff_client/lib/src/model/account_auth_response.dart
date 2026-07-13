//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_auth_response.g.dart';

/// AccountAuthResponse
///
/// Properties:
/// * [token] - Session JWT; future claim user_id binds entitlements.
/// * [expiresAt] 
/// * [userId] - Stable account id — entitlement key once accounts go live.
@BuiltValue()
abstract class AccountAuthResponse implements Built<AccountAuthResponse, AccountAuthResponseBuilder> {
  /// Session JWT; future claim user_id binds entitlements.
  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  /// Stable account id — entitlement key once accounts go live.
  @BuiltValueField(wireName: r'user_id')
  String get userId;

  AccountAuthResponse._();

  factory AccountAuthResponse([void updates(AccountAuthResponseBuilder b)]) = _$AccountAuthResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountAuthResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountAuthResponse> get serializer => _$AccountAuthResponseSerializer();
}

class _$AccountAuthResponseSerializer implements PrimitiveSerializer<AccountAuthResponse> {
  @override
  final Iterable<Type> types = const [AccountAuthResponse, _$AccountAuthResponse];

  @override
  final String wireName = r'AccountAuthResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountAuthResponse object, {
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
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountAuthResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountAuthResponseBuilder result,
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
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountAuthResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountAuthResponseBuilder();
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

