import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_permissions_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/message/message_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/user/user_permissions_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/user_relation/user_relation_count_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/user_relation/user_relation_model.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String authId,
    String? username,
    String? profileImageLink,
    DateTime? birthdate,
    UserRelationsCountEntity? userRelationCounts,
    UserRelationEntity? myUserRelationToOtherUser,
    UserRelationEntity? otherUserRelationToMyUser,
    MessageEntity? latestMessage,
    UserPermissionsEntity? permissions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          authId: authId,
          permissions: permissions,
          username: username,
          profileImageLink: profileImageLink,
          birthdate: birthdate,
          userRelationCounts: userRelationCounts,
          myUserRelationToOtherUser: myUserRelationToOtherUser,
          otherUserRelationToMyUser: otherUserRelationToMyUser,
          createdAt: createdAt,
          updatedAt: updatedAt,
          latestMessage: latestMessage,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    final birthdate = json["birthdate"] != null
        ? DateTime.parse(json["birthdate"]).toLocal()
        : null;

    return UserModel(
      id: json['_id'],
      authId: json["authId"],
      username: json['username'],
      permissions: json["permissions"] != null
          ? UserPermissionsModel.fromJson(json["permissions"])
          : null,
      profileImageLink: json['profileImageLink'],
      latestMessage: json["latestMessage"] != null
          ? MessageModel.fromJson(json["latestMessage"])
          : null,
      birthdate: birthdate,
      userRelationCounts: json['userRelationCounts'] != null
          ? UserRelationsCountModel.fromJson(
              json['userRelationCounts'],
            )
          : null,
      otherUserRelationToMyUser: json['otherUserRelationToMyUser'] != null
          ? UserRelationModel.fromJson(
              json['otherUserRelationToMyUser'],
            )
          : null,
      myUserRelationToOtherUser: json['myUserRelationToOtherUser'] != null
          ? UserRelationModel.fromJson(
              json['myUserRelationToOtherUser'],
            )
          : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static String userFullQuery({required bool userIsCurrentUser}) {
    return """
      username
      _id
      authId
      createdAt      
      profileImageLink
      updatedAt
      userRelationCounts {
        followerCount
        followedCount
        followRequestCount
      }
      ${userIsCurrentUser == true ? """
      birthdate
      permissions {
        groupchatAddMe {
          permission
          exceptUserIds
          selectedUserIds
        }
        privateEventAddMe {
          permission
          exceptUserIds
          selectedUserIds
        }
        calendarWatchIHaveTime {
          permission
          exceptUserIds
          selectedUserIds
        }
      }
      """ : """
      myUserRelationToOtherUser {
        _id
        createdAt
        updatedAt
        status
        followData {
          followedUserAt
        }
      }
      otherUserRelationToMyUser {
        _id
        createdAt
        updatedAt
        status
        followData {
          followedUserAt
        }
      }
    """}
    """;
  }
}
