class UserEntity {
  final String id;
  final String authId;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? emailVerified;
  final String? profileImageLink;
  final String? birthdate;
  final String? lastTimeOnline;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.authId,
    this.username,
    this.email,
    this.emailVerified,
    this.profileImageLink,
    this.firstname,
    this.lastname,
    this.birthdate,
    this.lastTimeOnline,
    this.createdAt,
    this.updatedAt,
  });

  factory UserEntity.merge({
    required UserEntity newEntity,
    required UserEntity oldEntity,
  }) {
    return UserEntity(
      authId: newEntity.authId,
      id: newEntity.id,
      username: newEntity.username ?? oldEntity.username,
      email: newEntity.email ?? oldEntity.email,
      emailVerified: newEntity.emailVerified ?? oldEntity.emailVerified,
      profileImageLink:
          newEntity.profileImageLink ?? oldEntity.profileImageLink,
      firstname: newEntity.firstname ?? oldEntity.firstname,
      lastname: newEntity.lastname ?? oldEntity.lastname,
      birthdate: newEntity.birthdate ?? oldEntity.birthdate,
      lastTimeOnline: newEntity.lastTimeOnline ?? oldEntity.lastTimeOnline,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
