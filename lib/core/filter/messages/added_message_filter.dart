class AddedMessageFilter {
  final String groupchatTo;
  final bool? returnMyAddedMessageToo;

  AddedMessageFilter({
    required this.groupchatTo,
    this.returnMyAddedMessageToo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"groupchatTo": groupchatTo};

    if (returnMyAddedMessageToo != null) {
      map.addAll({"returnMyAddedMessageToo": returnMyAddedMessageToo});
    }
    return map;
  }
}
