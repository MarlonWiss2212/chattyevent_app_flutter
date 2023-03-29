class GetOneGroupchatUserFilter {
  final String userId;
  final String groupchatTo;

  GetOneGroupchatUserFilter({
    required this.userId,
    required this.groupchatTo,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      "userId": userId,
      "groupchatTo": groupchatTo,
    };
  }
}
