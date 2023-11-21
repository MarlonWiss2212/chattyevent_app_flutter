class FindMessagesFilter {
  final String? groupchatTo;
  final String? eventTo;
  final String? userTo;

  FindMessagesFilter({
    this.groupchatTo,
    this.eventTo,
    this.userTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (groupchatTo != null) {
      map.addAll({"groupchatTo": groupchatTo});
    }
    if (eventTo != null) {
      map.addAll({"eventTo": eventTo});
    }
    if (userTo != null) {
      map.addAll({"userTo": userTo});
    }
    return map;
  }
}
