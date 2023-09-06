import 'package:chattyevent_app_flutter/domain/entities/request/invitation_data_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/request/invitation_data/invitation_data_event_user_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/request/invitation_data/invitation_data_groupchat_user_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user_model.dart';

class InvitationDataModel extends InvitationDataEntity {
  InvitationDataModel({
    required super.invitedUser,
    super.eventUser,
    super.groupchatUser,
  });

  factory InvitationDataModel.fromJson(Map<String, dynamic> json) {
    return InvitationDataModel(
      invitedUser: UserModel.fromJson(json["invitedUser"]),
      eventUser: json["eventUser"] != null
          ? InvitationDataEventUserModel.fromJson(json["eventUser"])
          : null,
      groupchatUser: json["groupchatUser"] != null
          ? InvitationDataGroupchatUserModel.fromJson(json["groupchatUser"])
          : null,
    );
  }
}
