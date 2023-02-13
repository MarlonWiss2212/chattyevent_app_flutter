class CreateGroupchatUserFromCreateGroupchatDto {
  String userId;
  bool? admin;
  String? usernameForChat;

  CreateGroupchatUserFromCreateGroupchatDto({
    required this.userId,
    this.usernameForChat,
    this.admin,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'userId': userId,
    };

    if (admin != null) {
      variables.addAll({'admin': admin});
    }
    if (usernameForChat != null) {
      variables.addAll({'usernameForChat': usernameForChat});
    }

    return variables;
  }
}

/// use this for lists to get the username
class CreateGroupchatUserFromCreateGroupchatDtoWithUsernameAndLink
    extends CreateGroupchatUserFromCreateGroupchatDto {
  String username;
  String? imageLink;

  CreateGroupchatUserFromCreateGroupchatDtoWithUsernameAndLink({
    required this.username,
    this.imageLink,
    super.admin,
    required super.userId,
    super.usernameForChat,
  });
}
