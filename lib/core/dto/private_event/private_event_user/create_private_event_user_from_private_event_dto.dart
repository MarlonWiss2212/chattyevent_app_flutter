import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';

class CreatePrivateEventUserFromPrivateEventDto {
  final String userId;
  final bool? organizer;

  CreatePrivateEventUserFromPrivateEventDto({
    required this.userId,
    this.organizer,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      "userId": userId,
    };

    if (organizer != null) {
      variables.addAll({"organizer": organizer});
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
    super.organizer,
  }) : super(userId: user.id);
}
