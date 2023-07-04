import 'package:chattyevent_app_flutter/core/enums/user/private_event_add_me_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_permissions/private_event_add_me_entity.dart';

class PrivateEventAddMeModel extends PrivateEventAddMeEntity {
  PrivateEventAddMeModel({
    super.permission,
    super.exceptUserIds,
    super.selectedUserIds,
  });

  factory PrivateEventAddMeModel.fromJson(Map<String, dynamic> json) {
    List<String>? exceptUserIds;
    if (json['exceptUserIds'] != null) {
      exceptUserIds ??= [];
      for (final exceptUserId in json['exceptUserIds']) {
        exceptUserIds.add(exceptUserId);
      }
    }

    List<String>? selectedUserIds;
    if (json['selectedUserIds'] != null) {
      selectedUserIds ??= [];
      for (final selectedUserId in json['selectedUserIds']) {
        selectedUserIds.add(selectedUserId);
      }
    }

    return PrivateEventAddMeModel(
      permission: json["permission"] != null
          ? PrivateEventAddMePermissionEnumExtension.fromValue(
              json["permission"])
          : null,
      exceptUserIds: exceptUserIds,
      selectedUserIds: selectedUserIds,
    );
  }
}
