import 'package:chattyevent_app_flutter/domain/entities/request/invitation_data/invitation_data_event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/invitation_data/invitation_data_groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class InvitationDataEntity {
  final UserEntity invitedUser;
  final InvitationDataEventUserEntity? eventUser;
  final InvitationDataGroupchatUserEntity? groupchatUser;

  InvitationDataEntity({
    required this.invitedUser,
    this.eventUser,
    this.groupchatUser,
  });
}
