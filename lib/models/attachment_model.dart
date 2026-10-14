class AttachmentModel {
  const AttachmentModel({
    required this.id,
    required this.messageId,
    required this.fileName,
    required this.storagePath,
    required this.contentType,
    required this.sizeBytes,
    required this.createdAt,
  });

  final String id;
  final String messageId;
  final String fileName;
  final String storagePath;
  final String contentType;
  final int sizeBytes;
  final DateTime createdAt;

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'] as String,
      messageId: json['message_id'] as String,
      fileName: json['file_name'] as String,
      storagePath: json['storage_path'] as String,
      contentType: json['content_type'] as String,
      sizeBytes: (json['size_bytes'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message_id': messageId,
      'file_name': fileName,
      'storage_path': storagePath,
      'content_type': contentType,
      'size_bytes': sizeBytes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
