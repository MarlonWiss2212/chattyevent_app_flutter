class CreatePrivateEventUserDto {
  String userId;
  String privateEventTo;
  bool? organizer;

  CreatePrivateEventUserDto({
    required this.userId,
    required this.privateEventTo,
    this.organizer,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      "userId": userId,
      "privateEventTo": privateEventTo,
    };

    if (organizer != null) {
      variables.addAll({"organizer": organizer});
    }

    return variables;
  }
}
