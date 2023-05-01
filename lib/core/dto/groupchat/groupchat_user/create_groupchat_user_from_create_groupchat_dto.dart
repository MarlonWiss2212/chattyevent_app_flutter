import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';

class CreateGroupchatUserFromCreateGroupchatDto {
  final String userId;
  final bool? admin;
  final String? usernameForChat;

  CreateGroupchatUserFromCreateGroupchatDto({
    required this.userId,
    this.usernameForChat,
    this.admin,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'userId': userId,
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

class CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity
    extends CreateGroupchatUserFromCreateGroupchatDto {
  final UserEntity user;

  CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity({
    required this.user,
    super.admin,
    super.usernameForChat,
  }) : super(userId: user.id);
}
