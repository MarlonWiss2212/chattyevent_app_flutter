import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

class CreateGroupchatUserFromCreateGroupchatDto {
  String authId;
  bool? admin;
  String? usernameForChat;

  CreateGroupchatUserFromCreateGroupchatDto({
    required this.authId,
    this.usernameForChat,
    this.admin,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'authId': authId,
    };

    if (admin != null) {
      variables.addAll({'admin': admin});
    }
    if (usernameForChat != null) {
      variables.addAll({'usernameForChat': usernameForChat});
    }

    return variables;
  }
}

/// use this for lists to get the username
class CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity
    extends CreateGroupchatUserFromCreateGroupchatDto {
  UserEntity user;

  CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity({
    required this.user,
    super.admin,
    super.usernameForChat,
  }) : super(authId: user.authId);
}
