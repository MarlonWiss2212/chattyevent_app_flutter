import 'package:social_media_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';

class PrivateEventLeftUserEntity extends UserEntity {
  final String privateEventUserLeftId;
  final String? privateEventTo;
  final DateTime? leftPrivateEventAt;

  PrivateEventLeftUserEntity({
    required this.privateEventUserLeftId,
    required super.id,
    required super.authId,
    this.leftPrivateEventAt,
    this.privateEventTo,
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

  factory PrivateEventLeftUserEntity.merge({
    bool removeMyUserRelation = false,
    required PrivateEventLeftUserEntity newEntity,
    required PrivateEventLeftUserEntity oldEntity,
  }) {
    return PrivateEventLeftUserEntity(
      privateEventUserLeftId: newEntity.privateEventUserLeftId,
      privateEventTo: newEntity.privateEventTo ?? oldEntity.privateEventTo,
      leftPrivateEventAt:
          newEntity.leftPrivateEventAt ?? oldEntity.leftPrivateEventAt,
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
