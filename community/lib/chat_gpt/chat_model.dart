class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({required this.msg, required this.chatIndex});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      msg: json['message'],
      chatIndex: json['index'],
    );
  }
}
