import 'package:flutter/cupertino.dart';

import '../chat_gpt/export_chat_gpt.dart';

class ChatProvider with ChangeNotifier {
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
    chatList.addAll(
      await ApiService.sendMessage(message: msg, modelId: chosenModelId),
    );
    notifyListeners();
  }

  void clearChat() {
    chatList.clear();
    notifyListeners();
  }
}
