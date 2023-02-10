import 'package:social_media_app_flutter/domain/entities/private_event/private_event_location_entity.dart';

class PrivateEventEntity {
  final String id;
  final String? title;
  final String? coverImageLink;
  final List<String>? usersThatWillBeThere;
  final List<String>? usersThatWillNotBeThere;
  final DateTime? eventDate;
  final String? connectedGroupchat;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PrivateEventLocationEntity? eventLocation;

  PrivateEventEntity({
    required this.id,
    this.title,
    this.coverImageLink,
    this.usersThatWillBeThere,
    this.usersThatWillNotBeThere,
    this.eventDate,
    this.connectedGroupchat,
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
      usersThatWillBeThere:
          newEntity.usersThatWillBeThere ?? oldEntity.usersThatWillBeThere,
      usersThatWillNotBeThere: newEntity.usersThatWillNotBeThere ??
          oldEntity.usersThatWillNotBeThere,
      eventDate: newEntity.eventDate ?? oldEntity.eventDate,
      connectedGroupchat:
          newEntity.connectedGroupchat ?? oldEntity.connectedGroupchat,
      eventLocation: newEntity.eventLocation ?? oldEntity.eventLocation,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
