class GetOneGroupchatFilter {
  String id;

  GetOneGroupchatFilter({required this.id});

  Map<dynamic, dynamic> toMap() {
    return {"_id": id};
  }
}
