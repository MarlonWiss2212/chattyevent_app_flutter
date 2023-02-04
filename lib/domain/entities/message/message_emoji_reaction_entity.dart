class MessageEmojiReactionEntity {
  final String id;
  final String? emoji;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;

  MessageEmojiReactionEntity({
    required this.id,
    this.emoji,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });
}
