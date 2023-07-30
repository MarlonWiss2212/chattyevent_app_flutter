enum EventStatusEnum {
  takesplace,
  undecided,
  cancelled,
}

extension PrivateEventStatusEnumExtension on EventStatusEnum {
  String get value {
    switch (this) {
      case EventStatusEnum.takesplace:
        return 'TAKES_PLACE';
      case EventStatusEnum.undecided:
        return 'UNDECIDED';
      case EventStatusEnum.cancelled:
        return 'CANCELLED';
      default:
        return 'UNDECIDED';
    }
  }

  static EventStatusEnum fromValue(String value) {
    switch (value) {
      case 'TAKES_PLACE':
        return EventStatusEnum.takesplace;
      case 'UNDECIDED':
        return EventStatusEnum.undecided;
      case 'CANCELLED':
        return EventStatusEnum.cancelled;
      default:
        return EventStatusEnum.undecided;
    }
  }
}
