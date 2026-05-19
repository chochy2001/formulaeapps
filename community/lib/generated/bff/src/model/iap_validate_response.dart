//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'iap_validate_response.g.dart';

/// IapValidateResponse
///
/// Properties:
/// * [valid] - true if the provider confirms the receipt.
/// * [expiresAt] - ISO-8601 UTC. Present for subscriptions.
/// * [productId] 
/// * [transactionId] 
/// * [environment] - IAP environment that produced the receipt.
/// * [providerReason] - Short reason when valid=false. Does not leak the raw provider body.
@BuiltValue()
abstract class IapValidateResponse implements Built<IapValidateResponse, IapValidateResponseBuilder> {
  /// true if the provider confirms the receipt.
  @BuiltValueField(wireName: r'valid')
  bool get valid;

  /// ISO-8601 UTC. Present for subscriptions.
  @BuiltValueField(wireName: r'expires_at')
  DateTime? get expiresAt;

  @BuiltValueField(wireName: r'product_id')
  String get productId;

  @BuiltValueField(wireName: r'transaction_id')
  String get transactionId;

  /// IAP environment that produced the receipt.
  @BuiltValueField(wireName: r'environment')
  IapValidateResponseEnvironmentEnum get environment;
  // enum environmentEnum {  sandbox,  production,  };

  /// Short reason when valid=false. Does not leak the raw provider body.
  @BuiltValueField(wireName: r'provider_reason')
  String? get providerReason;

  IapValidateResponse._();

  factory IapValidateResponse([void updates(IapValidateResponseBuilder b)]) = _$IapValidateResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IapValidateResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IapValidateResponse> get serializer => _$IapValidateResponseSerializer();
}

class _$IapValidateResponseSerializer implements PrimitiveSerializer<IapValidateResponse> {
  @override
  final Iterable<Type> types = const [IapValidateResponse, _$IapValidateResponse];

  @override
  final String wireName = r'IapValidateResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IapValidateResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'valid';
    yield serializers.serialize(
      object.valid,
      specifiedType: const FullType(bool),
    );
    if (object.expiresAt != null) {
      yield r'expires_at';
      yield serializers.serialize(
        object.expiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'transaction_id';
    yield serializers.serialize(
      object.transactionId,
      specifiedType: const FullType(String),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(IapValidateResponseEnvironmentEnum),
    );
    if (object.providerReason != null) {
      yield r'provider_reason';
      yield serializers.serialize(
        object.providerReason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    IapValidateResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IapValidateResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'valid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.valid = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'transaction_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transactionId = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IapValidateResponseEnvironmentEnum),
          ) as IapValidateResponseEnvironmentEnum;
          result.environment = valueDes;
          break;
        case r'provider_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IapValidateResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IapValidateResponseBuilder();
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

class IapValidateResponseEnvironmentEnum extends EnumClass {

  /// IAP environment that produced the receipt.
  @BuiltValueEnumConst(wireName: r'sandbox')
  static const IapValidateResponseEnvironmentEnum sandbox = _$iapValidateResponseEnvironmentEnum_sandbox;
  /// IAP environment that produced the receipt.
  @BuiltValueEnumConst(wireName: r'production')
  static const IapValidateResponseEnvironmentEnum production = _$iapValidateResponseEnvironmentEnum_production;

  static Serializer<IapValidateResponseEnvironmentEnum> get serializer => _$iapValidateResponseEnvironmentEnumSerializer;

  const IapValidateResponseEnvironmentEnum._(String name): super(name);

  static BuiltSet<IapValidateResponseEnvironmentEnum> get values => _$iapValidateResponseEnvironmentEnumValues;
  static IapValidateResponseEnvironmentEnum valueOf(String name) => _$iapValidateResponseEnvironmentEnumValueOf(name);
}

