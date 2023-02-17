class LimitFilter {
  int? limit;
  int? offset;

  LimitFilter({this.limit, this.offset});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (limit != null) {
      map.addAll({"limit": limit});
    }
    if (offset != null) {
      map.addAll({"offset": offset});
    }
    return map;
  }
}
