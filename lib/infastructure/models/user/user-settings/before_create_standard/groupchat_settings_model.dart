import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/before_create_standard/groupchat_settings_entity.dart';

class BeforeCreateStandardGroupchatSettingsModel
    extends BeforeCreateStandardGroupchatSettingsEntity {
  BeforeCreateStandardGroupchatSettingsModel({
    super.addEventToGroupchatPermission,
    super.addUsersPermission,
    super.changeDescriptionPermission,
    super.changeTitlePermission,
  });

  factory BeforeCreateStandardGroupchatSettingsModel.fromJson(
      Map<String, dynamic> json) {
    return BeforeCreateStandardGroupchatSettingsModel(
      addEventToGroupchatPermission:
          json["addEventToGroupchatPermission"] != null
              ? GroupchatPermissionEnumExtension.fromValue(
                  json["addEventToGroupchatPermission"])
              : null,
      addUsersPermission: json["addUsersPermission"] != null
          ? GroupchatPermissionEnumExtension.fromValue(
              json["addUsersPermission"])
          : null,
      changeDescriptionPermission: json["changeDescriptionPermission"] != null
          ? GroupchatPermissionEnumExtension.fromValue(
              json["changeDescriptionPermission"])
          : null,
      changeTitlePermission: json["changeTitlePermission"] != null
          ? GroupchatPermissionEnumExtension.fromValue(
              json["changeTitlePermission"])
          : null,
    );
  }
}
