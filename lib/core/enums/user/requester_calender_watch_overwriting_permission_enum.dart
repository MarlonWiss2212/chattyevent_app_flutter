enum RequesterCalenderWatchOverwritingPermissionEnum {
  notallowed,
  custom,
  allowed,
}

extension RequesterCalenderWatchOverwritingPermissionEnumExtension
    on RequesterCalenderWatchOverwritingPermissionEnum {
  String get value {
    switch (this) {
      case RequesterCalenderWatchOverwritingPermissionEnum.notallowed:
        return 'NOT_ALLOWED';
      case RequesterCalenderWatchOverwritingPermissionEnum.custom:
        return 'CUSTOM';
      case RequesterCalenderWatchOverwritingPermissionEnum.allowed:
        return 'ALLOWED';
      default:
        throw Exception('Invalid value');
    }
  }

  static RequesterCalenderWatchOverwritingPermissionEnum fromValue(
      String value) {
    switch (value) {
      case 'NOT_ALLOWED':
        return RequesterCalenderWatchOverwritingPermissionEnum.notallowed;
      case 'CUSTOM':
        return RequesterCalenderWatchOverwritingPermissionEnum.custom;
      case 'ALLOWED':
        return RequesterCalenderWatchOverwritingPermissionEnum.allowed;
      default:
        throw Exception('Invalid value');
    }
  }
}
