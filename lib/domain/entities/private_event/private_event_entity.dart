import 'package:social_media_app_flutter/domain/entities/private_event/private_event_location_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';

class PrivateEventEntity {
  final String id;
  final String? title;
  final String? coverImageLink;
  final List<PrivateEventUserEntity>? users;
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
    this.users,
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
    List<PrivateEventUserEntity>? users;
    if (newEntity.users != null) {
      for (final newUser in newEntity.users!) {
        users ??= [];
        if (oldEntity.users == null) {
          users.add(newUser);
          break;
        }
        final oldUserIndex = oldEntity.users!.indexWhere(
          (element) => element.id == newUser.id,
        );
        if (oldUserIndex == -1) {
          users.add(newUser);
        } else {
          users.add(PrivateEventUserEntity.merge(
            newEntity: newUser,
            oldEntity: oldEntity.users![oldUserIndex],
          ));
        }
      }
    } else {
      users = oldEntity.users;
    }

    return PrivateEventEntity(
      id: newEntity.id,
      title: newEntity.title ?? oldEntity.title,
      coverImageLink: newEntity.coverImageLink ?? oldEntity.coverImageLink,
      users: users,
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
