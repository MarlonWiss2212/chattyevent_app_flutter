import 'dart:io';

class CreateUserDto {
  final File? profileImage;
  final String username;
  final DateTime birthdate;

  CreateUserDto({
    this.profileImage,
    required this.username,
    required this.birthdate,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'username': username,
      'birthdate': birthdate.toIso8601String(),
    };
    return variables;
  }
}
