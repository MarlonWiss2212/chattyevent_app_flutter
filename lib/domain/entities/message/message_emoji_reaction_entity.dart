/// implement this at a later date
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

  factory MessageEmojiReactionEntity.merge({
    required MessageEmojiReactionEntity newEntity,
    required MessageEmojiReactionEntity oldEntity,
  }) {
    return MessageEmojiReactionEntity(
      id: newEntity.id,
      emoji: newEntity.emoji ?? oldEntity.emoji,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
