class AddedGroupchatMessageFilter {
  final String groupchatTo;
  final bool? returnMyAddedMessageToo;

  AddedGroupchatMessageFilter({
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
