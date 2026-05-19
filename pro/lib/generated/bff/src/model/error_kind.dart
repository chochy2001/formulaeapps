//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'error_kind.g.dart';

class ErrorKind extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unauthorized')
  static const ErrorKind unauthorized = _$unauthorized;
  @BuiltValueEnumConst(wireName: r'forbidden')
  static const ErrorKind forbidden = _$forbidden;
  @BuiltValueEnumConst(wireName: r'not_found')
  static const ErrorKind notFound = _$notFound;
  @BuiltValueEnumConst(wireName: r'bad_request')
  static const ErrorKind badRequest = _$badRequest;
  @BuiltValueEnumConst(wireName: r'upstream_error')
  static const ErrorKind upstreamError = _$upstreamError;
  @BuiltValueEnumConst(wireName: r'rate_limited')
  static const ErrorKind rateLimited = _$rateLimited;
  @BuiltValueEnumConst(wireName: r'internal_error')
  static const ErrorKind internalError = _$internalError;

  static Serializer<ErrorKind> get serializer => _$errorKindSerializer;

  const ErrorKind._(String name): super(name);

  static BuiltSet<ErrorKind> get values => _$values;
  static ErrorKind valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ErrorKindMixin = Object with _$ErrorKindMixin;

