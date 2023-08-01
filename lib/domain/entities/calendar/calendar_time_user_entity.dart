import 'package:chattyevent_app_flutter/core/enums/calendar/calendar_status_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class CalendarTimeUserEntity extends UserEntity {
  final CalendarStatusEnum? status;
  CalendarTimeUserEntity({
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
    this.status,
  });
}
