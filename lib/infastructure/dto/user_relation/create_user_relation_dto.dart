import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';

class CreateUserRelationDto {
  final String targetUserId;
  final UserRelationStatusEnum? status;

  CreateUserRelationDto({
    required this.targetUserId,
    this.status,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {'targetUserId': targetUserId};

    if (status != null) {
      map.addAll({"status": status!.value});
    }
    return map;
  }
}
