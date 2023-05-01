class UpdateGroupchatUserDto {
  final bool? admin;
  final String? usernameForChat;

  UpdateGroupchatUserDto({
    this.admin,
    this.usernameForChat,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (admin != null) {
      variables.addAll({'admin': admin});
    }
    if (usernameForChat != null) {
      variables.addAll({'usernameForChat': usernameForChat});
    }

    return variables;
  }
}
