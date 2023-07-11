import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_permission_enum.dart';

class PrivateEventPermissionsEntity {
  final PrivateEventPermissionEnum? changeTitle;
  final PrivateEventPermissionEnum? changeDescription;
  final PrivateEventPermissionEnum? changeCoverImage;
  final PrivateEventPermissionEnum? changeAddress;
  final PrivateEventPermissionEnum? changeDate;
  final PrivateEventPermissionEnum? changeStatus;
  final PrivateEventPermissionEnum? addUsers;
  final PrivateEventPermissionEnum? addShoppingListItem;
  final PrivateEventPermissionEnum? updateShoppingListItem;
  final PrivateEventPermissionEnum? deleteShoppingListItem;

  PrivateEventPermissionsEntity({
    this.addUsers,
    this.changeDescription,
    this.changeAddress,
    this.addShoppingListItem,
    this.changeTitle,
    this.changeCoverImage,
    this.changeDate,
    this.changeStatus,
    this.deleteShoppingListItem,
    this.updateShoppingListItem,
  });

  factory PrivateEventPermissionsEntity.merge({
    required PrivateEventPermissionsEntity newEntity,
    required PrivateEventPermissionsEntity oldEntity,
  }) {
    return PrivateEventPermissionsEntity(
      changeTitle: newEntity.changeTitle ?? oldEntity.changeTitle,
      changeDescription:
          newEntity.changeDescription ?? oldEntity.changeDescription,
      changeAddress: newEntity.changeAddress ?? oldEntity.changeAddress,
      changeCoverImage:
          newEntity.changeCoverImage ?? oldEntity.changeCoverImage,
      changeDate: newEntity.changeDate ?? oldEntity.changeDate,
      changeStatus: newEntity.changeStatus ?? oldEntity.changeStatus,
      updateShoppingListItem:
          newEntity.updateShoppingListItem ?? oldEntity.updateShoppingListItem,
      deleteShoppingListItem:
          newEntity.deleteShoppingListItem ?? oldEntity.deleteShoppingListItem,
      addShoppingListItem:
          newEntity.addShoppingListItem ?? oldEntity.addShoppingListItem,
      addUsers: newEntity.addUsers ?? oldEntity.addUsers,
    );
  }
}
