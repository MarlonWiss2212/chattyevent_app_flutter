import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';

class UserEntity {
  final String id;
  final String authId;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? emailVerified;
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
    this.email,
    this.emailVerified,
    this.profileImageLink,
    this.firstname,
    this.lastname,
    this.birthdate,
    this.lastTimeOnline,
    this.createdAt,
    this.updatedAt,
  });

  factory UserEntity.merge({
    bool removeMyUserRelation = false,
    required UserEntity newEntity,
    required UserEntity oldEntity,
  }) {
    return UserEntity(
      authId: newEntity.authId,
      id: newEntity.id,
      username: newEntity.username ?? oldEntity.username,
      email: newEntity.email ?? oldEntity.email,
      emailVerified: newEntity.emailVerified ?? oldEntity.emailVerified,
      myUserRelationToOtherUser: removeMyUserRelation
          ? null
          : UserRelationEntity.merge(
              newEntity: newEntity.myUserRelationToOtherUser ??
                  UserRelationEntity(
                      id: oldEntity.myUserRelationToOtherUser?.id ?? ""),
              oldEntity: oldEntity.myUserRelationToOtherUser ??
                  UserRelationEntity(id: ""),
            ),
      otherUserRelationToMyUser: UserRelationEntity.merge(
        newEntity: newEntity.otherUserRelationToMyUser ??
            UserRelationEntity(
                id: oldEntity.otherUserRelationToMyUser?.id ?? ""),
        oldEntity:
            oldEntity.otherUserRelationToMyUser ?? UserRelationEntity(id: ""),
      ),
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
