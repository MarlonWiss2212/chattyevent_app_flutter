class UserEntity {
  final String id;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? emailVerified;
  final String? birthdate;
  final String? lastTimeOnline;
  final DateTime? createdAt;

  UserEntity({
    required this.id,
    this.username,
    this.email,
    this.emailVerified,
    this.firstname,
    this.lastname,
    this.birthdate,
    this.lastTimeOnline,
    this.createdAt,
  });
}
