enum UserRelationStatusEnum {
  follower,
  requesttofollow,
}

extension UserRelationStatusEnumExtension on UserRelationStatusEnum {
  String get value {
    switch (this) {
      case UserRelationStatusEnum.follower:
        return 'FOLLOWER';
      case UserRelationStatusEnum.requesttofollow:
        return 'REQUESTTOFOLLOW';
      default:
        throw Exception('Invalid value');
    }
  }

  static UserRelationStatusEnum fromValue(String value) {
    switch (value) {
      case 'FOLLOWER':
        return UserRelationStatusEnum.follower;
      case 'REQUESTTOFOLLOW':
        return UserRelationStatusEnum.requesttofollow;
      default:
        throw Exception('Invalid value');
    }
  }
}
