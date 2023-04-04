class UpdatePrivateEventUserDto {
  String? status;
  bool? organizer;

  UpdatePrivateEventUserDto({
    this.status,
    this.organizer,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (status != null) {
      variables.addAll({"status": status});
    }
    if (organizer != null) {
      variables.addAll({"organizer": organizer});
    }

    return variables;
  }
}
