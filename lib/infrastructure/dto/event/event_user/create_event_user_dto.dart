import 'package:chattyevent_app_flutter/infrastructure/dto/event/event_user/create_event_user_from_event_dto.dart';

class CreateEventUserDto extends CreateEventUserFromEventDto {
  final String eventTo;

  CreateEventUserDto({
    required super.userId,
    required this.eventTo,
    super.role,
  });

  @override
  Map toMap() {
    final map = super.toMap();
    map.addAll({"eventTo": eventTo});
    return map;
  }
}
