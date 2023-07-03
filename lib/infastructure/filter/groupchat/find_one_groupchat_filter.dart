class FindOneGroupchatFilter {
  final String groupchatId;

  FindOneGroupchatFilter({required this.groupchatId});

  Map<dynamic, dynamic> toMap() {
    return {"groupchatId": groupchatId};
  }
}
