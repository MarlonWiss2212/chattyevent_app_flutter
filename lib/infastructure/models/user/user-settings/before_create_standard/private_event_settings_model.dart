import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_permission_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/models/private_event/private_event_settings_model.dart';

class BeforeCreateStandardPrivateEventSettingsModel
    extends PrivateEventSettingsModel {
  BeforeCreateStandardPrivateEventSettingsModel({
    super.changeDatePermission,
    super.changeDescriptionPermission,
    super.changeAddressPermission,
    super.changeStatusPermission,
    super.addUsersPermission,
    super.addShoppingListItemPermission,
  });
  factory BeforeCreateStandardPrivateEventSettingsModel.fromJson(
      Map<String, dynamic> json) {
    return BeforeCreateStandardPrivateEventSettingsModel(
      changeDatePermission: json["changeDatePermission"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(
              json["changeDatePermission"])
          : null,
      changeAddressPermission: json["changeAddressPermission"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(
              json["changeAddressPermission"])
          : null,
      changeDescriptionPermission: json["changeDescriptionPermission"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(
              json["changeDescriptionPermission"])
          : null,
      changeStatusPermission: json["changeStatusPermission"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(
              json["changeStatusPermission"])
          : null,
      addUsersPermission: json["addUsersPermission"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(
              json["addUsersPermission"])
          : null,
      addShoppingListItemPermission:
          json["addShoppingListItemPermission"] != null
              ? PrivateEventPermissionEnumExtension.fromValue(
                  json["addShoppingListItemPermission"])
              : null,
    );
  }
}
