import "package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart";
import "package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart";
import "package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart";

class UpdateOnAcceptStandardUpdateFollowDataDto {
  final RequesterPrivateEventAddPermissionEnum?
      requesterPrivateEventAddPermission;
  final RequesterGroupchatAddPermissionEnum? requesterGroupchatAddPermission;
  final RequesterCalenderWatchPermissionEnum? requesterCalenderWatchPermission;

  UpdateOnAcceptStandardUpdateFollowDataDto({
    this.requesterCalenderWatchPermission,
    this.requesterGroupchatAddPermission,
    this.requesterPrivateEventAddPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (requesterCalenderWatchPermission != null) {
      variables.addAll({
        "requesterCalenderWatchPermission":
            requesterCalenderWatchPermission!.value
      });
    }
    if (requesterGroupchatAddPermission != null) {
      variables.addAll({
        "requesterGroupchatAddPermission":
            requesterGroupchatAddPermission!.value
      });
    }
    if (requesterPrivateEventAddPermission != null) {
      variables.addAll({
        "requesterPrivateEventAddPermission":
            requesterPrivateEventAddPermission!.value
      });
    }
    return variables;
  }
}
