enum EventUserRoleEnum {
  organizer,
  member,
}

extension EventUserRoleEnumExtension on EventUserRoleEnum {
  String get value {
    switch (this) {
      case EventUserRoleEnum.organizer:
        return 'ORGANIZER';
      case EventUserRoleEnum.member:
        return 'MEMBER';
      default:
        return 'MEMBER';
    }
  }

  static EventUserRoleEnum fromValue(String value) {
    switch (value) {
      case 'ORGANIZER':
        return EventUserRoleEnum.organizer;
      case 'MEMBER':
        return EventUserRoleEnum.member;
      default:
        return EventUserRoleEnum.member;
    }
  }
}
