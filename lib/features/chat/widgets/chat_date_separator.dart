import 'package:flutter/material.dart';

import '../../../core/utils/date_formatter.dart';

class ChatDateSeparator extends StatelessWidget {
  const ChatDateSeparator({required this.date, super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final localDate = date.toLocal();
    final isToday =
        today.year == localDate.year &&
        today.month == localDate.month &&
        today.day == localDate.day;
    final yesterday = DateTime(today.year, today.month, today.day - 1);
    final isYesterday =
        yesterday.year == localDate.year &&
        yesterday.month == localDate.month &&
        yesterday.day == localDate.day;
    final label = isToday
        ? 'Today'
        : isYesterday
        ? 'Yesterday'
        : DateFormatter.shortDate(localDate);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(label, style: Theme.of(context).textTheme.labelSmall),
          ),
        ),
      ),
    );
  }
}
