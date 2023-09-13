import 'package:chattyevent_app_flutter/domain/entities/event/event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_count_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_model.dart';

class EventLeftUserModel extends EventLeftUserEntity {
  EventLeftUserModel({
    required String id,
    required String eventUserLeftId,
    required String authId,
    String? eventTo,
    DateTime? leftEventAt,
    String? username,
    String? profileImageLink,
    DateTime? birthdate,
    UserRelationsCountEntity? userRelationCounts,
    UserRelationEntity? myUserRelationToOtherUser,
    UserRelationEntity? otherUserRelationToMyUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          eventUserLeftId: eventUserLeftId,
          eventTo: eventTo,
          leftEventAt: leftEventAt,
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

  factory EventLeftUserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;
    final birthdate = json["birthdate"] != null
        ? DateTime.parse(json["birthdate"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;
    final leftEventAt = json["leftEventAt"] != null
        ? DateTime.parse(json["leftEventAt"]).toLocal()
        : null;

    return EventLeftUserModel(
      eventUserLeftId: json["eventUserLeftId"],
      eventTo: json["eventTo"],
      leftEventAt: leftEventAt,
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
