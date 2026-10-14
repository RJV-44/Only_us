import 'package:flutter/foundation.dart';

import '../../models/message_model.dart';
import '../../services/chat_service.dart';

class ChatController extends ChangeNotifier {
  ChatController(this._chatService);

  final ChatService _chatService;

  Stream<List<MessageModel>> watchMessages(String conversationId) {
    return _chatService.watchMessages(conversationId);
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
