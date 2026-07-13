//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_login_request.g.dart';

/// AccountLoginRequest
///
/// Properties:
/// * [email] 
/// * [password] - Password. Never logged.
@BuiltValue()
abstract class AccountLoginRequest implements Built<AccountLoginRequest, AccountLoginRequestBuilder> {
  @BuiltValueField(wireName: r'email')
  String get email;

  /// Password. Never logged.
  @BuiltValueField(wireName: r'password')
  String get password;

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

