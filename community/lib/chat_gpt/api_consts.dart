const String bffChatUrl = String.fromEnvironment(
  'FORMULAE_BFF_CHAT_URL',
  defaultValue: 'https://api.formulaeapps.com/openai/chat',
);

const String jwtSharedSecret = String.fromEnvironment(
  'JWT_SHARED_SECRET',
  defaultValue: '',
);
