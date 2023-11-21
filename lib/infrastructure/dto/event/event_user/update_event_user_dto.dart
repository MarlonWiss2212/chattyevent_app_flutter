import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_status_enum.dart';

class UpdateEventUserDto {
  final EventUserStatusEnum? status;
  final EventUserRoleEnum? role;

  UpdateEventUserDto({
    this.status,
    this.role,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (status != null) {
      variables.addAll({"status": status!.value});
    }
    if (role != null) {
      variables.addAll({"role": role!.value});
    }

    return variables;
  }
}
