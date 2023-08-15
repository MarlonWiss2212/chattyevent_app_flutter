enum EventUserStatusEnum {
  accepted,
  rejected,
  unknown,
}

extension PrivateEventUserStatusEnumExtension on EventUserStatusEnum {
  String get value {
    switch (this) {
      case EventUserStatusEnum.accepted:
        return 'ACCEPTED';
      case EventUserStatusEnum.rejected:
        return 'REJECTED';
      case EventUserStatusEnum.unknown:
        return 'UNKNOWN';
      default:
        return 'UNKNOWN';
    }
  }

  static EventUserStatusEnum fromValue(String value) {
    switch (value) {
      case 'ACCEPTED':
        return EventUserStatusEnum.accepted;
      case 'REJECTED':
        return EventUserStatusEnum.rejected;
      case 'UNKNOWN':
        return EventUserStatusEnum.unknown;
      default:
        return EventUserStatusEnum.unknown;
    }
  }
}
