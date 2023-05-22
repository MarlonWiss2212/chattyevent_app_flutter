import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_settings_entity.dart';

class BeforeCreateStandardGroupchatSettingsEntity
    extends GroupchatSettingsEntity {
  BeforeCreateStandardGroupchatSettingsEntity({
    super.addEventToGroupchatPermission,
    super.addUsersPermission,
    super.changeDescriptionPermission,
    super.changeTitlePermission,
  });
}
