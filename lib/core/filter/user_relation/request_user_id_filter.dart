class RequestUserIdFilter {
  final String requesterUserId;

  RequestUserIdFilter({
    required this.requesterUserId,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "requesterUserId": requesterUserId,
    };
    return map;
  }
}
