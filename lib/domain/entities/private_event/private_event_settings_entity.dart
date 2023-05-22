import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_permission_enum.dart';

class PrivateEventSettingsEntity {
  PrivateEventPermissionEnum? changeDatePermission;
  PrivateEventPermissionEnum? changeDescriptionPermission;
  PrivateEventPermissionEnum? changeAddressPermission;
  PrivateEventPermissionEnum? changeStatusPermission;
  PrivateEventPermissionEnum? addUsersPermission;
  PrivateEventPermissionEnum? addShoppingListItemPermission;

  PrivateEventSettingsEntity({
    this.changeDatePermission,
    this.changeDescriptionPermission,
    this.changeAddressPermission,
    this.changeStatusPermission,
    this.addUsersPermission,
    this.addShoppingListItemPermission,
  });

  factory PrivateEventSettingsEntity.merge({
    required PrivateEventSettingsEntity newEntity,
    required PrivateEventSettingsEntity oldEntity,
  }) {
    return PrivateEventSettingsEntity(
      changeDatePermission:
          newEntity.changeDatePermission ?? oldEntity.changeDatePermission,
      changeDescriptionPermission: newEntity.changeDescriptionPermission ??
          oldEntity.changeDescriptionPermission,
      changeAddressPermission: newEntity.changeAddressPermission ??
          oldEntity.changeAddressPermission,
      changeStatusPermission:
          newEntity.changeStatusPermission ?? oldEntity.changeStatusPermission,
      addUsersPermission:
          newEntity.addUsersPermission ?? oldEntity.addUsersPermission,
      addShoppingListItemPermission: newEntity.addShoppingListItemPermission ??
          oldEntity.addShoppingListItemPermission,
    );
  }
}
