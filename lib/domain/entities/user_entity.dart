class UserEntity {
  final String id;
  final String username;
  final String? email;

  UserEntity({
    required this.id,
    required this.username,
    this.email,
  });
}
