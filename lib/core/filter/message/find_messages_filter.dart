class FindMessagesFilter {
  final String? groupchatTo;
  final String? privateEventTo;
  final String? userTo;

  FindMessagesFilter({
    this.groupchatTo,
    this.privateEventTo,
    this.userTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (groupchatTo != null) {
      map.addAll({"groupchatTo": groupchatTo});
    }
    if (privateEventTo != null) {
      map.addAll({"privateEventTo": privateEventTo});
    }
    if (userTo != null) {
      map.addAll({"userTo": userTo});
    }
    return map;
  }
}
