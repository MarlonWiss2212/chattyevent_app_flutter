enum RequesterPrivateEventAddOverwritingPermissionEnum {
  none,
  custom,
  add,
}

extension RequesterPrivateEventAddOverwritingPermissionEnumExtension
    on RequesterPrivateEventAddOverwritingPermissionEnum {
  String get value {
    switch (this) {
      case RequesterPrivateEventAddOverwritingPermissionEnum.none:
        return 'NONE';
      case RequesterPrivateEventAddOverwritingPermissionEnum.custom:
        return 'CUSTOM';
      case RequesterPrivateEventAddOverwritingPermissionEnum.add:
        return 'ADD';
      default:
        throw Exception('Invalid value');
    }
  }

  static RequesterPrivateEventAddOverwritingPermissionEnum fromValue(
      String value) {
    switch (value) {
      case 'NONE':
        return RequesterPrivateEventAddOverwritingPermissionEnum.none;
      case 'ADD':
        return RequesterPrivateEventAddOverwritingPermissionEnum.add;
      case 'CUSTOM':
        return RequesterPrivateEventAddOverwritingPermissionEnum.custom;
      default:
        throw Exception('Invalid value');
    }
  }
}
