import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';

class GroupchatPermissionsEntity {
  final GroupchatPermissionEnum? changeTitle;
  final GroupchatPermissionEnum? changeDescription;
  final GroupchatPermissionEnum? changeProfileImage;
  final GroupchatPermissionEnum? createEventForGroupchat;
  final GroupchatPermissionEnum? addUsers;

  GroupchatPermissionsEntity({
    this.addUsers,
    this.changeDescription,
    this.changeProfileImage,
    this.changeTitle,
    this.createEventForGroupchat,
  });

  factory GroupchatPermissionsEntity.merge({
    required GroupchatPermissionsEntity newEntity,
    required GroupchatPermissionsEntity oldEntity,
  }) {
    return GroupchatPermissionsEntity(
      changeTitle: newEntity.changeTitle ?? oldEntity.changeTitle,
      changeDescription:
          newEntity.changeDescription ?? oldEntity.changeDescription,
      changeProfileImage:
          newEntity.changeProfileImage ?? oldEntity.changeProfileImage,
      createEventForGroupchat: newEntity.createEventForGroupchat ??
          oldEntity.createEventForGroupchat,
      addUsers: newEntity.addUsers ?? oldEntity.addUsers,
    );
  }
}
