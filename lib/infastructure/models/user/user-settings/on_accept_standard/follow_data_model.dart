import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/on_accept_standard/follow_data_entity.dart';

class OnAcceptStandardFollowDataModel extends OnAcceptStandardFollowDataEntity {
  OnAcceptStandardFollowDataModel({
    super.requesterPrivateEventAddPermission,
    super.requesterGroupchatAddPermission,
    super.requesterCalenderWatchPermission,
  });

  factory OnAcceptStandardFollowDataModel.fromJson(Map<String, dynamic> json) {
    return OnAcceptStandardFollowDataModel(
      requesterGroupchatAddPermission:
          json['requesterGroupchatAddPermission'] != null
              ? RequesterGroupchatAddPermissionEnumExtension.fromValue(
                  json['requesterGroupchatAddPermission'],
                )
              : null,
      requesterCalenderWatchPermission:
          json['requesterCalenderWatchPermission'] != null
              ? RequesterCalenderWatchPermissionEnumExtension.fromValue(
                  json['requesterCalenderWatchPermission'],
                )
              : null,
      requesterPrivateEventAddPermission:
          json['requesterPrivateEventAddPermission'] != null
              ? RequesterPrivateEventAddPermissionEnumExtension.fromValue(
                  json['requesterPrivateEventAddPermission'],
                )
              : null,
    );
  }
}
