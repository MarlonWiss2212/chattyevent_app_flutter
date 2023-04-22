import 'package:social_media_app_flutter/core/response/groupchat/groupchat-users-and-left-users.response.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';

class GroupchatAndGroupchatUsersResponse
    extends GroupchatUsersAndLeftUsersResponse {
  final GroupchatEntity groupchat;

  GroupchatAndGroupchatUsersResponse({
    required this.groupchat,
    required super.groupchatUsers,
    required super.groupchatLeftUsers,
  });
}
