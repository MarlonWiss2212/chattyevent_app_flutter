class CreateGroupchatLeftUserDto {
  String userId;
  String leftGroupchatTo;

  CreateGroupchatLeftUserDto({
    required this.userId,
    required this.leftGroupchatTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'leftGroupchatTo': leftGroupchatTo,
      'userId': userId,
    };
    return variables;
  }
}
