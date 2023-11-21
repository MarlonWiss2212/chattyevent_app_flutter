import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_follow_data_entity.dart';

class UserRelationFollowDataModel extends UserRelationFollowDataEntity {
  UserRelationFollowDataModel({
    DateTime? followedUserAt,
    DateTime? updatedAt,
  }) : super(
          followedUserAt: followedUserAt,
          updatedAt: updatedAt,
        );

  factory UserRelationFollowDataModel.fromJson(Map<String, dynamic> json) {
    return UserRelationFollowDataModel(
      followedUserAt: json['followedUserAt'] != null
          ? DateTime.parse(json['followedUserAt'])
          : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
