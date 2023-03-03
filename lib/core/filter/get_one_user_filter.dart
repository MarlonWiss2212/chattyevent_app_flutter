class GetOneUserFilter {
  String? id;
  String? authId;

  GetOneUserFilter({this.id, this.authId});

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
