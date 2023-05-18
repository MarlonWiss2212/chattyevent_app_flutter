import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/on_accept_follow_request_standard_follow_data_entity.dart';

class OnAcceptFollowRequestStandardFollowDataModel
    extends OnAcceptFollowRequestStandardFollowDataEntity {
  OnAcceptFollowRequestStandardFollowDataModel({
    RequesterPrivateEventAddPermissionEnum?
        standardRequesterPrivateEventAddPermission,
    RequesterGroupchatAddPermissionEnum?
        standardRequesterGroupchatAddPermission,
    RequesterCalenderWatchPermissionEnum?
        standardRequesterCalenderWatchPermission,
  }) : super(
          standardRequesterGroupchatAddPermission:
              standardRequesterGroupchatAddPermission,
          standardRequesterPrivateEventAddPermission:
              standardRequesterPrivateEventAddPermission,
          standardRequesterCalenderWatchPermission:
              standardRequesterCalenderWatchPermission,
        );

  factory OnAcceptFollowRequestStandardFollowDataModel.fromJson(
      Map<String, dynamic> json) {
    return OnAcceptFollowRequestStandardFollowDataModel(
      standardRequesterGroupchatAddPermission:
          json['standardRequesterGroupchatAddPermission'] != null
              ? RequesterGroupchatAddPermissionEnumExtension.fromValue(
                  json['standardRequesterGroupchatAddPermission'])
              : null,
      standardRequesterPrivateEventAddPermission:
          json['standardRequesterPrivateEventAddPermission'] != null
              ? RequesterPrivateEventAddPermissionEnumExtension.fromValue(
                  json['standardRequesterPrivateEventAddPermission'])
              : null,
      standardRequesterCalenderWatchPermission:
          json['standardRequesterCalenderWatchPermission'] != null
              ? RequesterCalenderWatchPermissionEnumExtension.fromValue(
                  json['standardRequesterCalenderWatchPermission'])
              : null,
    );
  }
}
