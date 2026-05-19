// FormulaeApps BFF client constants — dart-define driven, no hardcoded secrets.
// Mirror of pro/lib/chat_gpt/api_consts.dart (per spec §FR-004/FR-005/FR-006).

const String bffBaseUrl = String.fromEnvironment(
  'FORMULAE_BFF_BASE_URL',
  defaultValue: 'https://api.formulaeapps.com',
);

const String bffAuthTokenUrl = '$bffBaseUrl/auth/token';

const String bffChatUrl = String.fromEnvironment(
  'FORMULAE_BFF_CHAT_URL',
  defaultValue: '$bffBaseUrl/openai/chat',
);

const String jwtSharedSecret = String.fromEnvironment(
  'JWT_SHARED_SECRET',
  defaultValue: '',
);

const String buildNonce = String.fromEnvironment(
  'FORMULAE_BUILD_NONCE',
  defaultValue: 'community-dev-build-nonce-replace-via-dart-define',
);

const String appVersion = String.fromEnvironment(
  'FORMULAE_APP_VERSION',
  defaultValue: '0.0.0-dev',
);
