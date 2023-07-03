import 'dart:io';

class CreateUserDto {
  final File? profileImage;
  final String firstname;
  final String lastname;
  final String username;
  final DateTime birthdate;

  CreateUserDto({
    this.profileImage,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.birthdate,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'birthdate': birthdate.toIso8601String(),
    };
    return variables;
  }
}
