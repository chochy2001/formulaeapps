//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entitlement_source.g.dart';

/// EntitlementSource
///
/// Properties:
/// * [paymentSource] 
/// * [productId] 
/// * [grantedAt] 
@BuiltValue()
abstract class EntitlementSource implements Built<EntitlementSource, EntitlementSourceBuilder> {
  @BuiltValueField(wireName: r'payment_source')
  EntitlementSourcePaymentSourceEnum get paymentSource;
  // enum paymentSourceEnum {  app_store,  play_store,  };

  @BuiltValueField(wireName: r'product_id')
  String get productId;

  @BuiltValueField(wireName: r'granted_at')
  DateTime get grantedAt;

  EntitlementSource._();

  factory EntitlementSource([void updates(EntitlementSourceBuilder b)]) = _$EntitlementSource;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EntitlementSourceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EntitlementSource> get serializer => _$EntitlementSourceSerializer();
}

class _$EntitlementSourceSerializer implements PrimitiveSerializer<EntitlementSource> {
  @override
  final Iterable<Type> types = const [EntitlementSource, _$EntitlementSource];

  @override
  final String wireName = r'EntitlementSource';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EntitlementSource object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'payment_source';
    yield serializers.serialize(
      object.paymentSource,
      specifiedType: const FullType(EntitlementSourcePaymentSourceEnum),
    );
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'granted_at';
    yield serializers.serialize(
      object.grantedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EntitlementSource object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EntitlementSourceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'payment_source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EntitlementSourcePaymentSourceEnum),
          ) as EntitlementSourcePaymentSourceEnum;
          result.paymentSource = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'granted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.grantedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EntitlementSource deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EntitlementSourceBuilder();
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

class EntitlementSourcePaymentSourceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'app_store')
  static const EntitlementSourcePaymentSourceEnum appStore = _$entitlementSourcePaymentSourceEnum_appStore;
  @BuiltValueEnumConst(wireName: r'play_store')
  static const EntitlementSourcePaymentSourceEnum playStore = _$entitlementSourcePaymentSourceEnum_playStore;

  static Serializer<EntitlementSourcePaymentSourceEnum> get serializer => _$entitlementSourcePaymentSourceEnumSerializer;

  const EntitlementSourcePaymentSourceEnum._(String name): super(name);

  static BuiltSet<EntitlementSourcePaymentSourceEnum> get values => _$entitlementSourcePaymentSourceEnumValues;
  static EntitlementSourcePaymentSourceEnum valueOf(String name) => _$entitlementSourcePaymentSourceEnumValueOf(name);
}

