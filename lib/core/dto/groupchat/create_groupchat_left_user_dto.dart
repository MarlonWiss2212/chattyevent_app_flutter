class CreateGroupchatLeftUserDto {
  String userId;
  String groupchatTo;

  CreateGroupchatLeftUserDto({
    required this.userId,
    required this.groupchatTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'groupchatTo': groupchatTo,
      'userId': userId,
    };
    return variables;
  }
}
