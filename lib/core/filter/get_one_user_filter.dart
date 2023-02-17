class GetOneUserFilter {
  String? id;
  String? email;

  GetOneUserFilter({this.id, this.email});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (id != null) {
      map.addAll({"_id": id});
    }
    if (email != null) {
      map.addAll({"email": email});
    }
    return map;
  }
}
