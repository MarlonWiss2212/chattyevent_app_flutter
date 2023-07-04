import 'package:chattyevent_app_flutter/core/enums/user/private_event_add_me_permission_enum.dart';

class PrivateEventAddMeEntity {
  final PrivateEventAddMePermissionEnum? permission;
  final List<String>? exceptUserIds;
  final List<String>? selectedUserIds;

  PrivateEventAddMeEntity({
    this.permission,
    this.exceptUserIds,
    this.selectedUserIds,
  });

  /// only use this when changing a value
  factory PrivateEventAddMeEntity.merge({
    required PrivateEventAddMeEntity newEntity,
    required PrivateEventAddMeEntity oldEntity,
  }) {
    return PrivateEventAddMeEntity(
      permission: newEntity.permission ?? oldEntity.permission,
      exceptUserIds: newEntity.exceptUserIds ?? oldEntity.exceptUserIds,
      selectedUserIds: newEntity.selectedUserIds ?? oldEntity.selectedUserIds,
    );
  }
}
