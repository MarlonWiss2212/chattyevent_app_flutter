class UpdatePrivateEventUserDto {
  bool? isInvitedIndependetFromGroupchat;
  String? status;

  UpdatePrivateEventUserDto({
    this.status,
    this.isInvitedIndependetFromGroupchat,
  });

  Map<dynamic, dynamic> toMap() {
    final variables = {};

    if (isInvitedIndependetFromGroupchat != null) {
      variables.addAll({
        "isInvitedIndependetFromGroupchat": isInvitedIndependetFromGroupchat,
      });
    }
    if (status != null) {
      variables.addAll({"status": status});
    }

    return variables;
  }
}
