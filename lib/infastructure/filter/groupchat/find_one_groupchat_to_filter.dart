class FindOneGroupchatToFilter {
  final String groupchatTo;

  FindOneGroupchatToFilter({required this.groupchatTo});

  Map<dynamic, dynamic> toMap() {
    return {"groupchatTo": groupchatTo};
  }
}
