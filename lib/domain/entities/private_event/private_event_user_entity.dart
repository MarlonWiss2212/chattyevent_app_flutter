class PrivateEventUserEntity {
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? authId;
  String? privateEventTo;
  bool? isInvitedIndependetFromGroupchat;
  String? status;

  PrivateEventUserEntity({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.authId,
    this.isInvitedIndependetFromGroupchat,
    this.privateEventTo,
    this.status,
  });

  factory PrivateEventUserEntity.merge({
    required PrivateEventUserEntity newEntity,
    required PrivateEventUserEntity oldEntity,
  }) {
    return PrivateEventUserEntity(
      id: newEntity.id,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
      authId: newEntity.authId ?? oldEntity.authId,
      privateEventTo: newEntity.privateEventTo ?? oldEntity.privateEventTo,
      isInvitedIndependetFromGroupchat:
          newEntity.isInvitedIndependetFromGroupchat ??
              oldEntity.isInvitedIndependetFromGroupchat,
      status: newEntity.status ?? oldEntity.status,
    );
  }
}
