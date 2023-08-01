import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class EventLeftUserEntity extends UserEntity {
  final String eventUserLeftId;
  final String? eventTo;
  final DateTime? leftEventAt;

  EventLeftUserEntity({
    required this.eventUserLeftId,
    required super.id,
    required super.authId,
    this.leftEventAt,
    this.eventTo,
    super.birthdate,
    super.createdAt,
    super.myUserRelationToOtherUser,
    super.otherUserRelationToMyUser,
    super.profileImageLink,
    super.updatedAt,
    super.userRelationCounts,
    super.username,
  });

  factory EventLeftUserEntity.merge({
    bool removeMyUserRelation = false,
    required EventLeftUserEntity newEntity,
    required EventLeftUserEntity oldEntity,
  }) {
    return EventLeftUserEntity(
      eventUserLeftId: newEntity.eventUserLeftId,
      eventTo: newEntity.eventTo ?? oldEntity.eventTo,
      leftEventAt: newEntity.leftEventAt ?? oldEntity.leftEventAt,
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
