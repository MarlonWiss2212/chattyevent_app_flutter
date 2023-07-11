import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_permission_enum.dart';

class CreatePrivateEventPermissionsDto {
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

  CreatePrivateEventPermissionsDto({
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

  CreatePrivateEventPermissionsDto copyWith({
    PrivateEventPermissionEnum? changeTitle,
    PrivateEventPermissionEnum? changeDescription,
    PrivateEventPermissionEnum? changeCoverImage,
    PrivateEventPermissionEnum? changeAddress,
    PrivateEventPermissionEnum? changeDate,
    PrivateEventPermissionEnum? changeStatus,
    PrivateEventPermissionEnum? addUsers,
    PrivateEventPermissionEnum? addShoppingListItem,
    PrivateEventPermissionEnum? updateShoppingListItem,
    PrivateEventPermissionEnum? deleteShoppingListItem,
  }) {
    return CreatePrivateEventPermissionsDto(
      changeDescription: changeDescription ?? this.changeDescription,
      changeTitle: changeTitle ?? this.changeTitle,
      changeCoverImage: changeCoverImage ?? this.changeCoverImage,
      changeAddress: changeAddress ?? this.changeAddress,
      changeDate: changeDate ?? this.changeDate,
      changeStatus: changeStatus ?? this.changeStatus,
      addUsers: addUsers ?? this.addUsers,
      addShoppingListItem: addShoppingListItem ?? this.addShoppingListItem,
      updateShoppingListItem:
          updateShoppingListItem ?? this.updateShoppingListItem,
      deleteShoppingListItem:
          deleteShoppingListItem ?? this.deleteShoppingListItem,
    );
  }

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (changeDescription != null) {
      map.addAll({'changeDescription': changeDescription!.value});
    }
    if (changeAddress != null) {
      map.addAll({'changeAddress': changeAddress!.value});
    }
    if (changeTitle != null) {
      map.addAll({'changeTitle': changeTitle!.value});
    }
    if (changeCoverImage != null) {
      map.addAll({'createEventForGroupchat': changeCoverImage!.value});
    }
    if (changeDate != null) {
      map.addAll({'changeDate': changeDate!.value});
    }
    if (deleteShoppingListItem != null) {
      map.addAll({'deleteShoppingListItem': deleteShoppingListItem!.value});
    }
    if (addShoppingListItem != null) {
      map.addAll({'addShoppingListItem': addShoppingListItem!.value});
    }
    if (updateShoppingListItem != null) {
      map.addAll({'updateShoppingListItem': updateShoppingListItem!.value});
    }
    if (addUsers != null) {
      map.addAll({'addUsers': addUsers!.value});
    }
    if (changeStatus != null) {
      map.addAll({'changeStatus': changeStatus!.value});
    }

    return map;
  }
}
