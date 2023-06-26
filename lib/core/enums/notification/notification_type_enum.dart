enum NotificationTypeEnum {
  messageadded,
}

extension NotificationTypeEnumExtension on NotificationTypeEnum {
  String get value {
    switch (this) {
      case NotificationTypeEnum.messageadded:
        return 'MESSAGE_ADDED';
      default:
        return 'MESSAGE_ADDED';
    }
  }

  static NotificationTypeEnum fromValue(String value) {
    switch (value) {
      case 'MESSAGE_ADDED':
        return NotificationTypeEnum.messageadded;
      default:
        return NotificationTypeEnum.messageadded;
    }
  }
}
