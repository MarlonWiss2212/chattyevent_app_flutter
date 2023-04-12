import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';

/// this will only be used for the current cubit
class UserWithPrivateEventUserData {
  final GroupchatUserEntity? groupchatUser;
  final PrivateEventUserEntity privateEventUser;

  UserWithPrivateEventUserData({
    this.groupchatUser,
    required this.privateEventUser,
  });

  String getUsername() {
    if (groupchatUser != null && groupchatUser!.usernameForChat != null) {
      return groupchatUser!.usernameForChat!;
    }
    if (groupchatUser != null && groupchatUser!.username != null) {
      return groupchatUser!.username!;
    }
    return "Kein Username";
  }
}
