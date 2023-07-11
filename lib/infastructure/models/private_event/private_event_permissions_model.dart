import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_permissions_entity.dart';

class PrivateEventPermissionsModel extends PrivateEventPermissionsEntity {
  PrivateEventPermissionsModel({
    super.changeAddress,
    super.changeDescription,
    super.changeTitle,
    super.changeCoverImage,
    super.changeDate,
    super.changeStatus,
    super.addShoppingListItem,
    super.updateShoppingListItem,
    super.deleteShoppingListItem,
    super.addUsers,
  });

  factory PrivateEventPermissionsModel.fromJson(Map<String, dynamic> json) {
    return PrivateEventPermissionsModel(
      changeDescription: json["changeDescription"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(
              json["changeDescription"])
          : null,
      changeAddress: json["changeAddress"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(json["changeAddress"])
          : null,
      changeTitle: json["changeTitle"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(json["changeTitle"])
          : null,
      changeCoverImage: json["changeCoverImage"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(
              json["changeCoverImage"])
          : null,
      changeStatus: json["changeStatus"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(json["changeStatus"])
          : null,
      changeDate: json["changeDate"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(json["changeDate"])
          : null,
      addShoppingListItem: json["addShoppingListItem"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(
              json["addShoppingListItem"])
          : null,
      updateShoppingListItem: json["updateShoppingListItem"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(
              json["updateShoppingListItem"])
          : null,
      deleteShoppingListItem: json["deleteShoppingListItem"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(
              json["deleteShoppingListItem"])
          : null,
      addUsers: json["addUsers"] != null
          ? PrivateEventPermissionEnumExtension.fromValue(json["addUsers"])
          : null,
    );
  }
}
