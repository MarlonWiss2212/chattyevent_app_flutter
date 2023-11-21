class CreatePrivateEventDataDto {
  final String? groupchatTo;

  CreatePrivateEventDataDto({this.groupchatTo});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (groupchatTo != null) {
      map.addAll({"groupchatTo": groupchatTo});
    }
    return map;
  }
}
