enum CalendarWatchIHaveTimePermissionEnum {
  none,
  followersExcept,
  onlySelectedFollowers
}

extension CalendarWatchIHaveTimePermissionEnumExtension
    on CalendarWatchIHaveTimePermissionEnum {
  String get value {
    switch (this) {
      case CalendarWatchIHaveTimePermissionEnum.none:
        return 'NONE';
      case CalendarWatchIHaveTimePermissionEnum.followersExcept:
        return 'FOLLOWERS_EXCEPT';
      case CalendarWatchIHaveTimePermissionEnum.onlySelectedFollowers:
        return 'ONLY_SELECTED_FOLLOWERS';
      default:
        return 'NONE';
    }
  }

  static CalendarWatchIHaveTimePermissionEnum fromValue(String value) {
    switch (value) {
      case 'NONE':
        return CalendarWatchIHaveTimePermissionEnum.none;
      case 'FOLLOWERS_EXCEPT':
        return CalendarWatchIHaveTimePermissionEnum.followersExcept;
      case 'ONLY_SELECTED_FOLLOWERS':
        return CalendarWatchIHaveTimePermissionEnum.onlySelectedFollowers;
      default:
        return CalendarWatchIHaveTimePermissionEnum.none;
    }
  }
}
