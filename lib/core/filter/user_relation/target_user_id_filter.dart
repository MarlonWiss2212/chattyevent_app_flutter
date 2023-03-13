class TargetUserIdFilter {
  final String targetUserId;

  TargetUserIdFilter({
    required this.targetUserId,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "targetUserId": targetUserId,
    };
    return map;
  }
}
