class CreateGroupchatLeftUserDto {
  String authId;
  String leftGroupchatTo;

  CreateGroupchatLeftUserDto({
    required this.authId,
    required this.leftGroupchatTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'leftGroupchatTo': leftGroupchatTo,
      'authId': authId,
    };
    return variables;
  }
}
