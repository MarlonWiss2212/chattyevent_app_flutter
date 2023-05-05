import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relations_count_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_count_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_model.dart';

class PrivateEventUserModel extends PrivateEventUserEntity {
  PrivateEventUserModel({
    required String id,
    required String privateEventUserId,
    required String authId,
    String? privateEventTo,
    String? status,
    bool? organizer,
    DateTime? joinedPrivateEventAt,
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
          privateEventUserId: privateEventUserId,
          privateEventTo: privateEventTo,
          joinedPrivateEventAt: joinedPrivateEventAt,
          status: status,
          organizer: organizer,
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

  factory PrivateEventUserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;
    final joinedPrivateEventAt = json["joinedEventAt"] != null
        ? DateTime.parse(json["joinedEventAt"]).toLocal()
        : null;

    return PrivateEventUserModel(
      privateEventUserId: json["privateEventUserId"],
      privateEventTo: json["privateEventTo"],
      joinedPrivateEventAt: joinedPrivateEventAt,
      organizer: json["organizer"],
      status: json["status"],
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
