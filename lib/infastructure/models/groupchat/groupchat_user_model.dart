import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_user/groupchat_user_role_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_count_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_model.dart';

class GroupchatUserModel extends GroupchatUserEntity {
  GroupchatUserModel({
    required String id,
    required String groupchatUserId,
    required String authId,
    String? groupchatTo,
    GroupchatUserRoleEnum? role,
    DateTime? joinedGroupchatAt,
    String? usernameForChat,
    String? username,
    String? profileImageLink,
    String? birthdate,
    UserRelationsCountEntity? userRelationCounts,
    UserRelationEntity? myUserRelationToOtherUser,
    UserRelationEntity? otherUserRelationToMyUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          groupchatUserId: groupchatUserId,
          groupchatTo: groupchatTo,
          joinedGroupchatAt: joinedGroupchatAt,
          role: role,
          usernameForChat: usernameForChat,
          id: id,
          authId: authId,
          username: username,
          profileImageLink: profileImageLink,
          birthdate: birthdate,
          userRelationCounts: userRelationCounts,
          myUserRelationToOtherUser: myUserRelationToOtherUser,
          otherUserRelationToMyUser: otherUserRelationToMyUser,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory GroupchatUserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;
    final joinedGroupchatAt = json["joinedGroupchatAt"] != null
        ? DateTime.parse(json["joinedGroupchatAt"]).toLocal()
        : null;

    return GroupchatUserModel(
      groupchatUserId: json["groupchatUserId"],
      groupchatTo: json["groupchatTo"],
      joinedGroupchatAt: joinedGroupchatAt,
      role: json["role"] != null
          ? GroupchatUserRoleEnumExtension.fromValue(json["role"])
          : null,
      usernameForChat: json["usernameForChat"],
      id: json['_id'],
      authId: json["authId"],
      username: json['username'],
      profileImageLink: json['profileImageLink'],
      birthdate: json["birthdate"],
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
}
