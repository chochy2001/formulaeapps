//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'iap_validate_request.g.dart';

/// IapValidateRequest
///
/// Properties:
/// * [platform] - IAP provider.
/// * [productId] - Provider's product identifier.
/// * [transactionId] - Provider's transaction id.
/// * [receiptData] - Base64-encoded receipt (Apple) or purchase token (Google). Max 16 KB.
/// * [subscription] - true for subscriptions, false for one-time purchases.
@BuiltValue()
abstract class IapValidateRequest implements Built<IapValidateRequest, IapValidateRequestBuilder> {
  /// IAP provider.
  @BuiltValueField(wireName: r'platform')
  IapValidateRequestPlatformEnum get platform;
  // enum platformEnum {  apple,  google,  };

  /// Provider's product identifier.
  @BuiltValueField(wireName: r'product_id')
  String get productId;

  /// Provider's transaction id.
  @BuiltValueField(wireName: r'transaction_id')
  String get transactionId;

  /// Base64-encoded receipt (Apple) or purchase token (Google). Max 16 KB.
  @BuiltValueField(wireName: r'receipt_data')
  String get receiptData;

  /// true for subscriptions, false for one-time purchases.
  @BuiltValueField(wireName: r'subscription')
  bool get subscription;

  IapValidateRequest._();

  factory IapValidateRequest([void updates(IapValidateRequestBuilder b)]) = _$IapValidateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IapValidateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IapValidateRequest> get serializer => _$IapValidateRequestSerializer();
}

class _$IapValidateRequestSerializer implements PrimitiveSerializer<IapValidateRequest> {
  @override
  final Iterable<Type> types = const [IapValidateRequest, _$IapValidateRequest];

  @override
  final String wireName = r'IapValidateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IapValidateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'platform';
    yield serializers.serialize(
      object.platform,
      specifiedType: const FullType(IapValidateRequestPlatformEnum),
    );
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
    yield r'receipt_data';
    yield serializers.serialize(
      object.receiptData,
      specifiedType: const FullType(String),
    );
    yield r'subscription';
    yield serializers.serialize(
      object.subscription,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    IapValidateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IapValidateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IapValidateRequestPlatformEnum),
          ) as IapValidateRequestPlatformEnum;
          result.platform = valueDes;
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
        case r'receipt_data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.receiptData = valueDes;
          break;
        case r'subscription':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.subscription = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IapValidateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IapValidateRequestBuilder();
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

class IapValidateRequestPlatformEnum extends EnumClass {

  /// IAP provider.
  @BuiltValueEnumConst(wireName: r'apple')
  static const IapValidateRequestPlatformEnum apple = _$iapValidateRequestPlatformEnum_apple;
  /// IAP provider.
  @BuiltValueEnumConst(wireName: r'google')
  static const IapValidateRequestPlatformEnum google = _$iapValidateRequestPlatformEnum_google;

  static Serializer<IapValidateRequestPlatformEnum> get serializer => _$iapValidateRequestPlatformEnumSerializer;

  const IapValidateRequestPlatformEnum._(String name): super(name);

  static BuiltSet<IapValidateRequestPlatformEnum> get values => _$iapValidateRequestPlatformEnumValues;
  static IapValidateRequestPlatformEnum valueOf(String name) => _$iapValidateRequestPlatformEnumValueOf(name);
}

