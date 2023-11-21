import 'package:chattyevent_app_flutter/infrastructure/filter/event/find_one_event_to_filter.dart';

class FindOnePrivateEventLeftUserFilter extends FindOneEventToFilter {
  final String userId;

  FindOnePrivateEventLeftUserFilter({
    required this.userId,
    required super.eventTo,
  });

  @override
  Map toMap() {
    Map<dynamic, dynamic> map = super.toMap();
    map.addAll({"userId": userId});
    return map;
  }
}
