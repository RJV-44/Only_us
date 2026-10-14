class ConversationModel {
  const ConversationModel({
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

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      participantIds: (json['participant_ids'] as List<dynamic>)
          .map((id) => id as String)
          .toList(growable: false),
      lastMessage: json['last_message'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'participant_ids': participantIds,
      'last_message': lastMessage,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
