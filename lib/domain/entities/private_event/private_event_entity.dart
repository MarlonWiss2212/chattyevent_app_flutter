import 'package:social_media_app_flutter/domain/entities/private_event/private_event_location_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';

class PrivateEventEntity {
  final String id;
  final String? title;
  final String? coverImageLink;
  final List<PrivateEventUserEntity>? users;
  final DateTime? eventDate;
  final String? groupchatTo;
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
    this.groupchatTo,
    this.createdBy,
    this.createdAt,
    this.eventLocation,
    this.updatedAt,
  });

  factory PrivateEventEntity.merge({
    required PrivateEventEntity newEntity,
    required PrivateEventEntity oldEntity,
    bool setUsersFromOldEntity = false,
  }) {
    List<PrivateEventUserEntity>? users =
        setUsersFromOldEntity ? oldEntity.users : [];
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
      groupchatTo: newEntity.groupchatTo ?? oldEntity.groupchatTo,
      eventLocation: PrivateEventLocationEntity.merge(
        newEntity: newEntity.eventLocation ?? PrivateEventLocationEntity(),
        oldEntity: oldEntity.eventLocation ?? PrivateEventLocationEntity(),
      ),
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
