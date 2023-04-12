import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';

class UserEntity {
  final String id;
  final String authId;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? profileImageLink;
  final String? birthdate;
  final String? lastTimeOnline;
  final UserRelationsCountEntity? userRelationCounts;
  final UserRelationEntity? myUserRelationToOtherUser;
  final UserRelationEntity? otherUserRelationToMyUser;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.authId,
    this.myUserRelationToOtherUser,
    this.otherUserRelationToMyUser,
    this.userRelationCounts,
    this.username,
    this.profileImageLink,
    this.firstname,
    this.lastname,
    this.birthdate,
    this.lastTimeOnline,
    this.createdAt,
    this.updatedAt,
  });

  /// only use this when changing a value
  factory UserEntity.merge({
    bool removeMyUserRelation = false,
    required UserEntity newEntity,
    required UserEntity oldEntity,
  }) {
    return UserEntity(
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
