import 'dart:io';

class UpdateUserDto {
  final File? updateProfileImage;
  final String? firstname;
  final String? lastname;
  final String? username;

  UpdateUserDto({
    this.updateProfileImage,
    this.firstname,
    this.lastname,
    this.username,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (firstname != null) {
      variables.addAll({"firstname": firstname});
    }
    if (lastname != null) {
      variables.addAll({"lastname": lastname});
    }
    if (username != null) {
      variables.addAll({"username": username});
    }
    return variables;
  }
}
