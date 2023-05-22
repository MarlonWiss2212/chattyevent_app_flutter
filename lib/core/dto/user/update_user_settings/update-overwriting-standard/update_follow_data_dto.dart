import 'package:chattyevent_app_flutter/core/enums/user/requester_calender_watch_overwriting_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user/requester_groupchat_add_overwriting_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user/requester_private_event_add_overwriting_permission_enum.dart';

class UpdateOverwritingStandardUpdateFollowDataDto {
  final RequesterPrivateEventAddOverwritingPermissionEnum?
      requesterPrivateEventAddPermission;
  final RequesterGroupchatAddOverwritingPermissionEnum?
      requesterGroupchatAddPermission;
  final RequesterCalenderWatchOverwritingPermissionEnum?
      requesterCalenderWatchPermission;

  UpdateOverwritingStandardUpdateFollowDataDto({
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
