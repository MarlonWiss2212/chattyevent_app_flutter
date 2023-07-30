class AddedMessageFilter {
  final bool? returnMyAddedMessageToo;
  final String? groupchatTo;
  final String? eventTo;
  final String? userTo;

  AddedMessageFilter({
    this.groupchatTo,
    this.eventTo,
    this.userTo,
    this.returnMyAddedMessageToo,
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
    if (returnMyAddedMessageToo != null) {
      map.addAll({"returnMyAddedMessageToo": returnMyAddedMessageToo});
    }
    return map;
  }
}
