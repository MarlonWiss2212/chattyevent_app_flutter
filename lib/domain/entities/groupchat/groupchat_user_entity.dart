import 'package:social_media_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';

class GroupchatUserEntity extends UserEntity {
  final String groupchatUserId;
  final String? groupchatTo;
  final DateTime? joinedGroupchatAt;
  final bool? admin;
  final String? usernameForChat;

  GroupchatUserEntity({
    required this.groupchatUserId,
    required super.id,
    required super.authId,
    this.admin,
    this.joinedGroupchatAt,
    this.groupchatTo,
    this.usernameForChat,
    super.birthdate,
    super.createdAt,
    super.firstname,
    super.lastTimeOnline,
    super.lastname,
    super.myUserRelationToOtherUser,
    super.otherUserRelationToMyUser,
    super.profileImageLink,
    super.updatedAt,
    super.userRelationCounts,
    super.username,
  });

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
      admin: newEntity.admin ?? oldEntity.admin,
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
      lastTimeOnline: newEntity.lastTimeOnline ?? oldEntity.lastTimeOnline,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
