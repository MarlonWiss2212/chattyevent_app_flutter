import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class GroupchatLeftUserEntity extends UserEntity {
  final String groupchatUserLeftId;
  final String? groupchatTo;
  final DateTime? leftGroupchatAt;

  GroupchatLeftUserEntity({
    required this.groupchatUserLeftId,
    required super.id,
    required super.authId,
    this.leftGroupchatAt,
    this.groupchatTo,
    super.birthdate,
    super.createdAt,
    super.myUserRelationToOtherUser,
    super.otherUserRelationToMyUser,
    super.profileImageLink,
    super.updatedAt,
    super.userRelationCounts,
    super.username,
  });

  factory GroupchatLeftUserEntity.merge({
    bool removeMyUserRelation = false,
    required GroupchatLeftUserEntity newEntity,
    required GroupchatLeftUserEntity oldEntity,
  }) {
    return GroupchatLeftUserEntity(
      groupchatUserLeftId: newEntity.groupchatUserLeftId,
      groupchatTo: newEntity.groupchatTo ?? oldEntity.groupchatTo,
      leftGroupchatAt: newEntity.leftGroupchatAt ?? oldEntity.leftGroupchatAt,
      authId: newEntity.authId,
      id: newEntity.id,
      username: newEntity.username ?? oldEntity.username,
      myUserRelationToOtherUser:
          removeMyUserRelation ? null : newEntity.myUserRelationToOtherUser,
      otherUserRelationToMyUser: newEntity.otherUserRelationToMyUser,
      profileImageLink:
          newEntity.profileImageLink ?? oldEntity.profileImageLink,
      userRelationCounts: UserRelationsCountEntity.merge(
        newEntity: newEntity.userRelationCounts ?? UserRelationsCountEntity(),
        oldEntity: oldEntity.userRelationCounts ?? UserRelationsCountEntity(),
      ),
      birthdate: newEntity.birthdate ?? oldEntity.birthdate,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
