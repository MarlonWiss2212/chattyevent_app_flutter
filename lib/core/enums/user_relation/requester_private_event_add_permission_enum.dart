enum RequesterPrivateEventAddPermissionEnum {
  none,
  add,
}

extension RequesterPrivateEventAddPermissionEnumExtension
    on RequesterPrivateEventAddPermissionEnum {
  String get value {
    switch (this) {
      case RequesterPrivateEventAddPermissionEnum.none:
        return 'NONE';
      case RequesterPrivateEventAddPermissionEnum.add:
        return 'ADD';
      default:
        throw Exception('Invalid value');
    }
  }

  static RequesterPrivateEventAddPermissionEnum fromValue(String value) {
    switch (value) {
      case 'NONE':
        return RequesterPrivateEventAddPermissionEnum.none;
      case 'ADD':
        return RequesterPrivateEventAddPermissionEnum.add;
      default:
        throw Exception('Invalid value');
    }
  }
}
