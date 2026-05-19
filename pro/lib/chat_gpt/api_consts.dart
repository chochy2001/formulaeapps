// FormulaeApps BFF client constants — dart-define driven, no hardcoded secrets.
//
// All values come from --dart-define at build time. Defaults match the BFF
// production host so dev builds against the BFF without explicit configuration,
// but secret material (JWT_SHARED_SECRET) defaults to empty and is checked by
// the placeholder-secret guard in main_pro.dart (spec §FR-006).

/// BFF base URL. Override via:
///   --dart-define=FORMULAE_BFF_BASE_URL=https://api.formulaeapps.com
const String bffBaseUrl = String.fromEnvironment(
  'FORMULAE_BFF_BASE_URL',
  defaultValue: 'https://api.formulaeapps.com',
);

/// JWT issuance endpoint — used by `auth_service.dart` to mint session tokens.
const String bffAuthTokenUrl = '$bffBaseUrl/auth/token';

/// Chat proxy endpoint — used by `api_service.dart` for OpenAI chat passthrough.
/// Retained for backward compatibility with the original `bffChatUrl` symbol.
const String bffChatUrl = String.fromEnvironment(
  'FORMULAE_BFF_CHAT_URL',
  defaultValue: '$bffBaseUrl/openai/chat',
);

/// Shared secret used to compute the `client_proof` HMAC sent to /auth/token.
/// MUST be provided via --dart-define=JWT_SHARED_SECRET=<hex32>.
/// Empty / placeholder values are rejected in --release mode by the build guard
/// in main_pro.dart (spec §FR-006).
const String jwtSharedSecret = String.fromEnvironment(
  'JWT_SHARED_SECRET',
  defaultValue: '',
);

/// Per-build nonce baked into the app bundle, part of the auth proof.
/// Override via --dart-define=FORMULAE_BUILD_NONCE=<hex32>.
const String buildNonce = String.fromEnvironment(
  'FORMULAE_BUILD_NONCE',
  defaultValue: 'pro-dev-build-nonce-replace-via-dart-define',
);

/// App version reported in the auth request. Manually synced with pubspec.yaml.
const String appVersion = String.fromEnvironment(
  'FORMULAE_APP_VERSION',
  defaultValue: '0.0.0-dev',
);
