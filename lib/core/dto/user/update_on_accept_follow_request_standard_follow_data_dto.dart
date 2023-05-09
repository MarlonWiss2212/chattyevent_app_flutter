class UpdateOnAcceptFollowRequestStandardFollowDataDto {
  final String? standardFollowedToPrivateEventPermission;
  final String? standardFollowedToGroupchatPermission;

  UpdateOnAcceptFollowRequestStandardFollowDataDto({
    this.standardFollowedToGroupchatPermission,
    this.standardFollowedToPrivateEventPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (standardFollowedToGroupchatPermission != null) {
      variables.addAll({
        "standardFollowedToGroupchatPermission":
            standardFollowedToGroupchatPermission
      });
    }
    if (standardFollowedToPrivateEventPermission != null) {
      variables.addAll({
        "standardFollowedToPrivateEventPermission":
            standardFollowedToPrivateEventPermission
      });
    }
    return variables;
  }
}
