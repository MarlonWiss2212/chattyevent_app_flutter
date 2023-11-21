class FindOneEventToFilter {
  final String eventTo;

  FindOneEventToFilter({required this.eventTo});

  Map<dynamic, dynamic> toMap() {
    return {"eventTo": eventTo};
  }
}
