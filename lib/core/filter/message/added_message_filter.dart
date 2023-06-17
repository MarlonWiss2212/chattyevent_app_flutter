class AddedMessageFilter {
  final bool? returnMyAddedMessageToo;
  final String? groupchatTo;
  final String? privateEventTo;
  final String? userTo;

  AddedMessageFilter({
    this.groupchatTo,
    this.privateEventTo,
    this.userTo,
    this.returnMyAddedMessageToo,
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
    if (returnMyAddedMessageToo != null) {
      map.addAll({"returnMyAddedMessageToo": returnMyAddedMessageToo});
    }
    return map;
  }
}
