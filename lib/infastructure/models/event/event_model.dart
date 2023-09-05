import 'package:chattyevent_app_flutter/core/enums/event/event_status_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/private_event_data_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_location_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_permissions_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/event/event_location_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/event/private_event_data_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/message/message_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/event/event_permissions_model.dart';

class EventModel extends EventEntity {
  EventModel({
    required String id,
    String? title,
    EventStatusEnum? status,
    String? description,
    String? coverImageLink,
    bool? autoDelete,
    required DateTime eventDate,
    DateTime? eventEndDate,
    EventPermissionsEntity? permissions,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    EventTypeEnum? type,
    PrivateEventDataEntity? privateEventData,
    EventLocationEntity? eventLocation,
    MessageEntity? latestMessage,
  }) : super(
          id: id,
          permissions: permissions,
          title: title,
          type: type,
          privateEventData: privateEventData,
          coverImageLink: coverImageLink,
          description: description,
          eventDate: eventDate,
          eventEndDate: eventEndDate,
          status: status,
          createdAt: createdAt,
          autoDelete: autoDelete,
          updatedAt: updatedAt,
          createdBy: createdBy,
          latestMessage: latestMessage,
          eventLocation: eventLocation,
        );

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    final eventDate = DateTime.parse(json["eventDate"]).toLocal();

    final eventEndDate = json["eventEndDate"] != null
        ? DateTime.parse(json["eventEndDate"]).toLocal()
        : null;

    return EventModel(
      id: json['_id'],
      title: json['title'],
      coverImageLink: json['coverImageLink'],
      eventDate: eventDate,
      description: json["description"],
      autoDelete: json["autoDelete"],
      eventEndDate: eventEndDate,
      permissions: json["permissions"] != null
          ? EventPermissionsModel.fromJson(json["permissions"])
          : null,
      status: json["status"] != null
          ? PrivateEventStatusEnumExtension.fromValue(json["status"])
          : null,
      latestMessage: json["latestMessage"] != null
          ? MessageModel.fromJson(json["latestMessage"])
          : null,
      createdBy: json["createdBy"],
      type: json["type"] != null
          ? EventTypeEnumExtension.fromValue(json["type"])
          : null,
      privateEventData: json["privateEventData"] != null
          ? PrivateEventDataModel.fromJson(json["privateEventData"])
          : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
      eventLocation: json["eventLocation"] != null
          ? EventLocationModel.fromJson(json["eventLocation"])
          : null,
    );
  }

  static String eventFullQuery() {
    return """
    _id
    type
    privateEventData {
      groupchatTo
    }
    title
    description
    status
    coverImageLink
    eventDate
    eventEndDate
    eventLocation {
      geoJson {
        type
        coordinates
      }
      address {
        zip
        city
        country
        street
        housenumber
      }
    }
    permissions {
      changeTitle
      changeDescription
      changeCoverImage
      changeAddress
      changeDate
      changeStatus
      addUsers
      addShoppingListItem
      updateShoppingListItem
      deleteShoppingListItem
    }
    createdBy
    createdAt
    """;
  }

  static String eventLightQuery({required bool alsoLatestMessage}) {
    return """
      _id
      status
      title
      type
      privateEventData {
        groupchatTo
      }
      eventDate
      eventEndDate
      eventLocation {
        geoJson {
          type
          coordinates
        }
      }
      coverImageLink
      ${alsoLatestMessage ? """
      latestMessage {
        _id
        readBy
        message
        messageToReactTo {
          _id
          readBy
          message
          fileLinks
          eventTo
          updatedAt
          createdBy
          createdAt
        }
        fileLinks
        eventTo
        updatedAt
        createdBy
        createdAt
      }
      """ : ""}
    """;
  }
}
