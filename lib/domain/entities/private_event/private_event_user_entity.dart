import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user/private_event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user_status_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class PrivateEventUserEntity extends UserEntity {
  final String privateEventUserId;
  final String? privateEventTo;
  final DateTime? joinedPrivateEventAt;
  final PrivateEventUserStatusEnum? status;
  final PrivateEventUserRoleEnum? role;

  PrivateEventUserEntity({
    required this.privateEventUserId,
    required super.id,
    required super.authId,
    this.status,
    this.joinedPrivateEventAt,
    this.privateEventTo,
    this.role,
    super.birthdate,
    super.createdAt,
    super.firstname,
    super.lastname,
    super.myUserRelationToOtherUser,
    super.otherUserRelationToMyUser,
    super.profileImageLink,
    super.updatedAt,
    super.userRelationCounts,
    super.username,
  });

  factory PrivateEventUserEntity.merge({
    bool removeMyUserRelation = false,
    required PrivateEventUserEntity newEntity,
    required PrivateEventUserEntity oldEntity,
  }) {
    return PrivateEventUserEntity(
      privateEventUserId: newEntity.privateEventUserId,
      privateEventTo: newEntity.privateEventTo ?? oldEntity.privateEventTo,
      joinedPrivateEventAt:
          newEntity.joinedPrivateEventAt ?? oldEntity.joinedPrivateEventAt,
      role: newEntity.role ?? oldEntity.role,
      status: newEntity.status ?? oldEntity.status,
      authId: newEntity.authId,
      id: newEntity.id,
      username: newEntity.username ?? oldEntity.username,
      myUserRelationToOtherUser:
          removeMyUserRelation ? null : newEntity.myUserRelationToOtherUser,
      otherUserRelationToMyUser: newEntity.otherUserRelationToMyUser,
      profileImageLink:
          newEntity.profileImageLink ?? oldEntity.profileImageLink,
      firstname: newEntity.firstname ?? oldEntity.firstname,
      userRelationCounts: UserRelationsCountEntity.merge(
        newEntity: newEntity.userRelationCounts ?? UserRelationsCountEntity(),
        oldEntity: oldEntity.userRelationCounts ?? UserRelationsCountEntity(),
      ),
      lastname: newEntity.lastname ?? oldEntity.lastname,
      birthdate: newEntity.birthdate ?? oldEntity.birthdate,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
