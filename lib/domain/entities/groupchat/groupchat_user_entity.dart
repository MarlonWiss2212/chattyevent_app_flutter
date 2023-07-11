import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_user/groupchat_user_role_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class GroupchatUserEntity extends UserEntity {
  final String groupchatUserId;
  final String? groupchatTo;
  final DateTime? joinedGroupchatAt;
  final GroupchatUserRoleEnum? role;
  final String? usernameForChat;

  GroupchatUserEntity({
    required this.groupchatUserId,
    required super.id,
    required super.authId,
    this.role,
    this.joinedGroupchatAt,
    this.groupchatTo,
    this.usernameForChat,
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
    GroupchatPermissionEnum? permissionCheckValue,
  }) {
    switch (permissionCheckValue) {
      case GroupchatPermissionEnum.everyone:
        return true;
      case GroupchatPermissionEnum.adminsonly:
        if (role == GroupchatUserRoleEnum.admin) {
          return true;
        }
        return false;
      default:
        return false;
    }
  }

  factory GroupchatUserEntity.merge({
    bool removeMyUserRelation = false,
    required GroupchatUserEntity newEntity,
    required GroupchatUserEntity oldEntity,
  }) {
    return GroupchatUserEntity(
      groupchatUserId: newEntity.groupchatUserId,
      groupchatTo: newEntity.groupchatTo ?? oldEntity.groupchatTo,
      joinedGroupchatAt:
          newEntity.joinedGroupchatAt ?? oldEntity.joinedGroupchatAt,
      role: newEntity.role ?? oldEntity.role,
      usernameForChat: newEntity.usernameForChat ?? oldEntity.usernameForChat,
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
