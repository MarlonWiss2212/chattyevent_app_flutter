enum GroupchatUserRoleEnum {
  admin,
  member,
}

extension GroupchatUserRoleEnumExtension on GroupchatUserRoleEnum {
  String get value {
    switch (this) {
      case GroupchatUserRoleEnum.admin:
        return 'ADMIN';
      case GroupchatUserRoleEnum.member:
        return 'MEMBER';
      default:
        throw Exception('Invalid value');
    }
  }

  static GroupchatUserRoleEnum fromValue(String value) {
    switch (value) {
      case 'ADMIN':
        return GroupchatUserRoleEnum.admin;
      case 'MEMBER':
        return GroupchatUserRoleEnum.member;
      default:
        throw Exception('Invalid value');
    }
  }
}
