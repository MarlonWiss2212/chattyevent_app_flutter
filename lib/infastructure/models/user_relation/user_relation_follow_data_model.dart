import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_follow_data_entity.dart';

class UserRelationFollowDataModel extends UserRelationFollowDataEntity {
  UserRelationFollowDataModel({
    RequesterPrivateEventAddPermissionEnum? requesterPrivateEventAddPermission,
    RequesterGroupchatAddPermissionEnum? requesterGroupchatAddPermission,
    RequesterCalenderWatchPermissionEnum? requesterCalenderWatchPermission,
    DateTime? followedUserAt,
    DateTime? updatedAt,
  }) : super(
            requesterGroupchatAddPermission: requesterGroupchatAddPermission,
            requesterPrivateEventAddPermission:
                requesterPrivateEventAddPermission,
            requesterCalenderWatchPermission: requesterCalenderWatchPermission,
            followedUserAt: followedUserAt,
            updatedAt: updatedAt);

  factory UserRelationFollowDataModel.fromJson(Map<String, dynamic> json) {
    return UserRelationFollowDataModel(
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
      followedUserAt: json['followedUserAt'] != null
          ? DateTime.parse(json['followedUserAt'])
          : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
