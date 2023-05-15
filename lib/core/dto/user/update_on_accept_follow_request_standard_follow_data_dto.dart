class UpdateOnAcceptFollowRequestStandardFollowDataDto {
  final String? standardRequesterPrivateEventAddPermission;
  final String? standardRequesterGroupchatAddPermission;

  UpdateOnAcceptFollowRequestStandardFollowDataDto({
    this.standardRequesterGroupchatAddPermission,
    this.standardRequesterPrivateEventAddPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (standardRequesterGroupchatAddPermission != null) {
      variables.addAll({
        "standardRequesterGroupchatAddPermission":
            standardRequesterGroupchatAddPermission
      });
    }
    if (standardRequesterPrivateEventAddPermission != null) {
      variables.addAll({
        "standardRequesterPrivateEventAddPermission":
            standardRequesterPrivateEventAddPermission
      });
    }
    return variables;
  }
}
