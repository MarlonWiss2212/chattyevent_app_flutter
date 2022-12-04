class MessageEmojiReactionEntity {
  final String id;
  final String? emoji;
  final String? createdAt;
  final String? createdBy;

  MessageEmojiReactionEntity({
    required this.id,
    this.emoji,
    this.createdBy,
    this.createdAt,
  });
}
