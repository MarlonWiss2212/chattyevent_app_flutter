import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';

class UpdateOnAcceptFollowRequestStandardFollowDataDto {
  final RequesterPrivateEventAddPermissionEnum?
      standardRequesterPrivateEventAddPermission;
  final RequesterGroupchatAddPermissionEnum?
      standardRequesterGroupchatAddPermission;
  final RequesterCalenderWatchPermissionEnum?
      standardRequesterCalenderWatchPermission;

  UpdateOnAcceptFollowRequestStandardFollowDataDto({
    this.standardRequesterGroupchatAddPermission,
    this.standardRequesterPrivateEventAddPermission,
    this.standardRequesterCalenderWatchPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (standardRequesterGroupchatAddPermission != null) {
      variables.addAll({
        "standardRequesterGroupchatAddPermission":
            standardRequesterGroupchatAddPermission!.value
      });
    }
    if (standardRequesterPrivateEventAddPermission != null) {
      variables.addAll({
        "standardRequesterPrivateEventAddPermission":
            standardRequesterPrivateEventAddPermission!.value
      });
    }
    if (standardRequesterCalenderWatchPermission != null) {
      variables.addAll({
        "standardRequesterCalenderWatchPermission":
            standardRequesterCalenderWatchPermission!.value
      });
    }
    return variables;
  }
}
