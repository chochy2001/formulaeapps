// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_kind.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ErrorKind _$unauthorized = const ErrorKind._('unauthorized');
const ErrorKind _$forbidden = const ErrorKind._('forbidden');
const ErrorKind _$notFound = const ErrorKind._('notFound');
const ErrorKind _$badRequest = const ErrorKind._('badRequest');
const ErrorKind _$upstreamError = const ErrorKind._('upstreamError');
const ErrorKind _$rateLimited = const ErrorKind._('rateLimited');
const ErrorKind _$internalError = const ErrorKind._('internalError');

ErrorKind _$valueOf(String name) {
  switch (name) {
    case 'unauthorized':
      return _$unauthorized;
    case 'forbidden':
      return _$forbidden;
    case 'notFound':
      return _$notFound;
    case 'badRequest':
      return _$badRequest;
    case 'upstreamError':
      return _$upstreamError;
    case 'rateLimited':
      return _$rateLimited;
    case 'internalError':
      return _$internalError;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ErrorKind> _$values = BuiltSet<ErrorKind>(const <ErrorKind>[
  _$unauthorized,
  _$forbidden,
  _$notFound,
  _$badRequest,
  _$upstreamError,
  _$rateLimited,
  _$internalError,
]);

class _$ErrorKindMeta {
  const _$ErrorKindMeta();
  ErrorKind get unauthorized => _$unauthorized;
  ErrorKind get forbidden => _$forbidden;
  ErrorKind get notFound => _$notFound;
  ErrorKind get badRequest => _$badRequest;
  ErrorKind get upstreamError => _$upstreamError;
  ErrorKind get rateLimited => _$rateLimited;
  ErrorKind get internalError => _$internalError;
  ErrorKind valueOf(String name) => _$valueOf(name);
  BuiltSet<ErrorKind> get values => _$values;
}

abstract class _$ErrorKindMixin {
  // ignore: non_constant_identifier_names
  _$ErrorKindMeta get ErrorKind => const _$ErrorKindMeta();
}

Serializer<ErrorKind> _$errorKindSerializer = _$ErrorKindSerializer();

class _$ErrorKindSerializer implements PrimitiveSerializer<ErrorKind> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unauthorized': 'unauthorized',
    'forbidden': 'forbidden',
    'notFound': 'not_found',
    'badRequest': 'bad_request',
    'upstreamError': 'upstream_error',
    'rateLimited': 'rate_limited',
    'internalError': 'internal_error',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unauthorized': 'unauthorized',
    'forbidden': 'forbidden',
    'not_found': 'notFound',
    'bad_request': 'badRequest',
    'upstream_error': 'upstreamError',
    'rate_limited': 'rateLimited',
    'internal_error': 'internalError',
  };

  @override
  final Iterable<Type> types = const <Type>[ErrorKind];
  @override
  final String wireName = 'ErrorKind';

  @override
  Object serialize(Serializers serializers, ErrorKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ErrorKind deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ErrorKind.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
