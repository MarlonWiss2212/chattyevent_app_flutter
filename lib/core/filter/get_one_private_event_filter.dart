class GetOnePrivateEventFilter {
  String id;

  GetOnePrivateEventFilter({required this.id});

  Map<dynamic, dynamic> toMap() {
    return {"_id": id};
  }
}
