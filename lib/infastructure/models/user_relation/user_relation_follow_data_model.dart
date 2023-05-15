import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_follow_data_entity.dart';

class UserRelationFollowDataModel extends UserRelationFollowDataEntity {
  UserRelationFollowDataModel({
    String? requesterGroupchatAddPermission,
    String? requesterPrivateEventAddPermission,
    DateTime? followedUserAt,
  }) : super(
          requesterGroupchatAddPermission: requesterGroupchatAddPermission,
          requesterPrivateEventAddPermission:
              requesterPrivateEventAddPermission,
          followedUserAt: followedUserAt,
        );

  factory UserRelationFollowDataModel.fromJson(Map<String, dynamic> json) {
    return UserRelationFollowDataModel(
      requesterGroupchatAddPermission: json['requesterGroupchatAddPermission'],
      requesterPrivateEventAddPermission:
          json['requesterPrivateEventAddPermission'],
      followedUserAt: json['followedUserAt'] != null
          ? DateTime.parse(json['followedUserAt'])
          : null,
    );
  }
}
