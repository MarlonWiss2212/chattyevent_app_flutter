class MessageEntity {
  final String id;
  final String? message;
  final List<String>? fileLinks;
  final String? messageToReactTo;
  final String? createdBy;
  final DateTime? updatedAt;
  final DateTime createdAt;
  final String? groupchatTo;
  final String? privateEventTo;
  final String? userTo;

  MessageEntity({
    required this.id,
    this.groupchatTo,
    this.privateEventTo,
    this.userTo,
    required this.createdAt,
    this.message,
    this.fileLinks,
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
      fileLinks: newEntity.fileLinks ?? oldEntity.fileLinks,
      groupchatTo: newEntity.groupchatTo ?? oldEntity.groupchatTo,
      userTo: newEntity.userTo ?? oldEntity.userTo,
      privateEventTo: newEntity.privateEventTo ?? oldEntity.privateEventTo,
      messageToReactTo:
          newEntity.messageToReactTo ?? oldEntity.messageToReactTo,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
