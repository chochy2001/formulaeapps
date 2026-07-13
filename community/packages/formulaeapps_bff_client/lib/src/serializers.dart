//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:formulaeapps_bff_client/src/date_serializer.dart';
import 'package:formulaeapps_bff_client/src/model/date.dart';

import 'package:formulaeapps_bff_client/src/model/auth_token_request.dart';
import 'package:formulaeapps_bff_client/src/model/auth_token_response.dart';
import 'package:formulaeapps_bff_client/src/model/chat_request.dart';
import 'package:formulaeapps_bff_client/src/model/chat_response.dart';
import 'package:formulaeapps_bff_client/src/model/chat_usage.dart';
import 'package:formulaeapps_bff_client/src/model/entitlement_response.dart';
import 'package:formulaeapps_bff_client/src/model/entitlement_source.dart';
import 'package:formulaeapps_bff_client/src/model/error_envelope.dart';
import 'package:formulaeapps_bff_client/src/model/error_envelope_error.dart';
import 'package:formulaeapps_bff_client/src/model/error_kind.dart';
import 'package:formulaeapps_bff_client/src/model/health_response.dart';
import 'package:formulaeapps_bff_client/src/model/health_status.dart';
import 'package:formulaeapps_bff_client/src/model/iap_validate_request.dart';
import 'package:formulaeapps_bff_client/src/model/iap_validate_response.dart';

part 'serializers.g.dart';

@SerializersFor([
  AuthTokenRequest,
  AuthTokenResponse,
  ChatRequest,
  ChatResponse,
  ChatUsage,
  EntitlementResponse,
  EntitlementSource,
  ErrorEnvelope,
  ErrorEnvelopeError,
  ErrorKind,
  HealthResponse,
  HealthStatus,
  IapValidateRequest,
  IapValidateResponse,
])
Serializers serializers = (_$serializers.toBuilder()
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
