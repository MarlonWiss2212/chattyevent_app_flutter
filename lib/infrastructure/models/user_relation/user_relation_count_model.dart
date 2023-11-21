import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';

class UserRelationsCountModel extends UserRelationsCountEntity {
  UserRelationsCountModel({
    int? followerCount,
    int? followedCount,
    int? followRequestCount,
  }) : super(
          followerCount: followerCount,
          followedCount: followedCount,
          followRequestCount: followRequestCount,
        );

  factory UserRelationsCountModel.fromJson(Map<String, dynamic> json) {
    return UserRelationsCountModel(
      followerCount: json['followerCount'],
      followedCount: json['followedCount'],
      followRequestCount: json['followRequestCount'],
    );
  }
}
