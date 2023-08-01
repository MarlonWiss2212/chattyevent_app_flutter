import 'package:chattyevent_app_flutter/core/enums/calendar/calendar_status_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/calendar/calendar_time_user_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_count_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_model.dart';

class CalendarTimeUserModel extends CalendarTimeUserEntity {
  CalendarTimeUserModel({
    required super.id,
    required super.authId,
    super.myUserRelationToOtherUser,
    super.otherUserRelationToMyUser,
    super.userRelationCounts,
    super.username,
    super.profileImageLink,
    super.birthdate,
    super.createdAt,
    super.updatedAt,
    super.status,
  });

  factory CalendarTimeUserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return CalendarTimeUserModel(
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
      status: json["status"] != null
          ? CalendarStatusEnumExtension.fromValue(json["status"])
          : null,
    );
  }
}
