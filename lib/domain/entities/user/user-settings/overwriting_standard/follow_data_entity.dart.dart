import 'package:chattyevent_app_flutter/core/enums/user/requester_calender_watch_overwriting_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user/requester_groupchat_add_overwriting_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user/requester_private_event_add_overwriting_permission_enum.dart';

class OverwritingStandardFollowDataEntity {
  final RequesterPrivateEventAddOverwritingPermissionEnum?
      requesterPrivateEventAddPermission;
  final RequesterGroupchatAddOverwritingPermissionEnum?
      requesterGroupchatAddPermission;
  final RequesterCalenderWatchOverwritingPermissionEnum?
      requesterCalenderWatchPermission;

  OverwritingStandardFollowDataEntity({
    this.requesterPrivateEventAddPermission,
    this.requesterGroupchatAddPermission,
    this.requesterCalenderWatchPermission,
  });

  factory OverwritingStandardFollowDataEntity.merge({
    required OverwritingStandardFollowDataEntity newEntity,
    required OverwritingStandardFollowDataEntity oldEntity,
  }) {
    return OverwritingStandardFollowDataEntity(
      requesterPrivateEventAddPermission:
          newEntity.requesterPrivateEventAddPermission ??
              oldEntity.requesterPrivateEventAddPermission,
      requesterGroupchatAddPermission:
          newEntity.requesterGroupchatAddPermission ??
              oldEntity.requesterGroupchatAddPermission,
      requesterCalenderWatchPermission:
          newEntity.requesterCalenderWatchPermission ??
              oldEntity.requesterCalenderWatchPermission,
    );
  }
}
