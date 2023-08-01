import 'dart:io';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions.dart';

class UpdateUserDto {
  final File? updateProfileImage;
  final String? username;
  final UpdateUserPermissionsDto? permissions;

  UpdateUserDto({
    this.updateProfileImage,
    this.username,
    this.permissions,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (username != null) {
      variables.addAll({"username": username});
    }
    if (permissions != null) {
      variables.addAll({"permissions": permissions!.toMap()});
    }
    return variables;
  }
}
