import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';

class UpdateUserRelationDto {
  final UserRelationStatusEnum status;
  UpdateUserRelationDto({required this.status});

  Map<dynamic, dynamic> toMap() {
    return {'status': status.value};
  }
}
