class GetPrivateEventsFilter {
  String groupchatTo;

  GetPrivateEventsFilter({required this.groupchatTo});

  Map<dynamic, dynamic> toMap() {
    return {"groupchatTo": groupchatTo};
  }
}
