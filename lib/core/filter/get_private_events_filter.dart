class GetPrivateEventsFilter {
  final String? groupchatTo;
  final bool? onlyFutureEvents;
  final bool? onlyPastEvents;
  final bool? sortNewestDateFirst;

  GetPrivateEventsFilter({
    this.groupchatTo,
    this.onlyFutureEvents,
    this.onlyPastEvents,
    this.sortNewestDateFirst,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (groupchatTo != null) {
      map.addAll({"groupchatTo": groupchatTo});
    }

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
