import 'package:chattyevent_app_flutter/infastructure/filter/event/find_one_event_to_filter.dart';

class FindOneEventLeftUserFilter extends FindOneEventToFilter {
  final String userId;

  FindOneEventLeftUserFilter({
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
