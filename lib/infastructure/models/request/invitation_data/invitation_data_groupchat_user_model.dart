import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_user/groupchat_user_role_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/invitation_data/invitation_data_groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_model.dart';

class InvitationDataGroupchatUserModel
    extends InvitationDataGroupchatUserEntity {
  InvitationDataGroupchatUserModel({
    required super.role,
    required super.groupchat,
  });

  factory InvitationDataGroupchatUserModel.fromJson(Map<String, dynamic> json) {
    return InvitationDataGroupchatUserModel(
      groupchat: GroupchatModel.fromJson(json["groupchat"]),
      role: GroupchatUserRoleEnumExtension.fromValue(json["role"]),
    );
  }
}
