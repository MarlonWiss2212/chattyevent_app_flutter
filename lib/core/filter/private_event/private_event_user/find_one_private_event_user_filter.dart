import 'package:social_media_app_flutter/core/filter/private_event/find_one_private_event_to_filter.dart';

class FindOnePrivateEventUserFilter extends FindOnePrivateEventToFilter {
  final String userId;

  FindOnePrivateEventUserFilter({
    required this.userId,
    required super.privateEventTo,
  });

  @override
  Map toMap() {
    Map<dynamic, dynamic> map = super.toMap();
    map.addAll({"userId": userId});
    return map;
  }
}
