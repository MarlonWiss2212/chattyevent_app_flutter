import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/user_relation/user_relation_count_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/user_relation/user_relation_model.dart';

class GroupchatLeftUserModel extends GroupchatLeftUserEntity {
  GroupchatLeftUserModel({
    required String id,
    required String groupchatUserLeftId,
    required String authId,
    String? groupchatTo,
    DateTime? leftGroupchatAt,
    String? usernameForChat,
    String? username,
    String? profileImageLink,
    DateTime? birthdate,
    UserRelationsCountEntity? userRelationCounts,
    UserRelationEntity? myUserRelationToOtherUser,
    UserRelationEntity? otherUserRelationToMyUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          groupchatUserLeftId: groupchatUserLeftId,
          groupchatTo: groupchatTo,
          leftGroupchatAt: leftGroupchatAt,
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

  factory GroupchatLeftUserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;
    final birthdate = json["birthdate"] != null
        ? DateTime.parse(json["birthdate"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;
    final leftGroupchatAt = json["leftChatAt"] != null
        ? DateTime.parse(json["leftChatAt"]).toLocal()
        : null;

    return GroupchatLeftUserModel(
      groupchatUserLeftId: json["groupchatUserLeftId"],
      groupchatTo: json["groupchatTo"],
      leftGroupchatAt: leftGroupchatAt,
      usernameForChat: json["usernameForChat"],
      id: json['_id'],
      authId: json["authId"],
      username: json['username'],
      profileImageLink: json['profileImageLink'],
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
}
