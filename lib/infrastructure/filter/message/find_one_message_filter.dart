class FindOneMessage {
  final String id;

  FindOneMessage({
    required this.id,
  });

  Map<dynamic, dynamic> toMap() {
    return {"_id": id};
  }
}
