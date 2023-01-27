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
  });
}
