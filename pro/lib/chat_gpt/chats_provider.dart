import 'package:flutter/cupertino.dart';

import '../chat_gpt/export_chat_gpt.dart';

typedef ChatMessageSender =
    Future<List<ChatModel>> Function({
      required String message,
      required String modelId,
    });

class ChatProvider with ChangeNotifier {
  ChatProvider({ChatMessageSender? sendMessage})
    : _sendMessage = sendMessage ?? ApiService.sendMessage;

  final ChatMessageSender _sendMessage;
  List<ChatModel> chatList = [];

  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers({
    required String msg,
    required String chosenModelId,
  }) async {
    chatList.addAll(await _sendMessage(message: msg, modelId: chosenModelId));
    notifyListeners();
  }

  void clearChat() {
    chatList.clear();
    notifyListeners();
  }
}
