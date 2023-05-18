import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';

class OnAcceptFollowRequestStandardFollowDataEntity {
  final RequesterPrivateEventAddPermissionEnum?
      standardRequesterPrivateEventAddPermission;
  final RequesterGroupchatAddPermissionEnum?
      standardRequesterGroupchatAddPermission;
  final RequesterCalenderWatchPermissionEnum?
      standardRequesterCalenderWatchPermission;

  OnAcceptFollowRequestStandardFollowDataEntity({
    this.standardRequesterPrivateEventAddPermission,
    this.standardRequesterGroupchatAddPermission,
    this.standardRequesterCalenderWatchPermission,
  });
}
