import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class CreateEventUserFromEventDto {
  final String userId;
  final EventUserRoleEnum? role;

  CreateEventUserFromEventDto({
    required this.userId,
    this.role,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      "userId": userId,
    };

    if (role != null) {
      variables.addAll({"role": role!.value});
    }

    return variables;
  }
}

/// use this for lists to get the username
class CreateEventUserFromEventDtoWithUserEntity
    extends CreateEventUserFromEventDto {
  final UserEntity user;

  CreateEventUserFromEventDtoWithUserEntity({
    required this.user,
    super.role,
  }) : super(userId: user.id);
}
