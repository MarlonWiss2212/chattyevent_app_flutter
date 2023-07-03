import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';

class FindFollowersFilter {
  final String targetUserId;
  final RequesterPrivateEventAddPermissionEnum?
      requesterPrivateEventAddPermission;
  final RequesterGroupchatAddPermissionEnum? requesterGroupchatAddPermission;
  final RequesterCalenderWatchPermissionEnum? requesterCalenderWatchPermission;
  final String? search;

  FindFollowersFilter({
    required this.targetUserId,
    this.requesterGroupchatAddPermission,
    this.requesterPrivateEventAddPermission,
    this.requesterCalenderWatchPermission,
    this.search,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"targetUserId": targetUserId};

    if (search != null) {
      map.addAll({"search": search});
    }

    //new schema
    /*
    if (requesterPrivateEventAddPermission != null) {
      map.addAll({
        "requesterPrivateEventAddPermission":
            requesterPrivateEventAddPermission!.value,
      });
    }

    if (requesterGroupchatAddPermission != null) {
      map.addAll({
        "requesterGroupchatAddPermission":
            requesterGroupchatAddPermission!.value,
      });
    }

    if (requesterCalenderWatchPermission != null) {
      map.addAll({
        "requesterCalenderWatchPermission":
            requesterCalenderWatchPermission!.value,
      });
    }*/

    return map;
  }
}
