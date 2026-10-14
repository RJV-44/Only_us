import 'package:flutter/material.dart';

enum MessageStatus { sending, sent, delivered, read, failed }

class MessageStatusIcon extends StatelessWidget {
  const MessageStatusIcon({required this.status, super.key});

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      MessageStatus.failed => Theme.of(context).colorScheme.error,
      _ => Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.8),
    };
    final icon = switch (status) {
      MessageStatus.sending => Icons.schedule,
      MessageStatus.sent => Icons.check,
      MessageStatus.delivered || MessageStatus.read => Icons.done_all,
      MessageStatus.failed => Icons.error_outline,
    };
    final resolvedColor = status == MessageStatus.read
        ? Theme.of(context).colorScheme.tertiary
        : color;

    return Icon(
      icon,
      size: 16,
      color: resolvedColor,
      semanticLabel: switch (status) {
        MessageStatus.sending => 'Sending',
        MessageStatus.sent => 'Sent',
        MessageStatus.delivered => 'Delivered',
        MessageStatus.read => 'Read',
        MessageStatus.failed => 'Failed to send',
      },
    );
  }
}
