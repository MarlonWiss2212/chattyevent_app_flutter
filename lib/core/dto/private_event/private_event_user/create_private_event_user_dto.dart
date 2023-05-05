import 'package:chattyevent_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_from_private_event_dto.dart';

class CreatePrivateEventUserDto
    extends CreatePrivateEventUserFromPrivateEventDto {
  final String privateEventTo;

  CreatePrivateEventUserDto({
    required super.userId,
    required this.privateEventTo,
    super.organizer,
  });

  @override
  Map toMap() {
    final map = super.toMap();
    map.addAll({"privateEventTo": privateEventTo});
    return map;
  }
}
