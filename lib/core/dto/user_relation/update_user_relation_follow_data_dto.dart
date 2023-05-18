import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';

class UpdateUserRelationFollowDataDto {
  final RequesterPrivateEventAddPermissionEnum?
      requesterPrivateEventAddPermission;
  final RequesterGroupchatAddPermissionEnum? requesterGroupchatAddPermission;
  final RequesterCalenderWatchPermissionEnum? requesterCalenderWatchPermission;

  UpdateUserRelationFollowDataDto({
    this.requesterPrivateEventAddPermission,
    this.requesterGroupchatAddPermission,
    this.requesterCalenderWatchPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (requesterPrivateEventAddPermission != null) {
      map.addAll({
        "requesterPrivateEventAddPermission":
            requesterPrivateEventAddPermission!.value,
      });
    }
    if (requesterCalenderWatchPermission != null) {
      map.addAll({
        "requesterCalenderWatchPermission":
            requesterCalenderWatchPermission!.value,
      });
    }
    if (requesterGroupchatAddPermission != null) {
      map.addAll({
        "requesterGroupchatAddPermission":
            requesterGroupchatAddPermission!.value,
      });
    }

    return map;
  }
}
