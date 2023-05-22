import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_settings_entity.dart';

class BeforeCreateStandardPrivateEventSettingsEntity
    extends PrivateEventSettingsEntity {
  BeforeCreateStandardPrivateEventSettingsEntity({
    super.addShoppingListItemPermission,
    super.addUsersPermission,
    super.changeDescriptionPermission,
    super.changeAddressPermission,
    super.changeDatePermission,
    super.changeStatusPermission,
  });
}
