enum GroupchatAddMePermissionEnum {
  none,
  followersExcept,
  onlySelectedFollowers
}

extension GroupchatAddMePermissionEnumExtension
    on GroupchatAddMePermissionEnum {
  String get value {
    switch (this) {
      case GroupchatAddMePermissionEnum.none:
        return 'NONE';
      case GroupchatAddMePermissionEnum.followersExcept:
        return 'FOLLOWERS_EXCEPT';
      case GroupchatAddMePermissionEnum.onlySelectedFollowers:
        return 'ONLY_SELECTED_FOLLOWERS';
      default:
        return 'NONE';
    }
  }

  static GroupchatAddMePermissionEnum fromValue(String value) {
    switch (value) {
      case 'NONE':
        return GroupchatAddMePermissionEnum.none;
      case 'FOLLOWERS_EXCEPT':
        return GroupchatAddMePermissionEnum.followersExcept;
      case 'ONLY_SELECTED_FOLLOWERS':
        return GroupchatAddMePermissionEnum.onlySelectedFollowers;
      default:
        return GroupchatAddMePermissionEnum.none;
    }
  }
}
