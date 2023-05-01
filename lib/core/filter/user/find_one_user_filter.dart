class FindOneUserFilter {
  final String? id;
  final String? authId;

  FindOneUserFilter({this.id, this.authId});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (id != null) {
      map.addAll({"_id": id});
    }
    if (authId != null) {
      map.addAll({"authId": authId});
    }
    return map;
  }
}
