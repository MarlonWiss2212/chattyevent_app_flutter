class FindFollowersFilter {
  final String targetUserId;
  final bool? filterForPrivateEventAddMeAllowedUsers;
  final bool? filterForGroupchatAddMeAllowedUsers;
  final bool? filterForCalendarWatchIHaveTimeAllowedUsers;
  final bool? sortForCalendarWatchIHaveTimeAllowedUsersFirst;
  final bool? sortForPrivateEventAddMeAllowedUsersFirst;
  final bool? sortForGroupchatAddMeAllowedUsersFirst;
  final String? search;

  FindFollowersFilter({
    required this.targetUserId,
    this.filterForPrivateEventAddMeAllowedUsers,
    this.filterForGroupchatAddMeAllowedUsers,
    this.filterForCalendarWatchIHaveTimeAllowedUsers,
    this.sortForCalendarWatchIHaveTimeAllowedUsersFirst,
    this.sortForPrivateEventAddMeAllowedUsersFirst,
    this.sortForGroupchatAddMeAllowedUsersFirst,
    this.search,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"targetUserId": targetUserId};

    if (search != null) {
      map.addAll({"search": search});
    }

    if (filterForPrivateEventAddMeAllowedUsers != null) {
      map.addAll({
        "filterForPrivateEventAddMeAllowedUsers":
            filterForPrivateEventAddMeAllowedUsers,
      });
    }
    if (filterForGroupchatAddMeAllowedUsers != null) {
      map.addAll({
        "filterForGroupchatAddMeAllowedUsers":
            filterForGroupchatAddMeAllowedUsers,
      });
    }
    if (filterForCalendarWatchIHaveTimeAllowedUsers != null) {
      map.addAll({
        "filterForCalendarWatchIHaveTimeAllowedUsers":
            filterForCalendarWatchIHaveTimeAllowedUsers,
      });
    }
    if (sortForCalendarWatchIHaveTimeAllowedUsersFirst != null) {
      map.addAll({
        "sortForCalendarWatchIHaveTimeAllowedUsersFirst":
            sortForCalendarWatchIHaveTimeAllowedUsersFirst,
      });
    }
    if (sortForGroupchatAddMeAllowedUsersFirst != null) {
      map.addAll({
        "sortForGroupchatAddMeAllowedUsersFirst":
            sortForGroupchatAddMeAllowedUsersFirst,
      });
    }
    if (sortForPrivateEventAddMeAllowedUsersFirst != null) {
      map.addAll({
        "sortForPrivateEventAddMeAllowedUsersFirst":
            sortForPrivateEventAddMeAllowedUsersFirst,
      });
    }

    return map;
  }
}
