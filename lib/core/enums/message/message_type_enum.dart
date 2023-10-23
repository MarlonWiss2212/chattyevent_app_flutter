enum MessageTypeEnum {
  defaultMessage,
  userJoined,
  userJoinedByInvitation,
  userLeft,
  userAddedBy,
  userKickedBy
}

extension MessageTypeEnumExtension on MessageTypeEnum {
  String get value {
    switch (this) {
      case MessageTypeEnum.defaultMessage:
        return 'DEFAULT';
      case MessageTypeEnum.userJoined:
        return 'USER_JOINED';
      case MessageTypeEnum.userJoinedByInvitation:
        return 'USER_JOINED_BY_INVITATION';
      case MessageTypeEnum.userLeft:
        return 'USER_LEFT';
      case MessageTypeEnum.userAddedBy:
        return 'USER_ADDED_BY';
      case MessageTypeEnum.userKickedBy:
        return 'USER_KICKED_BY';
      default:
        return 'DEFAULT';
    }
  }

  static MessageTypeEnum fromValue(String value) {
    switch (value) {
      case 'DEFAULT':
        return MessageTypeEnum.defaultMessage;
      case 'USER_JOINED':
        return MessageTypeEnum.userJoined;
      case 'USER_JOINED_BY_INVITATION':
        return MessageTypeEnum.userJoinedByInvitation;
      case 'USER_LEFT':
        return MessageTypeEnum.userLeft;
      case 'USER_ADDED_BY':
        return MessageTypeEnum.userAddedBy;
      case 'USER_KICKED_BY':
        return MessageTypeEnum.userKickedBy;
      default:
        return MessageTypeEnum.defaultMessage;
    }
  }
}
