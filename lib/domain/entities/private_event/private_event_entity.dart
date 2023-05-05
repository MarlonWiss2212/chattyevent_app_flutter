import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_location_entity.dart';

class PrivateEventEntity {
  final String id;
  final String? title;
  final String? description;
  final String? coverImageLink;
  final String? status;
  final DateTime eventDate;
  final DateTime? eventEndDate;
  final String? groupchatTo;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PrivateEventLocationEntity? eventLocation;

  PrivateEventEntity({
    required this.id,
    this.title,
    this.status,
    this.description,
    this.coverImageLink,
    required this.eventDate,
    this.eventEndDate,
    this.groupchatTo,
    this.createdBy,
    this.createdAt,
    this.eventLocation,
    this.updatedAt,
  });

  factory PrivateEventEntity.merge({
    required PrivateEventEntity newEntity,
    required PrivateEventEntity oldEntity,
  }) {
    return PrivateEventEntity(
      id: newEntity.id,
      title: newEntity.title ?? oldEntity.title,
      coverImageLink: newEntity.coverImageLink ?? oldEntity.coverImageLink,
      eventDate: newEntity.eventDate,
      eventEndDate: newEntity.eventEndDate ?? oldEntity.eventEndDate,
      groupchatTo: newEntity.groupchatTo ?? oldEntity.groupchatTo,
      status: newEntity.status ?? oldEntity.status,
      eventLocation: PrivateEventLocationEntity.merge(
        newEntity: newEntity.eventLocation ?? PrivateEventLocationEntity(),
        oldEntity: oldEntity.eventLocation ?? PrivateEventLocationEntity(),
      ),
      description: newEntity.description ?? oldEntity.description,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
