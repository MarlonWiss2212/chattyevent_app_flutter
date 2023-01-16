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
class CreateUserGroupchatWithUsernameAndImageLink
    extends CreateUserGroupchatDto {
  String username;
  String? imageLink;

  CreateUserGroupchatWithUsernameAndImageLink({
    required String userId,
    required this.username,
    this.imageLink,
    bool? admin,
  }) : super(userId: userId, admin: admin);
}
