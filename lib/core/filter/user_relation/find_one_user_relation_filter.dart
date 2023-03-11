class FindOneUserRelationFilter {
  final String requesterUserId;
  final String targetUserId;

  FindOneUserRelationFilter({
    required this.targetUserId,
    required this.requesterUserId,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "requesterUserId": requesterUserId,
      "targetUserId": targetUserId
    };
    return map;
  }
}
