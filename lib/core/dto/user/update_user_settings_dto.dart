import 'package:chattyevent_app_flutter/core/dto/user/update_user_settings/update_on_accept_standard_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/user/update_user_settings/update_overwriting_standard_dto.dart';

class UpdateUserSettingsDto {
  final UpdateOverwritingStandardDto? overwritingStandard;
  final UpdateOnAcceptStandardDto? onAcceptStandard;

  // TODO make this right
  final dynamic beforeCreateStandard;

  UpdateUserSettingsDto({
    this.overwritingStandard,
    this.beforeCreateStandard,
    this.onAcceptStandard,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (overwritingStandard != null) {
      variables.addAll({"overwritingStandard": overwritingStandard!.toMap()});
    }
    if (onAcceptStandard != null) {
      variables.addAll({"onAcceptStandard": onAcceptStandard!.toMap()});
    }
    // if (beforeCreateStandard != null) {
    //  variables.addAll({"beforeCreateStandard": beforeCreateStandard!.toMap()});
    //}
    return variables;
  }
}
