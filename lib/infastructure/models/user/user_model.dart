import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_settings_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user_settings_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_count_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_model.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String authId,
    String? username,
    String? firstname,
    String? lastname,
    String? profileImageLink,
    String? birthdate,
    UserRelationsCountEntity? userRelationCounts,
    UserRelationEntity? myUserRelationToOtherUser,
    UserRelationEntity? otherUserRelationToMyUser,
    UserSettingsEntity? settings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          authId: authId,
          username: username,
          firstname: firstname,
          lastname: lastname,
          profileImageLink: profileImageLink,
          birthdate: birthdate,
          settings: settings,
          userRelationCounts: userRelationCounts,
          myUserRelationToOtherUser: myUserRelationToOtherUser,
          otherUserRelationToMyUser: otherUserRelationToMyUser,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return UserModel(
      id: json['_id'],
      authId: json["authId"],
      username: json['username'],
      profileImageLink: json['profileImageLink'],
      firstname: json["fistname"],
      lastname: json["lastname"],
      birthdate: json["birthdate"],
      settings: json['settings'] != null
          ? UserSettingsModel.fromJson(
              json['settings'],
            )
          : null,
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
