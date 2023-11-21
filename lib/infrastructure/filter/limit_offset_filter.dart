class LimitOffsetFilter {
  int limit;
  int offset;

  LimitOffsetFilter({required this.limit, required this.offset});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"limit": limit, "offset": offset};
    return map;
  }
}
