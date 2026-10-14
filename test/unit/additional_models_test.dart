import 'package:flutter_test/flutter_test.dart';
import 'package:only_us/models/attachment_model.dart';
import 'package:only_us/models/conversation_model.dart';

void main() {
  test('ConversationModel converts to and from JSON', () {
    final conversation = ConversationModel(
      id: 'conversation-1',
      title: 'Us',
      participantIds: const ['user-1', 'user-2'],
      lastMessage: 'Hello',
      updatedAt: DateTime.utc(2026, 10, 14, 6, 30),
    );

    expect(
      ConversationModel.fromJson(conversation.toJson()).toJson(),
      conversation.toJson(),
    );
  });

  test('ConversationModel handles optional message and update time', () {
    final conversation = ConversationModel.fromJson({
      'id': 'conversation-1',
      'title': 'Us',
      'participant_ids': ['user-1', 'user-2'],
    });

    expect(conversation.lastMessage, isNull);
    expect(conversation.updatedAt, isNull);
  });

  test('AttachmentModel converts to and from JSON', () {
    final attachment = AttachmentModel(
      id: 'attachment-1',
      messageId: 'message-1',
      fileName: 'photo.jpg',
      storagePath: 'conversation-1/photo.jpg',
      contentType: 'image/jpeg',
      sizeBytes: 2048,
      createdAt: DateTime.utc(2026, 10, 14, 6, 30),
    );

    expect(
      AttachmentModel.fromJson(attachment.toJson()).toJson(),
      attachment.toJson(),
    );
  });
}
