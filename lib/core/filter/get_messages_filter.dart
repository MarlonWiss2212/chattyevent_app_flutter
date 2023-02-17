import 'package:social_media_app_flutter/core/filter/limit_filter.dart';

class GetMessagesFilter {
  final String? groupchatTo;
  final LimitFilter? limitFilter;

  GetMessagesFilter({this.groupchatTo, this.limitFilter});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (groupchatTo != null) {
      map.addAll({"groupchatTo": groupchatTo});
    }
    if (limitFilter != null) {
      map.addAll({"limitFilter": limitFilter!.toMap()});
    }
    return map;
  }
}
