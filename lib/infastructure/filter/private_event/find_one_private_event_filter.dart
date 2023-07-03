class FindOnePrivateEventFilter {
  final String privateEventId;

  FindOnePrivateEventFilter({required this.privateEventId});

  Map<dynamic, dynamic> toMap() {
    return {"privateEventId": privateEventId};
  }
}
