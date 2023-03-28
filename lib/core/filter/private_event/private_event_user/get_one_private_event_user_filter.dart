class GetOnePrivateEventUserFilter {
  final String userId;
  final String privateEventTo;

  GetOnePrivateEventUserFilter({
    required this.userId,
    required this.privateEventTo,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      "privateEventTo": privateEventTo,
      "userId": userId,
    };
  }
}
