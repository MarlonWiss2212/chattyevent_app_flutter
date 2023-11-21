class FindOneEventFilter {
  final String eventId;

  FindOneEventFilter({required this.eventId});

  Map<dynamic, dynamic> toMap() {
    return {"eventId": eventId};
  }
}
