class CheckTimeByUsersCalendarFilter {
  final String? groupchatId;
  final List<String>? userIds;
  final DateTime? endDate;
  final DateTime startDate;

  CheckTimeByUsersCalendarFilter({
    this.groupchatId,
    this.userIds,
    this.endDate,
    required this.startDate,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "startDate": startDate.toUtc().toIso8601String()
    };

    if (endDate != null) {
      map.addAll({"endDate": endDate!.toUtc().toIso8601String()});
    }

    if (groupchatId != null) {
      map.addAll({"groupchatId": groupchatId});
    }
    if (userIds != null) {
      map.addAll({"userIds": userIds});
    }
    return map;
  }
}
