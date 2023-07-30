enum EventPermissionEnum {
  everyone,
  organizersonly,
  creatoronly,
}

extension EventPermissionEnumExtension on EventPermissionEnum {
  String get value {
    switch (this) {
      case EventPermissionEnum.everyone:
        return 'EVERYONE';
      case EventPermissionEnum.organizersonly:
        return 'ORGANIZERS_ONLY';
      case EventPermissionEnum.creatoronly:
        return 'CREATOR_ONLY';
      default:
        return 'CREATOR_ONLY';
    }
  }

  static EventPermissionEnum fromValue(String value) {
    switch (value) {
      case 'EVERYONE':
        return EventPermissionEnum.everyone;
      case 'ORGANIZERS_ONLY':
        return EventPermissionEnum.organizersonly;
      case 'CREATOR_ONLY':
        return EventPermissionEnum.creatoronly;
      default:
        return EventPermissionEnum.creatoronly;
    }
  }
}
