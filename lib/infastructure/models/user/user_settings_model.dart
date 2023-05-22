import 'package:chattyevent_app_flutter/domain/entities/user/user_settings_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user-settings/before_create_standard_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user-settings/on_accept_standard_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user-settings/overwriting_standard_model.dart';

class UserSettingsModel extends UserSettingsEntity {
  UserSettingsModel({
    super.beforeCreateStandard,
    super.onAcceptStandard,
    super.overwritingStandard,
  });

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      onAcceptStandard: json['onAcceptStandard'] != null
          ? OnAcceptStandardModel.fromJson(json['onAcceptStandard'])
          : null,
      overwritingStandard: json['overwritingStandard'] != null
          ? OverwritingStandardModel.fromJson(json['overwritingStandard'])
          : null,
      beforeCreateStandard: json['beforeCreateStandard'] != null
          ? BeforeCreateStandardModel.fromJson(
              json['beforeCreateStandard'],
            )
          : null,
    );
  }
}
