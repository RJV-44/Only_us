import 'package:flutter/material.dart';

import 'widgets/message_bubble.dart';
import 'widgets/message_composer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messages = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your conversation')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text('Preview only — messages are not saved.'),
          ),
          Expanded(
            child: _messages.isEmpty
                ? const Center(child: Text('Your messages will show up here.'))
                : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    children: [
                      for (final message in _messages)
                        MessageBubble(message: message, isMine: true),
                    ],
                  ),
          ),
          MessageComposer(
            onSend: (message) => setState(() => _messages.add(message)),
          ),
        ],
      ),
    );
  }
}
