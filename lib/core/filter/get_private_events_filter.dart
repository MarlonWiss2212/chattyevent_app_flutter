class GetPrivateEventsFilter {
  String groupchatTo;
  bool? onlyFutureEvents;
  bool? onlyPastEvents;
  bool? sortNewestDateFirst;
  GetPrivateEventsFilter({
    required this.groupchatTo,
    this.onlyFutureEvents,
    this.onlyPastEvents,
    this.sortNewestDateFirst,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"groupchatTo": groupchatTo};

    if (onlyFutureEvents != null) {
      map.addAll({"onlyFutureEvents": onlyFutureEvents});
    }
    if (onlyPastEvents != null) {
      map.addAll({"onlyPastEvents": onlyPastEvents});
    }
    if (sortNewestDateFirst != null) {
      map.addAll({"sortNewestDateFirst": sortNewestDateFirst});
    }

    return map;
  }
}
