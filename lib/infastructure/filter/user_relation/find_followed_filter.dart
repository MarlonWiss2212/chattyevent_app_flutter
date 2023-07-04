class FindFollowedFilter {
  final String requesterUserId;
  final bool? filterForPrivateEventAddMeAllowedUsers;
  final bool? filterForGroupchatAddMeAllowedUsers;
  final String? search;

  FindFollowedFilter({
    required this.requesterUserId,
    this.filterForGroupchatAddMeAllowedUsers,
    this.filterForPrivateEventAddMeAllowedUsers,
    this.search,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"requesterUserId": requesterUserId};

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
    return map;
  }
}
