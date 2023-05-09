import 'dart:io';

import 'package:chattyevent_app_flutter/core/dto/user/update_user_settings_dto.dart';

class UpdateUserDto {
  final File? updateProfileImage;
  final String? firstname;
  final String? lastname;
  final String? username;
  final UpdateUserSettingsDto? settings;

  UpdateUserDto({
    this.updateProfileImage,
    this.firstname,
    this.lastname,
    this.username,
    this.settings,
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
    if (settings != null) {
      variables.addAll({"settings": settings!.toMap()});
    }
    return variables;
  }
}
