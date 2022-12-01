class MessageEntity {
  final String id;
  final String? message;
  final String? fileLink;
  final String? groupchatTo;
  final String? messageToReactTo;
  final dynamic emojiReactions;
  final String? createdBy;
  final String? createdAt;

  MessageEntity({
    required this.id,
    this.message,
    this.fileLink,
    this.groupchatTo,
    this.messageToReactTo,
    this.emojiReactions,
    this.createdBy,
    this.createdAt,
  });
}
