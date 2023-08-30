import 'dart:io';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions.dart';

class UpdateUserDto {
  final File? updateProfileImage;
  final bool? removeProfileImage;
  final String? username;
  final UpdateUserPermissionsDto? permissions;

  UpdateUserDto({
    this.updateProfileImage,
    this.username,
    this.removeProfileImage,
    this.permissions,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (username != null) {
      variables.addAll({"username": username});
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
