import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user_status_enum.dart';

class UpdatePrivateEventUserDto {
  final PrivateEventUserStatusEnum? status;
  final bool? organizer;

  UpdatePrivateEventUserDto({
    this.status,
    this.organizer,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (status != null) {
      variables.addAll({"status": status!.value});
    }
    if (organizer != null) {
      variables.addAll({"organizer": organizer});
    }

    return variables;
  }
}
