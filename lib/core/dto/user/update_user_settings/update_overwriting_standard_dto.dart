import 'package:chattyevent_app_flutter/core/dto/user/update_user_settings/update-overwriting-standard/update_follow_data_dto.dart';

class UpdateOverwritingStandardDto {
  final UpdateOverwritingStandardUpdateFollowDataDto? followData;

  UpdateOverwritingStandardDto({this.followData});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (followData != null) {
      variables.addAll({"followData": followData!.toMap()});
    }

    return variables;
  }
}
