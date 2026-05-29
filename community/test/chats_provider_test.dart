import 'package:flutter_test/flutter_test.dart';

import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/api_service.dart';

void main() {
  group('ChatProvider', () {
    test('addUserMessage appends user chatIndex 0 entry and notifies', () {
      final provider = ChatProvider();
      var notifications = 0;
      provider.addListener(() => notifications++);

      provider.addUserMessage(msg: 'Hello tutor');

      expect(provider.getChatList, hasLength(1));
      expect(provider.getChatList.first.msg, 'Hello tutor');
      expect(provider.getChatList.first.chatIndex, 0);
      expect(notifications, 1);
    });

    test('clearChat removes all messages', () {
      final provider = ChatProvider();
      provider.addUserMessage(msg: 'A');
      provider.chatList.add(ChatModel(msg: 'B', chatIndex: 1));

      provider.clearChat();

      expect(provider.getChatList, isEmpty);
    });
  });
}
