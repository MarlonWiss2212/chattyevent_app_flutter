import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';

class GroupchatMessageEntity extends MessageEntity {
  final String? groupchatTo;
  GroupchatMessageEntity({
    required super.id,
    required super.createdAt,
    super.message,
    super.fileLinks,
    this.groupchatTo,
    super.messageToReactTo,
    super.createdBy,
    super.updatedAt,
  });

  factory GroupchatMessageEntity.merge({
    required GroupchatMessageEntity newEntity,
    required GroupchatMessageEntity oldEntity,
  }) {
    return GroupchatMessageEntity(
      id: newEntity.id,
      message: newEntity.message ?? oldEntity.message,
      fileLinks: newEntity.fileLinks ?? oldEntity.fileLinks,
      groupchatTo: newEntity.groupchatTo ?? oldEntity.groupchatTo,
      messageToReactTo:
          newEntity.messageToReactTo ?? oldEntity.messageToReactTo,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
