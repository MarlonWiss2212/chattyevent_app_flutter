import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_follow_data_entity.dart';

class UserRelationFollowDataModel extends UserRelationFollowDataEntity {
  UserRelationFollowDataModel({
    String? followedToGroupchatPermission,
    String? followedToPrivateEventPermission,
    DateTime? followedUserAt,
  }) : super(
          followedToGroupchatPermission: followedToGroupchatPermission,
          followedToPrivateEventPermission: followedToPrivateEventPermission,
          followedUserAt: followedUserAt,
        );

  factory UserRelationFollowDataModel.fromJson(Map<String, dynamic> json) {
    return UserRelationFollowDataModel(
      followedToGroupchatPermission: json['followedToGroupchatPermission'],
      followedToPrivateEventPermission:
          json['followedToPrivateEventPermission'],
      followedUserAt: json['followedUserAt'] != null
          ? DateTime.parse(json['followedUserAt'])
          : null,
    );
  }
}
