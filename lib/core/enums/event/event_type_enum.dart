enum EventTypeEnum {
  public,
  private,
}

extension EventTypeEnumExtension on EventTypeEnum {
  String get value {
    switch (this) {
      case EventTypeEnum.private:
        return 'PRIVATE';
      case EventTypeEnum.public:
        return 'PUBLIC';
      default:
        return 'PRIVATE';
    }
  }

  static EventTypeEnum fromValue(String value) {
    switch (value) {
      case 'PUBLIC':
        return EventTypeEnum.public;
      case 'PRIVATE':
        return EventTypeEnum.private;
      default:
        return EventTypeEnum.private;
    }
  }
}
