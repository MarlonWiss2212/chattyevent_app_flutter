import 'package:social_media_app_flutter/domain/entities/private_event/private_event_location_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';

class PrivateEventEntity {
  final String id;
  final String? title;
  final String? description;
  final String? coverImageLink;
  final String? status;
  final List<PrivateEventUserEntity>? users;
  final DateTime? eventDate;
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
    this.users,
    this.eventDate,
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
    bool mergeChatSetUsersFromOldEntity = false,
  }) {
    List<PrivateEventUserEntity>? users =
        mergeChatSetUsersFromOldEntity ? oldEntity.users : [];
    if (newEntity.users != null) {
      for (final newUser in newEntity.users!) {
        if (users == null) {
          users ??= [];
          users.add(newUser);
          continue;
        }
        final userIndex = users.indexWhere(
          (element) => element.id == newUser.id,
        );
        if (userIndex == -1) {
          users.add(newUser);
        } else {
          users[userIndex] = PrivateEventUserEntity.merge(
            newEntity: newUser,
            oldEntity: users[userIndex],
          );
        }
      }
    }

    return PrivateEventEntity(
      id: newEntity.id,
      title: newEntity.title ?? oldEntity.title,
      coverImageLink: newEntity.coverImageLink ?? oldEntity.coverImageLink,
      users: users,
      eventDate: newEntity.eventDate ?? oldEntity.eventDate,
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
