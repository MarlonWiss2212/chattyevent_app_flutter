enum PrivateEventPermissionEnum {
  everyone,
  organizersonly,
  createronly,
}

extension PrivateEventPermissionEnumExtension on PrivateEventPermissionEnum {
  String get value {
    switch (this) {
      case PrivateEventPermissionEnum.everyone:
        return 'EVERYONE';
      case PrivateEventPermissionEnum.organizersonly:
        return 'ORGANIZERS_ONLY';
      case PrivateEventPermissionEnum.createronly:
        return 'CREATER_ONLY';
      default:
        throw Exception('Invalid value');
    }
  }

  static PrivateEventPermissionEnum fromValue(String value) {
    switch (value) {
      case 'EVERYONE':
        return PrivateEventPermissionEnum.everyone;
      case 'ORGANIZERS_ONLY':
        return PrivateEventPermissionEnum.organizersonly;
      case 'CREATER_ONLY':
        return PrivateEventPermissionEnum.createronly;
      default:
        throw Exception('Invalid value');
    }
  }
}
