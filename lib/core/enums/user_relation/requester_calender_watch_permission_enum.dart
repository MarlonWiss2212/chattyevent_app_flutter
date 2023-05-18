enum RequesterCalenderWatchPermissionEnum {
  notallowed,
  allowed,
}

extension RequesterCalenderWatchPermissionEnumExtension
    on RequesterCalenderWatchPermissionEnum {
  String get value {
    switch (this) {
      case RequesterCalenderWatchPermissionEnum.notallowed:
        return 'NOT_ALLOWED';
      case RequesterCalenderWatchPermissionEnum.allowed:
        return 'ALLOWED';
      default:
        throw Exception('Invalid value');
    }
  }

  static RequesterCalenderWatchPermissionEnum fromValue(String value) {
    switch (value) {
      case 'NOT_ALLOWED':
        return RequesterCalenderWatchPermissionEnum.notallowed;
      case 'ALLOWED':
        return RequesterCalenderWatchPermissionEnum.allowed;
      default:
        throw Exception('Invalid value');
    }
  }
}
