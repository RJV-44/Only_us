import 'package:flutter_test/flutter_test.dart';
import 'package:only_us/models/message_model.dart';
import 'package:only_us/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('converts to and from JSON', () {
      const user = UserModel(
        id: 'user-1',
        email: 'person@example.com',
        displayName: 'Person',
        avatarUrl: 'https://example.com/avatar.png',
      );

      expect(UserModel.fromJson(user.toJson()).toJson(), user.toJson());
    });

    test('reads optional profile fields when absent', () {
      final user = UserModel.fromJson({
        'id': 'user-1',
        'email': 'person@example.com',
      });

      expect(user.displayName, isNull);
      expect(user.avatarUrl, isNull);
    });
  });

  group('MessageModel', () {
    test('converts to and from JSON', () {
      final message = MessageModel(
        id: 'message-1',
        conversationId: 'conversation-1',
        senderId: 'user-1',
        content: 'Hello',
        createdAt: DateTime.utc(2026, 10, 14, 6, 30),
      );

      expect(
        MessageModel.fromJson(message.toJson()).toJson(),
        message.toJson(),
      );
    });
  });
}
