class PrivateEventLeftUserEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userId;
  final String? privateEventTo;

  PrivateEventLeftUserEntity({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.privateEventTo,
  });

  factory PrivateEventLeftUserEntity.merge({
    required PrivateEventLeftUserEntity newEntity,
    required PrivateEventLeftUserEntity oldEntity,
  }) {
    return PrivateEventLeftUserEntity(
      id: newEntity.id,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
      userId: newEntity.userId ?? oldEntity.userId,
      privateEventTo: newEntity.privateEventTo ?? oldEntity.privateEventTo,
    );
  }
}
