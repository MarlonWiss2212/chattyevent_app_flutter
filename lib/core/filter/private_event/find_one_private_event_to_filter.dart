class FindOnePrivateEventToFilter {
  final String privateEventTo;

  FindOnePrivateEventToFilter({required this.privateEventTo});

  Map<dynamic, dynamic> toMap() {
    return {"privateEventTo": privateEventTo};
  }
}
