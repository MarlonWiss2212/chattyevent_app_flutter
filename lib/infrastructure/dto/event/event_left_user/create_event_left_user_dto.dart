import 'package:chattyevent_app_flutter/infrastructure/filter/event/find_one_event_to_filter.dart';

class CreateEventLeftUserDto extends FindOneEventToFilter {
  final String userId;

  CreateEventLeftUserDto({
    required super.eventTo,
    required this.userId,
  });

  @override
  Map toMap() {
    Map<dynamic, dynamic> map = super.toMap();
    map.addAll({'userId': userId});
    return map;
  }
}
