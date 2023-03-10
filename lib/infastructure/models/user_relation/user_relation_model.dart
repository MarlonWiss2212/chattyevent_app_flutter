import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_follow_data_entity.dart';
import 'package:social_media_app_flutter/infastructure/models/user_relation/user_relation_follow_data_model.dart';

class UserRelationModel extends UserRelationEntity {
  UserRelationModel({
    required String id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? targetUserId,
    String? requesterUserId,
    String? statusOnRelatedUser,
    UserRelationFollowDataEntity? followData,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          targetUserId: targetUserId,
          requesterUserId: requesterUserId,
          statusOnRelatedUser: statusOnRelatedUser,
          followData: followData,
        );

  factory UserRelationModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return UserRelationModel(
      id: json['_id'],
      targetUserId: json['targetUserId'],
      requesterUserId: json['requesterUserId'],
      statusOnRelatedUser: json['statusOnRelatedUser'],
      followData: json['followData'] != null
          ? UserRelationFollowDataModel.fromJson(json['followData'])
          : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
