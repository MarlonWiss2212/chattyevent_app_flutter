import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user/private_event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class CreatePrivateEventUserFromPrivateEventDto {
  final String userId;
  final PrivateEventUserRoleEnum? role;

  CreatePrivateEventUserFromPrivateEventDto({
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
class CreatePrivateEventUserFromPrivateEventDtoWithUserEntity
    extends CreatePrivateEventUserFromPrivateEventDto {
  final UserEntity user;

  CreatePrivateEventUserFromPrivateEventDtoWithUserEntity({
    required this.user,
    super.role,
  }) : super(userId: user.id);
}
