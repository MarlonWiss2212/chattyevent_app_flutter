enum RequesterGroupchatAddOverwritingPermissionEnum {
  none,
  custom,
  add,
}

extension RequesterGroupchatAddOverwritingPermissionEnumExtension
    on RequesterGroupchatAddOverwritingPermissionEnum {
  String get value {
    switch (this) {
      case RequesterGroupchatAddOverwritingPermissionEnum.none:
        return 'NONE';
      case RequesterGroupchatAddOverwritingPermissionEnum.custom:
        return 'CUSTOM';
      case RequesterGroupchatAddOverwritingPermissionEnum.add:
        return 'ADD';
      default:
        throw Exception('Invalid value');
    }
  }

  static RequesterGroupchatAddOverwritingPermissionEnum fromValue(
      String value) {
    switch (value) {
      case 'NONE':
        return RequesterGroupchatAddOverwritingPermissionEnum.none;
      case 'ADD':
        return RequesterGroupchatAddOverwritingPermissionEnum.add;
      case 'CUSTOM':
        return RequesterGroupchatAddOverwritingPermissionEnum.custom;
      default:
        throw Exception('Invalid value');
    }
  }
}
