import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_user/groupchat_user_role_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';

class InvitationDataGroupchatUserEntity {
  final GroupchatUserRoleEnum role;
  final GroupchatEntity groupchat;

  InvitationDataGroupchatUserEntity({
    required this.groupchat,
    required this.role,
  });
}
