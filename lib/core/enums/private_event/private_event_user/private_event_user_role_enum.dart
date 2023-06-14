enum PrivateEventUserRoleEnum {
  organizer,
  member,
}

extension PrivateEventUserRoleEnumExtension on PrivateEventUserRoleEnum {
  String get value {
    switch (this) {
      case PrivateEventUserRoleEnum.organizer:
        return 'ORGANIZER';
      case PrivateEventUserRoleEnum.member:
        return 'MEMBER';
      default:
        return 'MEMBER';
    }
  }

  static PrivateEventUserRoleEnum fromValue(String value) {
    switch (value) {
      case 'ORGANIZER':
        return PrivateEventUserRoleEnum.organizer;
      case 'MEMBER':
        return PrivateEventUserRoleEnum.member;
      default:
        return PrivateEventUserRoleEnum.member;
    }
  }
}
