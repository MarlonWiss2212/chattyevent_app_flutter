enum GroupchatPermissionEnum {
  everyone,
  adminsonly,
}

extension GroupchatPermissionEnumExtension on GroupchatPermissionEnum {
  String get value {
    switch (this) {
      case GroupchatPermissionEnum.everyone:
        return 'EVERYONE';
      case GroupchatPermissionEnum.adminsonly:
        return 'ADMINS_ONLY';
      default:
        return 'ADMINS_ONLY';
    }
  }

  static GroupchatPermissionEnum fromValue(String value) {
    switch (value) {
      case 'EVERYONE':
        return GroupchatPermissionEnum.everyone;
      case 'ADMINS_ONLY':
        return GroupchatPermissionEnum.adminsonly;
      default:
        return GroupchatPermissionEnum.adminsonly;
    }
  }
}
