class CreateUserGroupchatDto {
  String userId;
  bool? admin;

  CreateUserGroupchatDto({
    required this.userId,
    this.admin,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {'userId': userId};

    if (admin != null) {
      variables.addAll({'admin': admin});
    }

    return variables;
  }
}

/// use this for lists to get the username
class CreateUserGroupchatWithUsername extends CreateUserGroupchatDto {
  String username;

  CreateUserGroupchatWithUsername({
    required String userId,
    required this.username,
    bool? admin,
  }) : super(userId: userId, admin: admin);
}
