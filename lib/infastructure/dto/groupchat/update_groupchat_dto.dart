import 'dart:io';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/update_groupchat_permissions_dto.dart';

class UpdateGroupchatDto {
  final String? title;
  final String? description;
  final UpdateGroupchatPermissionsDto? permissions;
  final File? updateProfileImage;
  final bool? removeProfileImage;

  UpdateGroupchatDto({
    this.title,
    this.removeProfileImage,
    this.permissions,
    this.updateProfileImage,
    this.description,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (title != null) {
      map.addAll({'title': title!});
    }
    if (removeProfileImage != null) {
      map.addAll({'removeProfileImage': removeProfileImage});
    }
    if (permissions != null) {
      map.addAll({'permissions': permissions!.toMap()});
    }
    if (description != null) {
      map.addAll({'description': description!});
    }

    return map;
  }
}
