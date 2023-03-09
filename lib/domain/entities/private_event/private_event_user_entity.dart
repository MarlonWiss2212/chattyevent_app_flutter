class PrivateEventUserEntity {
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  String? privateEventTo;
  String? status;

  PrivateEventUserEntity({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
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
      userId: newEntity.userId ?? oldEntity.userId,
      privateEventTo: newEntity.privateEventTo ?? oldEntity.privateEventTo,
      status: newEntity.status ?? oldEntity.status,
    );
  }
}
