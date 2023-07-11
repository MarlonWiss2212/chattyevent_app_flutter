import 'dart:io';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/update_groupchat_permissions_dto%20copy.dart';

class UpdateGroupchatDto {
  final String? title;
  final String? description;
  final UpdateGroupchatPermissionsDto? permissions;
  final File? updateProfileImage;

  UpdateGroupchatDto({
    this.title,
    this.permissions,
    this.updateProfileImage,
    this.description,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (title != null) {
      map.addAll({'title': title!});
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
