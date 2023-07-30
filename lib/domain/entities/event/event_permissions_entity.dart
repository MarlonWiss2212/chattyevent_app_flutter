import 'package:chattyevent_app_flutter/core/enums/event/event_permission_enum.dart';

class EventPermissionsEntity {
  final EventPermissionEnum? changeTitle;
  final EventPermissionEnum? changeDescription;
  final EventPermissionEnum? changeCoverImage;
  final EventPermissionEnum? changeAddress;
  final EventPermissionEnum? changeDate;
  final EventPermissionEnum? changeStatus;
  final EventPermissionEnum? addUsers;
  final EventPermissionEnum? addShoppingListItem;
  final EventPermissionEnum? updateShoppingListItem;
  final EventPermissionEnum? deleteShoppingListItem;

  EventPermissionsEntity({
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

  factory EventPermissionsEntity.merge({
    required EventPermissionsEntity newEntity,
    required EventPermissionsEntity oldEntity,
  }) {
    return EventPermissionsEntity(
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
