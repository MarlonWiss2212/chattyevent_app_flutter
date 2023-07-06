class FindFollowersFilter {
  final String targetUserId;
  final bool? filterForPrivateEventAddMeAllowedUsers;
  final bool? filterForGroupchatAddMeAllowedUsers;
  final bool? sortForPrivateEventAddMeAllowedUsersFirst;
  final bool? sortForGroupchatAddMeAllowedUsersFirst;
  final String? search;

  FindFollowersFilter({
    required this.targetUserId,
    this.filterForPrivateEventAddMeAllowedUsers,
    this.filterForGroupchatAddMeAllowedUsers,
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
