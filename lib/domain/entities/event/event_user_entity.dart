import 'package:chattyevent_app_flutter/core/enums/event/event_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_status_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class EventUserEntity extends UserEntity {
  final String eventUserId;
  final String? eventTo;
  final DateTime? joinedEventAt;
  final EventUserStatusEnum? status;
  final EventUserRoleEnum? role;

  EventUserEntity({
    required this.eventUserId,
    required super.id,
    required super.authId,
    this.status,
    this.joinedEventAt,
    this.eventTo,
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

  bool currentUserAllowedWithPermission({
    EventPermissionEnum? permissionCheckValue,
    String? createdById,
  }) {
    switch (permissionCheckValue) {
      case EventPermissionEnum.everyone:
        return true;
      case EventPermissionEnum.organizersonly:
        if (role == null || role != EventUserRoleEnum.organizer) {
          return false;
        }
        return true;
      case EventPermissionEnum.creatoronly:
        return id == createdById;
      default:
        return false;
    }
  }

  factory EventUserEntity.merge({
    bool removeMyUserRelation = false,
    required EventUserEntity newEntity,
    required EventUserEntity oldEntity,
  }) {
    return EventUserEntity(
      eventUserId: newEntity.eventUserId,
      eventTo: newEntity.eventTo ?? oldEntity.eventTo,
      joinedEventAt: newEntity.joinedEventAt ?? oldEntity.joinedEventAt,
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
