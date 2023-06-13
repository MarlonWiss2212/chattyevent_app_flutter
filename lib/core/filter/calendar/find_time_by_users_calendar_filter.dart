class FindTimeByUsersCalendarFilter {
  final String? groupchatId;
  final List<String>? userIds;
  final DateTime startDate;
  final DateTime endDate;

  FindTimeByUsersCalendarFilter({
    this.groupchatId,
    this.userIds,
    required this.endDate,
    required this.startDate,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"startDate": startDate, "endDate": startDate};

    if (groupchatId != null) {
      map.addAll({"groupchatId": groupchatId});
    }
    if (userIds != null) {
      map.addAll({"userIds": userIds});
    }
    return map;
  }
}
