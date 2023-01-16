import 'dart:io';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';

class CreateGroupchatDto {
  String title;
  File? profileImage;
  String? description;
  List<CreateUserGroupchatDto>? users;

  CreateGroupchatDto({
    required this.title,
    this.profileImage,
    this.description,
    this.users,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {'title': title};

    if (description != null) {
      variables.addAll({'description': description!});
    }

    if (users != null && users!.isNotEmpty) {
      List<Map<dynamic, dynamic>> mappedUsers = [];
      for (final user in users!) {
        mappedUsers.add(user.toMap());
      }

      variables.addAll({'users': mappedUsers});
    }

    return variables;
  }
}
