class CreateUserGroupchatDto {
  String userId;
  bool? admin;

  CreateUserGroupchatDto({required this.userId, this.admin});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {'userId': userId};

    if (admin != null) {
      variables.addAll({'admin': admin});
    }

    return variables;
  }
}
