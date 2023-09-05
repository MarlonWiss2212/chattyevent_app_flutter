enum RequestTypeEnum {
  invitation,
  joinRequest,
}

extension RequestTypeEnumExtension on RequestTypeEnum {
  String get value {
    switch (this) {
      case RequestTypeEnum.invitation:
        return 'INVITATION';
      case RequestTypeEnum.joinRequest:
        return 'JOIN_REQUEST';
      default:
        return 'INVITATION';
    }
  }

  static RequestTypeEnum fromValue(String value) {
    switch (value) {
      case 'INVITATION':
        return RequestTypeEnum.invitation;
      case 'JOIN_REQUEST':
        return RequestTypeEnum.joinRequest;
      default:
        return RequestTypeEnum.invitation;
    }
  }
}
