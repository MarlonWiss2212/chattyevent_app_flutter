import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';

class GroupchatAddUserResponse {
  final RequestEntity? request;
  final GroupchatUserEntity? groupchatUser;

  GroupchatAddUserResponse({
    this.groupchatUser,
    this.request,
  });
}
