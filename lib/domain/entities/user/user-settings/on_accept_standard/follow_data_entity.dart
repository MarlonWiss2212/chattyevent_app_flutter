import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';

class OnAcceptStandardFollowDataEntity {
  final RequesterPrivateEventAddPermissionEnum?
      requesterPrivateEventAddPermission;
  final RequesterGroupchatAddPermissionEnum? requesterGroupchatAddPermission;
  final RequesterCalenderWatchPermissionEnum? requesterCalenderWatchPermission;

  OnAcceptStandardFollowDataEntity({
    this.requesterPrivateEventAddPermission,
    this.requesterGroupchatAddPermission,
    this.requesterCalenderWatchPermission,
  });

  factory OnAcceptStandardFollowDataEntity.merge({
    required OnAcceptStandardFollowDataEntity newEntity,
    required OnAcceptStandardFollowDataEntity oldEntity,
  }) {
    return OnAcceptStandardFollowDataEntity(
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
