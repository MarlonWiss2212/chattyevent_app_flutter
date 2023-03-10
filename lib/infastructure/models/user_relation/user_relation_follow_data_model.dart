import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_follow_data_entity.dart';

class UserRelationFollowDataModel extends UserRelationFollowDataEntity {
  UserRelationFollowDataModel({
    bool? canInviteFollowedToPrivateEvent,
    bool? canInviteFollowedToGroupchat,
    DateTime? followedUserAt,
  }) : super(
          canInviteFollowedToPrivateEvent: canInviteFollowedToPrivateEvent,
          canInviteFollowedToGroupchat: canInviteFollowedToGroupchat,
          followedUserAt: followedUserAt,
        );

  factory UserRelationFollowDataModel.fromJson(Map<String, dynamic> json) {
    return UserRelationFollowDataModel(
      canInviteFollowedToPrivateEvent: json['canInviteFollowedToPrivateEvent'],
      canInviteFollowedToGroupchat: json['canInviteFollowedToGroupchat'],
      followedUserAt: json['followedUserAt'] != null
          ? DateTime.parse(json['followedUserAt'])
          : null,
    );
  }
}
