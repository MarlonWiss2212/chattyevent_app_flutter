import 'package:chattyevent_app_flutter/core/enums/request/request_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/event/event_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/request/invitation_data_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/request/join_request_data_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user_model.dart';

class RequestModel extends RequestEntity {
  RequestModel({
    required super.createdAt,
    required super.updatedAt,
    required super.createdBy,
    required super.id,
    required super.type,
    super.invitationData,
    super.joinRequestData,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    final DateTime createdAt = DateTime.parse(json["createdAt"]).toLocal();
    final DateTime updatedAt = DateTime.parse(json["updatedAt"]).toLocal();

    return RequestModel(
      id: json["_id"],
      createdAt: createdAt,
      updatedAt: updatedAt,
      type: RequestTypeEnumExtension.fromValue(json["type"]),
      createdBy: UserModel.fromJson(json["createdBy"]),
      invitationData: json["invitationData"] != null
          ? InvitationDataModel.fromJson(json["invitationData"])
          : null,
      joinRequestData: json["joinRequestData"] != null
          ? JoinRequestDataModel.fromJson(json["joinRequestData"])
          : null,
    );
  }

  static String requestFullQuery() {
    return """
      _id
      createdAt
      updatedAt
      type
      invitationData {
        invitedUser {
          ${UserModel.userFullQuery(userIsCurrentUser: false)}
        }
        eventUser {
          event {
            ${EventModel.eventLightQuery(alsoLatestMessage: false)}
          }
          role
        }
        groupchatUser {
          groupchat {
            ${GroupchatModel.groupchatLightQuery(alsoLatestMessage: false)}
          }
          role
        }
      }
      joinRequestData {
        groupchat {
          ${GroupchatModel.groupchatLightQuery(alsoLatestMessage: false)}
        }
        event {
          ${EventModel.eventLightQuery(alsoLatestMessage: false)}
        }
      }
      createdBy {
        ${UserModel.userFullQuery(userIsCurrentUser: false)}
      }
    """;
  }
}
