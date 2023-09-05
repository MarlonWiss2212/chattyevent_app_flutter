import 'package:chattyevent_app_flutter/core/enums/request/request_type_enum.dart';

class FindRequestsFilter {
  final RequestTypeEnum? type;
  final String? eventTo;
  final String? groupchatTo;

  FindRequestsFilter({
    this.type,
    this.eventTo,
    this.groupchatTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (type != null) {
      map.addAll({type: type!.value});
    }
    if (groupchatTo != null) {
      map.addAll({groupchatTo: "groupchatTo"});
    }
    if (eventTo != null) {
      map.addAll({eventTo: "eventTo"});
    }
    return map;
  }
}
