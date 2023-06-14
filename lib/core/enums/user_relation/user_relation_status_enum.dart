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
        return 'REQUESTTOFOLLOW';
    }
  }

  static UserRelationStatusEnum fromValue(String value) {
    switch (value) {
      case 'FOLLOWER':
        return UserRelationStatusEnum.follower;
      case 'REQUESTTOFOLLOW':
        return UserRelationStatusEnum.requesttofollow;
      default:
        return UserRelationStatusEnum.requesttofollow;
    }
  }
}
