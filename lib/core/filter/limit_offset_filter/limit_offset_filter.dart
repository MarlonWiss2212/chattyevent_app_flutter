class LimitOffsetFilter {
  int limit;
  int offset;

  LimitOffsetFilter({required this.limit, required this.offset});

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

class LimitOffsetFilterOptional {
  int? limit;
  int? offset;

  LimitOffsetFilterOptional({this.limit, this.offset});

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
