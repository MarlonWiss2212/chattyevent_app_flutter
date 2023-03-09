class UpdatePrivateEventUserDto {
  String? status;

  UpdatePrivateEventUserDto({
    this.status,
  });

  Map<dynamic, dynamic> toMap() {
    final variables = {};

    if (status != null) {
      variables.addAll({"status": status});
    }

    return variables;
  }
}
