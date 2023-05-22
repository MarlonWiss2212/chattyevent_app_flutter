import 'package:chattyevent_app_flutter/core/dto/user/update_user_settings/update-on-accept-standard/update_follow_data_dto.dart';

class UpdateOnAcceptStandardDto {
  final UpdateOnAcceptStandardUpdateFollowDataDto? followData;

  UpdateOnAcceptStandardDto({this.followData});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (followData != null) {
      variables.addAll({"followData": followData!.toMap()});
    }

    return variables;
  }
}
