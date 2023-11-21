import 'dart:io';
import 'package:chattyevent_app_flutter/infrastructure/dto/groupchat/groupchat_user/create_groupchat_user_from_create_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/groupchat/create_groupchat_permissions_dto.dart';

class CreateGroupchatDto {
  final String title;
  final File? profileImage;
  final String? description;
  final CreateGroupchatPermissionsDto? permissions;
  final List<CreateGroupchatUserFromCreateGroupchatDto>? groupchatUsers;

  CreateGroupchatDto({
    required this.title,
    this.profileImage,
    this.permissions,
    this.description,
    this.groupchatUsers,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {'title': title};

    if (description != null) {
      map.addAll({'description': description!});
    }
    if (permissions != null) {
      map.addAll({"permissions": permissions!.toMap()});
    }

    if (groupchatUsers != null && groupchatUsers!.isNotEmpty) {
      List<Map<dynamic, dynamic>> mappedUsers = [];
      for (final user in groupchatUsers!) {
        mappedUsers.add(user.toMap());
      }

      map.addAll({'groupchatUsers': mappedUsers});
    }

    return map;
  }
}
