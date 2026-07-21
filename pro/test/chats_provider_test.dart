import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/api_service.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';

void main() {
  test(
    'ChatProvider appends user and assistant messages and clears chat',
    () async {
      String? capturedMessage;
      String? capturedModelId;
      var notifications = 0;

      final provider = ChatProvider(
        sendMessage: ({required message, required modelId}) async {
          capturedMessage = message;
          capturedModelId = modelId;
          return [ChatModel(msg: 'Respuesta', chatIndex: 1)];
        },
      )..addListener(() => notifications++);

      provider.addUserMessage(msg: 'Pregunta');

      expect(provider.getChatList, hasLength(1));
      expect(provider.getChatList.first.msg, 'Pregunta');
      expect(provider.getChatList.first.chatIndex, 0);

      await provider.sendMessageAndGetAnswers(
        msg: 'Pregunta',
        chosenModelId: 'openai/gpt-4o-mini',
      );

      expect(capturedMessage, 'Pregunta');
      expect(capturedModelId, 'openai/gpt-4o-mini');
      expect(provider.getChatList, hasLength(2));
      expect(provider.getChatList.last.msg, 'Respuesta');
      expect(provider.getChatList.last.chatIndex, 1);

      provider.clearChat();

      expect(provider.getChatList, isEmpty);
      expect(notifications, 3);
    },
  );
}
