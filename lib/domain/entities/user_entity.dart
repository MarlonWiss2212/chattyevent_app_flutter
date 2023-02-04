class UserEntity {
  final String id;
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
}
