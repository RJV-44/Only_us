import 'package:flutter/foundation.dart';

import '../../services/chat_service.dart';

class ChatController extends ChangeNotifier {
  ChatController(this._chatService);

  final ChatService _chatService;

  Future<List<Map<String, dynamic>>> loadMessages(String conversationId) {
    return _chatService.fetchMessages(conversationId);
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String content,
  }) {
    return _chatService.sendMessage(
      conversationId: conversationId,
      senderId: senderId,
      content: content,
    );
  }
}
