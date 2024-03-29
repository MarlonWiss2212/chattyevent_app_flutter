import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_user/groupchat_user_role_enum.dart';

class UpdateGroupchatUserDto {
  final GroupchatUserRoleEnum? role;
  final String? usernameForChat;
  final bool? removeUsernameForChat;

  UpdateGroupchatUserDto({
    this.role,
    this.usernameForChat,
    this.removeUsernameForChat,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (role != null) {
      map.addAll({'role': role!.value});
    }
    if (usernameForChat != null) {
      map.addAll({'usernameForChat': usernameForChat});
    }
    if (removeUsernameForChat != null) {
      map.addAll({'removeUsernameForChat': removeUsernameForChat});
    }

    return map;
  }
}
