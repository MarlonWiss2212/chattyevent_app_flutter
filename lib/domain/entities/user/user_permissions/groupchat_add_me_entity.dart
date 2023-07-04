import 'package:chattyevent_app_flutter/core/enums/user/groupchat_add_me_permission_enum.dart';

class GroupchatAddMeEntity {
  final GroupchatAddMePermissionEnum? permission;
  final List<String>? exceptUserIds;
  final List<String>? selectedUserIds;

  GroupchatAddMeEntity({
    this.permission,
    this.exceptUserIds,
    this.selectedUserIds,
  });

  /// only use this when changing a value
  factory GroupchatAddMeEntity.merge({
    required GroupchatAddMeEntity newEntity,
    required GroupchatAddMeEntity oldEntity,
  }) {
    return GroupchatAddMeEntity(
      permission: newEntity.permission ?? oldEntity.permission,
      exceptUserIds: newEntity.exceptUserIds ?? oldEntity.exceptUserIds,
      selectedUserIds: newEntity.selectedUserIds ?? oldEntity.selectedUserIds,
    );
  }
}
