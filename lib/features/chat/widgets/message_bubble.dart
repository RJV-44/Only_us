import 'package:flutter/material.dart';

import 'message_status_icon.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    required this.isMine,
    this.subtitle,
    this.status,
    super.key,
  });

  final String message;
  final bool isMine;
  final String? subtitle;
  final MessageStatus? status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMine ? colors.primary : colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style:
                  TextStyle(color: isMine ? colors.onPrimary : colors.onSurface),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: isMine
                          ? colors.onPrimary.withValues(alpha: 0.75)
                          : colors.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                  if (isMine && status != null) ...[
                    const SizedBox(width: 4),
                    MessageStatusIcon(status: status!),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
