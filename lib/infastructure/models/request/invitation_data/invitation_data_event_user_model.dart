import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/invitation_data/invitation_data_event_user_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/event/event_model.dart';

class InvitationDataEventUserModel extends InvitationDataEventUserEntity {
  InvitationDataEventUserModel({
    required super.role,
    required super.event,
  });

  factory InvitationDataEventUserModel.fromJson(Map<String, dynamic> json) {
    return InvitationDataEventUserModel(
      event: EventModel.fromJson(json["event"]),
      role: EventUserRoleEnumExtension.fromValue(json["role"]),
    );
  }
}
