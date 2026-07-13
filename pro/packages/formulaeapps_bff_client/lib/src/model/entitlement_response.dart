//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:formulaeapps_bff_client/src/model/entitlement_source.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entitlement_response.g.dart';

/// EntitlementResponse
///
/// Properties:
/// * [scope] - IAP grants are mobile-only; never web/Polar from this path.
/// * [sources] 
@BuiltValue()
abstract class EntitlementResponse implements Built<EntitlementResponse, EntitlementResponseBuilder> {
  /// IAP grants are mobile-only; never web/Polar from this path.
  @BuiltValueField(wireName: r'scope')
  EntitlementResponseScopeEnum get scope;
  // enum scopeEnum {  mobile,  };

  @BuiltValueField(wireName: r'sources')
  BuiltList<EntitlementSource> get sources;

  EntitlementResponse._();

  factory EntitlementResponse([void updates(EntitlementResponseBuilder b)]) = _$EntitlementResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EntitlementResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EntitlementResponse> get serializer => _$EntitlementResponseSerializer();
}

class _$EntitlementResponseSerializer implements PrimitiveSerializer<EntitlementResponse> {
  @override
  final Iterable<Type> types = const [EntitlementResponse, _$EntitlementResponse];

  @override
  final String wireName = r'EntitlementResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EntitlementResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'scope';
    yield serializers.serialize(
      object.scope,
      specifiedType: const FullType(EntitlementResponseScopeEnum),
    );
    yield r'sources';
    yield serializers.serialize(
      object.sources,
      specifiedType: const FullType(BuiltList, [FullType(EntitlementSource)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EntitlementResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EntitlementResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EntitlementResponseScopeEnum),
          ) as EntitlementResponseScopeEnum;
          result.scope = valueDes;
          break;
        case r'sources':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EntitlementSource)]),
          ) as BuiltList<EntitlementSource>;
          result.sources.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EntitlementResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EntitlementResponseBuilder();
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

class EntitlementResponseScopeEnum extends EnumClass {

  /// IAP grants are mobile-only; never web/Polar from this path.
  @BuiltValueEnumConst(wireName: r'mobile')
  static const EntitlementResponseScopeEnum mobile = _$entitlementResponseScopeEnum_mobile;

  static Serializer<EntitlementResponseScopeEnum> get serializer => _$entitlementResponseScopeEnumSerializer;

  const EntitlementResponseScopeEnum._(String name): super(name);

  static BuiltSet<EntitlementResponseScopeEnum> get values => _$entitlementResponseScopeEnumValues;
  static EntitlementResponseScopeEnum valueOf(String name) => _$entitlementResponseScopeEnumValueOf(name);
}

