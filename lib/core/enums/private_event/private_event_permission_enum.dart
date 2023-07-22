enum PrivateEventPermissionEnum {
  everyone,
  organizersonly,
  creatoronly,
}

extension PrivateEventPermissionEnumExtension on PrivateEventPermissionEnum {
  String get value {
    switch (this) {
      case PrivateEventPermissionEnum.everyone:
        return 'EVERYONE';
      case PrivateEventPermissionEnum.organizersonly:
        return 'ORGANIZERS_ONLY';
      case PrivateEventPermissionEnum.creatoronly:
        return 'CREATOR_ONLY';
      default:
        return 'CREATOR_ONLY';
    }
  }

  static PrivateEventPermissionEnum fromValue(String value) {
    switch (value) {
      case 'EVERYONE':
        return PrivateEventPermissionEnum.everyone;
      case 'ORGANIZERS_ONLY':
        return PrivateEventPermissionEnum.organizersonly;
      case 'CREATOR_ONLY':
        return PrivateEventPermissionEnum.creatoronly;
      default:
        return PrivateEventPermissionEnum.creatoronly;
    }
  }
}
