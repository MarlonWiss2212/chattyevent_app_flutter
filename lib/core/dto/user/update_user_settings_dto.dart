import 'package:chattyevent_app_flutter/core/dto/user/update_on_accept_follow_request_standard_follow_data_dto.dart';

class UpdateUserSettingsDto {
  final UpdateOnAcceptFollowRequestStandardFollowDataDto?
      onAcceptFollowRequestStandardFollowData;

  UpdateUserSettingsDto({this.onAcceptFollowRequestStandardFollowData});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (onAcceptFollowRequestStandardFollowData != null) {
      variables.addAll({
        "onAcceptFollowRequestStandardFollowData":
            onAcceptFollowRequestStandardFollowData!.toMap()
      });
    }
    return variables;
  }
}
