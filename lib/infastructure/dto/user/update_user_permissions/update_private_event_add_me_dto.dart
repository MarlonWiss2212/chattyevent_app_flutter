import 'package:chattyevent_app_flutter/core/enums/user/private_event_add_me_permission_enum.dart';

class UpdatePrivateEventAddMeDto {
  final PrivateEventAddMePermissionEnum? permission;
  final List<String>? addToExceptUserIds;
  final List<String>? removeFromExceptUserIds;
  final List<String>? addToSelectedUserIds;
  final List<String>? removeFromSelectedUserIds;

  UpdatePrivateEventAddMeDto({
    this.addToExceptUserIds,
    this.addToSelectedUserIds,
    this.permission,
    this.removeFromExceptUserIds,
    this.removeFromSelectedUserIds,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (permission != null) {
      variables.addAll({"permission": permission!.value});
    }
    if (addToExceptUserIds != null) {
      variables.addAll({"addToExceptUserIds": addToExceptUserIds});
    }
    if (removeFromExceptUserIds != null) {
      variables.addAll({"removeFromExceptUserIds": removeFromExceptUserIds});
    }
    if (addToSelectedUserIds != null) {
      variables.addAll({"addToSelectedUserIds": addToSelectedUserIds});
    }
    if (removeFromSelectedUserIds != null) {
      variables
          .addAll({"removeFromSelectedUserIds": removeFromSelectedUserIds});
    }
    return variables;
  }
}
