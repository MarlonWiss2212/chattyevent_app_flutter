enum PrivateEventUserStatusEnum {
  accapted,
  rejected,
  invited,
}

extension PrivateEventUserStatusEnumExtension on PrivateEventUserStatusEnum {
  String get value {
    switch (this) {
      case PrivateEventUserStatusEnum.accapted:
        return 'ACCEPTED';
      case PrivateEventUserStatusEnum.rejected:
        return 'REJECTED';
      case PrivateEventUserStatusEnum.invited:
        return 'INVITED';
      default:
        return 'INVITED';
    }
  }

  static PrivateEventUserStatusEnum fromValue(String value) {
    switch (value) {
      case 'ACCEPTED':
        return PrivateEventUserStatusEnum.accapted;
      case 'REJECTED':
        return PrivateEventUserStatusEnum.rejected;
      case 'INVITED':
        return PrivateEventUserStatusEnum.invited;
      default:
        return PrivateEventUserStatusEnum.invited;
    }
  }
}
