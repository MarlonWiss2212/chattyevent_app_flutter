class UpdatePrivateEventUserDto {
  String userId;
  String privateEventTo;
  String? status;
  bool? organizer;

  UpdatePrivateEventUserDto({
    required this.userId,
    required this.privateEventTo,
    this.status,
    this.organizer,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      "userId": userId,
      "privateEventTo": privateEventTo
    };

    if (status != null) {
      variables.addAll({"status": status});
    }
    if (organizer != null) {
      variables.addAll({"organizer": organizer});
    }

    return variables;
  }
}
