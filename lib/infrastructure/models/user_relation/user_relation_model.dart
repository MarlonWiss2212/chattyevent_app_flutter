import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_follow_data_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/user_relation/user_relation_follow_data_model.dart';

class UserRelationModel extends UserRelationEntity {
  UserRelationModel({
    required String id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? targetUserId,
    String? requesterUserId,
    UserRelationStatusEnum? status,
    UserRelationFollowDataEntity? followData,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          targetUserId: targetUserId,
          requesterUserId: requesterUserId,
          status: status,
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
      status: json['status'] != null
          ? UserRelationStatusEnumExtension.fromValue(
              json['status'],
            )
          : null,
      followData: json['followData'] != null
          ? UserRelationFollowDataModel.fromJson(json['followData'])
          : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
