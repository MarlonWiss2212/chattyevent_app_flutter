import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';

class CreateGroupchatDto {
  String title;
  String? profileImageLink;
  String? description;
  List<CreateUserGroupchatDto>? users;
  String? chatColorCode;

  CreateGroupchatDto({
    required this.title,
    this.profileImageLink,
    this.description,
    this.users,
    this.chatColorCode,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {'title': title};

    if (profileImageLink != null) {
      variables.addAll({'profileImageLink': profileImageLink!});
    }

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

    if (chatColorCode != null) {
      variables.addAll({'chatColorCode': chatColorCode!});
    }

    return variables;
  }
}
