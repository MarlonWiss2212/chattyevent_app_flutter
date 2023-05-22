import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/before_create_standard_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user-settings/before_create_standard/groupchat_settings_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user-settings/before_create_standard/private_event_settings_model.dart';

class BeforeCreateStandardModel extends BeforeCreateStandardEntity {
  BeforeCreateStandardModel({
    super.groupchatSettings,
    super.privateEventSettings,
  });

  factory BeforeCreateStandardModel.fromJson(Map<String, dynamic> json) {
    return BeforeCreateStandardModel(
      groupchatSettings: json['groupchatSettings'] != null
          ? BeforeCreateStandardGroupchatSettingsModel.fromJson(
              json['groupchatSettings'],
            )
          : null,
      privateEventSettings: json['privateEventSettings'] != null
          ? BeforeCreateStandardPrivateEventSettingsModel.fromJson(
              json['privateEventSettings'],
            )
          : null,
    );
  }
}
