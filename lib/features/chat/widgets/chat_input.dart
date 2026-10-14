import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({required this.onSend, this.isSending = false, super.key});

  final Future<bool> Function(String) onSend;
  final bool isSending;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (widget.isSending) return;
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final sent = await widget.onSend(text);
    if (sent && mounted) _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: !widget.isSending,
                maxLength: AppConstants.maximumMessageLength,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _send(),
                decoration: const InputDecoration(
                  hintText: 'Write a message',
                  prefixIcon: Icon(Icons.chat_bubble_outline),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: widget.isSending ? null : _send,
              tooltip: 'Send message',
              icon: widget.isSending
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
