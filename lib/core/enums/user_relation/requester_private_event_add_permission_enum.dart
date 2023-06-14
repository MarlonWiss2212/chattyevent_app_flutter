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
        return 'NONE';
    }
  }

  static RequesterPrivateEventAddPermissionEnum fromValue(String value) {
    switch (value) {
      case 'NONE':
        return RequesterPrivateEventAddPermissionEnum.none;
      case 'ADD':
        return RequesterPrivateEventAddPermissionEnum.add;
      default:
        return RequesterPrivateEventAddPermissionEnum.none;
    }
  }
}
