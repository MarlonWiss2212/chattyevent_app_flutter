import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_user/groupchat_user_role_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class CreateGroupchatUserFromCreateGroupchatDto {
  final String userId;
  final GroupchatUserRoleEnum? role;
  final String? usernameForChat;

  CreateGroupchatUserFromCreateGroupchatDto({
    required this.userId,
    this.usernameForChat,
    this.role,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'userId': userId,
    };

    if (role != null) {
      variables.addAll({'role': role!.value});
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
    super.role,
    super.usernameForChat,
  }) : super(userId: user.id);
}
