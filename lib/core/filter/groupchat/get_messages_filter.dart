import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';

class GetMessagesFilter {
  final String? groupchatTo;
  final LimitOffsetFilterOptional? limitOffsetFilter;

  GetMessagesFilter({this.groupchatTo, this.limitOffsetFilter});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (groupchatTo != null) {
      map.addAll({"groupchatTo": groupchatTo});
    }
    if (limitOffsetFilter != null) {
      map.addAll({"limitOffsetFilter": limitOffsetFilter!.toMap()});
    }
    return map;
  }
}
