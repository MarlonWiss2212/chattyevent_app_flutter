enum UserRelationStatusEnum {
  follower,
  blocked,
  requesttofollow,
}

extension UserRelationStatusEnumExtension on UserRelationStatusEnum {
  String get value {
    switch (this) {
      case UserRelationStatusEnum.follower:
        return 'FOLLOWER';
      case UserRelationStatusEnum.requesttofollow:
        return 'REQUESTTOFOLLOW';
      case UserRelationStatusEnum.blocked:
        return 'BLOCKED';
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
      case 'BLOCKED':
        return UserRelationStatusEnum.blocked;
      default:
        return UserRelationStatusEnum.requesttofollow;
    }
  }
}
