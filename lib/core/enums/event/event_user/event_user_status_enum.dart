enum EventUserStatusEnum {
  accapted,
  rejected,
  invited,
}

extension PrivateEventUserStatusEnumExtension on EventUserStatusEnum {
  String get value {
    switch (this) {
      case EventUserStatusEnum.accapted:
        return 'ACCEPTED';
      case EventUserStatusEnum.rejected:
        return 'REJECTED';
      case EventUserStatusEnum.invited:
        return 'INVITED';
      default:
        return 'INVITED';
    }
  }

  static EventUserStatusEnum fromValue(String value) {
    switch (value) {
      case 'ACCEPTED':
        return EventUserStatusEnum.accapted;
      case 'REJECTED':
        return EventUserStatusEnum.rejected;
      case 'INVITED':
        return EventUserStatusEnum.invited;
      default:
        return EventUserStatusEnum.invited;
    }
  }
}
