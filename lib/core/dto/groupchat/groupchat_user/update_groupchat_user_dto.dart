class UpdateGroupchatUserDto {
  final bool? admin;
  final String? usernameForChat;

  UpdateGroupchatUserDto({
    this.admin,
    this.usernameForChat,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (admin != null) {
      map.addAll({'admin': admin});
    }
    if (usernameForChat != null) {
      map.addAll({'usernameForChat': usernameForChat});
    }

    return map;
  }
}
