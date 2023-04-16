class GetMessagesFilter {
  final String? groupchatTo;

  GetMessagesFilter({this.groupchatTo});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (groupchatTo != null) {
      map.addAll({"groupchatTo": groupchatTo});
    }

    return map;
  }
}
