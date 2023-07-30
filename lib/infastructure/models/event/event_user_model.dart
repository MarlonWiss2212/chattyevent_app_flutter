import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_status_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_count_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_model.dart';

class EventUserModel extends EventUserEntity {
  EventUserModel({
    required String id,
    required String eventUserId,
    required String authId,
    String? eventTo,
    EventUserStatusEnum? status,
    EventUserRoleEnum? role,
    DateTime? joinedEventAt,
    String? username,
    String? firstname,
    String? lastname,
    String? profileImageLink,
    String? birthdate,
    UserRelationsCountEntity? userRelationCounts,
    UserRelationEntity? myUserRelationToOtherUser,
    UserRelationEntity? otherUserRelationToMyUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          eventUserId: eventUserId,
          eventTo: eventTo,
          joinedEventAt: joinedEventAt,
          status: status,
          role: role,
          id: id,
          authId: authId,
          username: username,
          firstname: firstname,
          lastname: lastname,
          profileImageLink: profileImageLink,
          birthdate: birthdate,
          userRelationCounts: userRelationCounts,
          myUserRelationToOtherUser: myUserRelationToOtherUser,
          otherUserRelationToMyUser: otherUserRelationToMyUser,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory EventUserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;
    final joinedEventAt = json["joinedEventAt"] != null
        ? DateTime.parse(json["joinedEventAt"]).toLocal()
        : null;

    return EventUserModel(
      eventUserId: json["eventUserId"],
      eventTo: json["eventTo"],
      joinedEventAt: joinedEventAt,
      role: json["role"] != null
          ? EventUserRoleEnumExtension.fromValue(json["role"])
          : null,
      status: json["status"] != null
          ? PrivateEventUserStatusEnumExtension.fromValue(json["status"])
          : null,
      id: json['_id'],
      authId: json["authId"],
      username: json['username'],
      profileImageLink: json['profileImageLink'],
      firstname: json["fistname"],
      lastname: json["lastname"],
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
