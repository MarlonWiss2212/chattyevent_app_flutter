class PrivateEventUserEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userId;
  final String? privateEventTo;
  final String? status;
  final bool? organizer;

  PrivateEventUserEntity({
    required this.id,
    this.createdAt,
    this.organizer,
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
      organizer: newEntity.organizer ?? oldEntity.organizer,
    );
  }
}
