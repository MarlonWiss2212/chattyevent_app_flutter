class FindOneRequestFilter {
  final String id;

  FindOneRequestFilter({required this.id});

  Map<dynamic, dynamic> toMap() {
    return {"_id": id};
  }
}
