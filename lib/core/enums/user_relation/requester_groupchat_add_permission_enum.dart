enum RequesterGroupchatAddPermissionEnum {
  none,
  add,
}

extension RequesterGroupchatAddPermissionEnumExtension
    on RequesterGroupchatAddPermissionEnum {
  String get value {
    switch (this) {
      case RequesterGroupchatAddPermissionEnum.none:
        return 'NONE';
      case RequesterGroupchatAddPermissionEnum.add:
        return 'ADD';
      default:
        throw Exception('Invalid value');
    }
  }

  static RequesterGroupchatAddPermissionEnum fromValue(String value) {
    switch (value) {
      case 'NONE':
        return RequesterGroupchatAddPermissionEnum.none;
      case 'ADD':
        return RequesterGroupchatAddPermissionEnum.add;
      default:
        throw Exception('Invalid value');
    }
  }
}
