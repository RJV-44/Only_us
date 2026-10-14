class Conversation {
  const Conversation({
    required this.id,
    required this.title,
    required this.participantIds,
    this.lastMessage,
    this.updatedAt,
  });

  final String id;
  final String title;
  final List<String> participantIds;
  final String? lastMessage;
  final DateTime? updatedAt;
}
