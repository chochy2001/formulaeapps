import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/account_auth_service.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';

class _RecordingClient extends FormulaeappsBffClient {
  _RecordingClient({
    this.registerResponse,
    this.loginResponse,
    this.throwDio = false,
    this.throwOauthStub = false,
  }) : super(
         basePathOverride: 'http://test-bff',
         dio: Dio(BaseOptions(baseUrl: 'http://test-bff')),
       );

  final AccountAuthResponse? registerResponse;
  final AccountAuthResponse? loginResponse;
  final bool throwDio;
  final bool throwOauthStub;
  bool registerCalled = false;
  bool loginCalled = false;
  bool oauthCalled = false;
  AccountRegisterRequest? lastRegister;
  AccountLoginRequest? lastLogin;
  AccountOAuthRequest? lastOauth;

  @override
  AuthApi getAuthApi() => _RecordingAuthApi(this);
}

class _RecordingAuthApi extends AuthApi {
  _RecordingAuthApi(this._parent) : super(_parent.dio, standardSerializers);

  final _RecordingClient _parent;

  @override
  Future<Response<AccountAuthResponse>> authRegisterPost({
    required AccountRegisterRequest accountRegisterRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _parent.registerCalled = true;
    _parent.lastRegister = accountRegisterRequest;
    if (_parent.throwDio) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/register'),
        response: Response(
          requestOptions: RequestOptions(path: '/auth/register'),
          statusCode: 403,
          data: {
            'error': {
              'kind': 'forbidden',
              'code': 'E_ACCOUNTS_DISABLED',
              'message': 'disabled',
              'request_id': '00000000-0000-0000-0000-000000000001',
            },
          },
        ),
        type: DioExceptionType.badResponse,
      );
    }
    return Response<AccountAuthResponse>(
      data: _parent.registerResponse,
      requestOptions: RequestOptions(path: '/auth/register'),
      statusCode: 200,
    );
  }

  @override
  Future<Response<AccountAuthResponse>> authLoginPost({
    required AccountLoginRequest accountLoginRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _parent.loginCalled = true;
    _parent.lastLogin = accountLoginRequest;
    return Response<AccountAuthResponse>(
      data: _parent.loginResponse,
      requestOptions: RequestOptions(path: '/auth/login'),
      statusCode: 200,
    );
  }

  @override
  Future<Response<AccountAuthResponse>> authOauthPost({
    required AccountOAuthRequest accountOAuthRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _parent.oauthCalled = true;
    _parent.lastOauth = accountOAuthRequest;
    if (_parent.throwOauthStub) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/oauth'),
        response: Response(
          requestOptions: RequestOptions(path: '/auth/oauth'),
          statusCode: 503,
          data: {
            'error': {
              'kind': 'internal_error',
              'code': 'E_OAUTH_NOT_IMPLEMENTED',
              'message': 'stub',
              'request_id': '00000000-0000-0000-0000-000000000002',
            },
          },
        ),
        type: DioExceptionType.badResponse,
      );
    }
    return Response<AccountAuthResponse>(
      data: null,
      requestOptions: RequestOptions(path: '/auth/oauth'),
      statusCode: 503,
    );
  }
}

void main() {
  group('AccountAuthService', () {
    test(
      'register/login/oauth return AccountAuthDisabled when flag off',
      () async {
        final recording = _RecordingClient();
        final service = AccountAuthService(
          enabled: false,
          clientFactory: () => recording,
        );

        expect(
          await service.register(email: 'a@b.com', password: 'password1'),
          isA<AccountAuthDisabled>(),
        );
        expect(
          await service.login(email: 'a@b.com', password: 'password1'),
          isA<AccountAuthDisabled>(),
        );
        expect(
          await service.oauth(
            provider: AccountOAuthRequestProviderEnum.google,
            idToken: 'fake',
          ),
          isA<AccountAuthDisabled>(),
        );
        expect(recording.registerCalled, isFalse);
        expect(recording.loginCalled, isFalse);
        expect(recording.oauthCalled, isFalse);
      },
    );

    test('oauth maps BFF stub 503 to AccountAuthFailure', () async {
      final recording = _RecordingClient(throwOauthStub: true);
      final service = AccountAuthService(
        enabled: true,
        clientFactory: () => recording,
      );

      final result = await service.oauth(
        provider: AccountOAuthRequestProviderEnum.apple,
        idToken: 'fake.jwt',
      );
      expect(recording.oauthCalled, isTrue);
      expect(
        recording.lastOauth?.provider,
        AccountOAuthRequestProviderEnum.apple,
      );
      expect(result, isA<AccountAuthFailure>());
      final fail = result as AccountAuthFailure;
      expect(fail.statusCode, 503);
      expect(fail.code, 'E_OAUTH_NOT_IMPLEMENTED');
    });

    test('register returns success without a device-ownership field', () async {
      final payload = AccountAuthResponse((b) {
        b.token = 'acct-jwt';
        b.expiresAt = DateTime.utc(2026, 7, 14, 1);
        b.userId = '550e8400-e29b-41d4-a716-446655440000';
      });
      final recording = _RecordingClient(registerResponse: payload);
      final service = AccountAuthService(
        enabled: true,
        clientFactory: () => recording,
      );

      final result = await service.register(
        email: 'user@example.com',
        password: 'correct-horse',
      );

      expect(recording.registerCalled, isTrue);
      expect(recording.lastRegister?.email, 'user@example.com');
      expect(result, isA<AccountAuthSuccess>());
      final ok = result as AccountAuthSuccess;
      expect(ok.userId, '550e8400-e29b-41d4-a716-446655440000');
      expect(ok.token, 'acct-jwt');
    });

    test('login returns success without a device-ownership field', () async {
      final payload = AccountAuthResponse((b) {
        b.token = 'acct-login-jwt';
        b.expiresAt = DateTime.utc(2026, 7, 14, 2);
        b.userId = '550e8400-e29b-41d4-a716-446655440000';
      });
      final recording = _RecordingClient(loginResponse: payload);
      final service = AccountAuthService(
        enabled: true,
        clientFactory: () => recording,
      );

      final result = await service.login(
        email: 'user@example.com',
        password: 'correct-horse',
      );

      expect(recording.loginCalled, isTrue);
      expect(recording.lastLogin?.email, 'user@example.com');
      expect(result, isA<AccountAuthSuccess>());
    });

    test('login maps Dio 403 to AccountAuthFailure with code', () async {
      final recording = _RecordingClient(throwDio: true);
      final service = AccountAuthService(
        enabled: true,
        clientFactory: () => recording,
      );

      final result = await service.register(
        email: 'user@example.com',
        password: 'correct-horse',
      );
      expect(result, isA<AccountAuthFailure>());
      final fail = result as AccountAuthFailure;
      expect(fail.statusCode, 403);
      expect(fail.code, 'E_ACCOUNTS_DISABLED');
    });

    test('default dart-define flag is off', () {
      expect(kEnableUserAccountAuth, isFalse);
    });
  });
}
