import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_calender_watch_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';

class UserRelationFollowDataEntity {
  final RequesterPrivateEventAddPermissionEnum?
      requesterPrivateEventAddPermission;
  final RequesterGroupchatAddPermissionEnum? requesterGroupchatAddPermission;
  final RequesterCalenderWatchPermissionEnum? requesterCalenderWatchPermission;
  final DateTime? followedUserAt;
  final DateTime? updatedAt;

  UserRelationFollowDataEntity({
    this.requesterPrivateEventAddPermission,
    this.requesterGroupchatAddPermission,
    this.requesterCalenderWatchPermission,
    this.followedUserAt,
    this.updatedAt,
  });

  factory UserRelationFollowDataEntity.merge({
    required UserRelationFollowDataEntity newEntity,
    required UserRelationFollowDataEntity oldEntity,
  }) {
    return UserRelationFollowDataEntity(
      requesterPrivateEventAddPermission:
          newEntity.requesterPrivateEventAddPermission ??
              oldEntity.requesterPrivateEventAddPermission,
      requesterGroupchatAddPermission:
          newEntity.requesterGroupchatAddPermission ??
              oldEntity.requesterGroupchatAddPermission,
      requesterCalenderWatchPermission:
          newEntity.requesterCalenderWatchPermission ??
              oldEntity.requesterCalenderWatchPermission,
      followedUserAt: newEntity.followedUserAt ?? oldEntity.followedUserAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
