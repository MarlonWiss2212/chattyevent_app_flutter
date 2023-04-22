import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';

class GroupchatUsersAndLeftUsersResponse {
  final List<GroupchatUserEntity> groupchatUsers;
  final List<GroupchatLeftUserEntity> groupchatLeftUsers;

  GroupchatUsersAndLeftUsersResponse({
    required this.groupchatUsers,
    required this.groupchatLeftUsers,
  });
}
