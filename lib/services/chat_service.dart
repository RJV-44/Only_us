import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  const ChatService(this._client);

  final SupabaseClient _client;

  Future<List<Map<String, dynamic>>> fetchMessages(String conversationId) {
    return _client
        .from('messages')
        .select()
        .eq('conversation_id', conversationId)
        .order('created_at');
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String content,
  }) async {
    await _client.from('messages').insert({
      'conversation_id': conversationId,
      'sender_id': senderId,
      'content': content,
    });
  }
}
