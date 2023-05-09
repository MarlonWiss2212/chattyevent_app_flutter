class MessageEntity {
  final String id;
  final String? message;
  final String? fileLink;
  final String? messageToReactTo;
  final String? createdBy;
  final DateTime? updatedAt;
  final DateTime createdAt;

  MessageEntity({
    required this.id,
    required this.createdAt,
    this.message,
    this.fileLink,
    this.messageToReactTo,
    this.createdBy,
    this.updatedAt,
  });

  factory MessageEntity.merge({
    required MessageEntity newEntity,
    required MessageEntity oldEntity,
  }) {
    return MessageEntity(
      id: newEntity.id,
      message: newEntity.message ?? oldEntity.message,
      fileLink: newEntity.fileLink ?? oldEntity.fileLink,
      messageToReactTo:
          newEntity.messageToReactTo ?? oldEntity.messageToReactTo,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
