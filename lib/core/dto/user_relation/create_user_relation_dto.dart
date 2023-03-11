class CreateUserRelationDto {
  String targetUserId;

  CreateUserRelationDto({
    required this.targetUserId,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      'targetUserId': targetUserId,
    };
    return map;
  }
}
