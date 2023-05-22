import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';

class GroupchatSettingsEntity {
  final GroupchatPermissionEnum? changeTitlePermission;
  final GroupchatPermissionEnum? changeDescriptionPermission;
  final GroupchatPermissionEnum? addEventToGroupchatPermission;
  final GroupchatPermissionEnum? addUsersPermission;

  GroupchatSettingsEntity({
    this.changeTitlePermission,
    this.changeDescriptionPermission,
    this.addEventToGroupchatPermission,
    this.addUsersPermission,
  });

  factory GroupchatSettingsEntity.merge({
    required GroupchatSettingsEntity newEntity,
    required GroupchatSettingsEntity oldEntity,
  }) {
    return GroupchatSettingsEntity(
      changeTitlePermission:
          newEntity.changeTitlePermission ?? oldEntity.changeTitlePermission,
      changeDescriptionPermission: newEntity.changeDescriptionPermission ??
          oldEntity.changeDescriptionPermission,
      addEventToGroupchatPermission: newEntity.addEventToGroupchatPermission ??
          oldEntity.addEventToGroupchatPermission,
      addUsersPermission:
          newEntity.addUsersPermission ?? oldEntity.addUsersPermission,
    );
  }
}
