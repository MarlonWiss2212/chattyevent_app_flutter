import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_follow_data_entity.dart';

class UserRelationEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? targetUserId;
  final String? requesterUserId;
  final UserRelationStatusEnum? statusOnRelatedUser;
  final UserRelationFollowDataEntity? followData;

  UserRelationEntity({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.targetUserId,
    this.requesterUserId,
    this.statusOnRelatedUser,
    this.followData,
  });

  factory UserRelationEntity.merge({
    required UserRelationEntity newEntity,
    required UserRelationEntity oldEntity,
  }) {
    return UserRelationEntity(
      id: newEntity.id,
      createdAt: oldEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
      targetUserId: newEntity.targetUserId ?? oldEntity.targetUserId,
      requesterUserId: newEntity.requesterUserId ?? oldEntity.requesterUserId,
      statusOnRelatedUser:
          newEntity.statusOnRelatedUser ?? oldEntity.statusOnRelatedUser,
      followData: newEntity.followData,
    );
  }
}
