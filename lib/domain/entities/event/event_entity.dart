import 'package:chattyevent_app_flutter/core/enums/event/event_status_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/private_event_data_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_location_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_permissions_entity.dart';

class EventEntity {
  final String id;
  final String? title;
  final String? description;
  final String? coverImageLink;
  final EventStatusEnum? status;
  final EventPermissionsEntity? permissions;
  final DateTime eventDate;
  final DateTime? eventEndDate;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? autoDelete;
  final PrivateEventDataEntity? privateEventData;
  final EventTypeEnum? type;
  final EventLocationEntity? eventLocation;
  final MessageEntity? latestMessage;

  EventEntity({
    required this.id,
    this.title,
    this.permissions,
    this.latestMessage,
    this.status,
    this.type,
    this.privateEventData,
    this.description,
    this.autoDelete,
    this.coverImageLink,
    required this.eventDate,
    this.eventEndDate,
    this.createdBy,
    this.createdAt,
    this.eventLocation,
    this.updatedAt,
  });

  factory EventEntity.merge({
    required EventEntity newEntity,
    required EventEntity oldEntity,
  }) {
    return EventEntity(
      id: newEntity.id,
      autoDelete: newEntity.autoDelete ?? oldEntity.autoDelete,
      type: newEntity.type ?? oldEntity.type,
      privateEventData:
          newEntity.privateEventData ?? oldEntity.privateEventData,
      title: newEntity.title ?? oldEntity.title,
      coverImageLink: newEntity.coverImageLink ?? oldEntity.coverImageLink,
      eventDate: newEntity.eventDate,
      eventEndDate: newEntity.eventEndDate ?? oldEntity.eventEndDate,
      permissions: newEntity.permissions ?? oldEntity.permissions,
      status: newEntity.status ?? oldEntity.status,
      latestMessage: newEntity.latestMessage ?? oldEntity.latestMessage,
      eventLocation: EventLocationEntity.merge(
        newEntity: newEntity.eventLocation ?? EventLocationEntity(),
        oldEntity: oldEntity.eventLocation ?? EventLocationEntity(),
      ),
      description: newEntity.description ?? oldEntity.description,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
