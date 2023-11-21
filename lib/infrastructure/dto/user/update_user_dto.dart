import 'dart:io';
import 'package:chattyevent_app_flutter/infrastructure/dto/user/update_user_permissions.dart';

class UpdateUserDto {
  final File? updateProfileImage;
  final bool? removeProfileImage;
  final String? username;
  final DateTime? birthdate;
  final UpdateUserPermissionsDto? permissions;

  UpdateUserDto({
    this.updateProfileImage,
    this.username,
    this.birthdate,
    this.removeProfileImage,
    this.permissions,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (username != null) {
      variables.addAll({"username": username});
    }
    if (birthdate != null) {
      variables.addAll({"birthdate": birthdate!.toIso8601String()});
    }
    if (removeProfileImage != null) {
      variables.addAll({"removeProfileImage": removeProfileImage});
    }
    if (permissions != null) {
      variables.addAll({"permissions": permissions!.toMap()});
    }
    return variables;
  }
}
