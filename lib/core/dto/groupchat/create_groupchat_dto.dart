import 'dart:io';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_user_from_create_groupchat_dto.dart';

class CreateGroupchatDto {
  String title;
  File? profileImage;
  String? description;
  List<CreateGroupchatUserFromCreateGroupchatDto>? groupchatUsers;

  CreateGroupchatDto({
    required this.title,
    this.profileImage,
    this.description,
    this.groupchatUsers,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {'title': title};

    if (description != null) {
      variables.addAll({'description': description!});
    }

    if (groupchatUsers != null && groupchatUsers!.isNotEmpty) {
      List<Map<dynamic, dynamic>> mappedUsers = [];
      for (final user in groupchatUsers!) {
        mappedUsers.add(user.toMap());
      }

      variables.addAll({'groupchatUsers': mappedUsers});
    }

    return variables;
  }
}
