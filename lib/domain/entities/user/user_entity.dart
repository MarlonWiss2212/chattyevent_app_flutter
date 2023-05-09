import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_settings_entity.dart';

class UserEntity {
  final String id;
  final String authId;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? profileImageLink;
  final String? birthdate;
  final UserRelationsCountEntity? userRelationCounts;
  final UserRelationEntity? myUserRelationToOtherUser;
  final UserRelationEntity? otherUserRelationToMyUser;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserSettingsEntity? settings;

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
    this.createdAt,
    this.updatedAt,
    this.settings,
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
      settings: newEntity.settings ?? oldEntity.settings,
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
