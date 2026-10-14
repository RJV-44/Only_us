import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/constants/app_constants.dart';
import '../models/message_model.dart';

class ChatService {
  const ChatService(this._client);

  final SupabaseClient _client;

  Stream<List<MessageModel>> watchMessages(String conversationId) {
    return _client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at')
        .map(
          (rows) =>
              rows
                  .map((row) => MessageModel.fromJson(row))
                  .toList(growable: false),
        );
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String content,
  }) async {
    final trimmedContent = content.trim();
    if (trimmedContent.isEmpty) {
      throw ArgumentError.value(content, 'content', 'Message cannot be empty.');
    }
    if (trimmedContent.length > AppConstants.maximumMessageLength) {
      throw ArgumentError.value(
        content,
        'content',
        'Message cannot exceed ${AppConstants.maximumMessageLength} characters.',
      );
    }
    await _client.from('messages').insert({
      'conversation_id': conversationId,
      'sender_id': senderId,
      'content': trimmedContent,
    });
  }
}
