import 'package:chattyevent_app_flutter/core/enums/event/event_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_permissions_entity.dart';

class EventPermissionsModel extends EventPermissionsEntity {
  EventPermissionsModel({
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

  factory EventPermissionsModel.fromJson(Map<String, dynamic> json) {
    return EventPermissionsModel(
      changeDescription: json["changeDescription"] != null
          ? EventPermissionEnumExtension.fromValue(json["changeDescription"])
          : null,
      changeAddress: json["changeAddress"] != null
          ? EventPermissionEnumExtension.fromValue(json["changeAddress"])
          : null,
      changeTitle: json["changeTitle"] != null
          ? EventPermissionEnumExtension.fromValue(json["changeTitle"])
          : null,
      changeCoverImage: json["changeCoverImage"] != null
          ? EventPermissionEnumExtension.fromValue(json["changeCoverImage"])
          : null,
      changeStatus: json["changeStatus"] != null
          ? EventPermissionEnumExtension.fromValue(json["changeStatus"])
          : null,
      changeDate: json["changeDate"] != null
          ? EventPermissionEnumExtension.fromValue(json["changeDate"])
          : null,
      addShoppingListItem: json["addShoppingListItem"] != null
          ? EventPermissionEnumExtension.fromValue(json["addShoppingListItem"])
          : null,
      updateShoppingListItem: json["updateShoppingListItem"] != null
          ? EventPermissionEnumExtension.fromValue(
              json["updateShoppingListItem"])
          : null,
      deleteShoppingListItem: json["deleteShoppingListItem"] != null
          ? EventPermissionEnumExtension.fromValue(
              json["deleteShoppingListItem"])
          : null,
      addUsers: json["addUsers"] != null
          ? EventPermissionEnumExtension.fromValue(json["addUsers"])
          : null,
    );
  }
}
