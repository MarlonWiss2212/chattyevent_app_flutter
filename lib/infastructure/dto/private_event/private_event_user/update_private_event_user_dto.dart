import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user/private_event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user_status_enum.dart';

class UpdatePrivateEventUserDto {
  final PrivateEventUserStatusEnum? status;
  final PrivateEventUserRoleEnum? role;

  UpdatePrivateEventUserDto({
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
