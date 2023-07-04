enum PrivateEventAddMePermissionEnum {
  none,
  followersExcept,
  onlySelectedFollowers
}

extension PrivateEventAddMePermissionEnumExtension
    on PrivateEventAddMePermissionEnum {
  String get value {
    switch (this) {
      case PrivateEventAddMePermissionEnum.none:
        return 'NONE';
      case PrivateEventAddMePermissionEnum.followersExcept:
        return 'FOLLOWERS_EXCEPT';
      case PrivateEventAddMePermissionEnum.onlySelectedFollowers:
        return 'ONLY_SELECTED_FOLLOWERS';
      default:
        return 'NONE';
    }
  }

  static PrivateEventAddMePermissionEnum fromValue(String value) {
    switch (value) {
      case 'NONE':
        return PrivateEventAddMePermissionEnum.none;
      case 'FOLLOWERS_EXCEPT':
        return PrivateEventAddMePermissionEnum.followersExcept;
      case 'ONLY_SELECTED_FOLLOWERS':
        return PrivateEventAddMePermissionEnum.onlySelectedFollowers;
      default:
        return PrivateEventAddMePermissionEnum.none;
    }
  }
}
