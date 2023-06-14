enum CalendarStatusEnum {
  hastime,
  doesnothavetime,
  unknown,
}

extension CalendarStatusEnumExtension on CalendarStatusEnum {
  String get value {
    switch (this) {
      case CalendarStatusEnum.hastime:
        return 'HAS_TIME';
      case CalendarStatusEnum.doesnothavetime:
        return 'DOES_NOT_HAVE_TIME';
      case CalendarStatusEnum.unknown:
        return 'UNKNOWN';
      default:
        return 'UNKNOWN';
    }
  }

  static CalendarStatusEnum fromValue(String value) {
    switch (value) {
      case 'HAS_TIME':
        return CalendarStatusEnum.hastime;
      case 'DOES_NOT_HAVE_TIME':
        return CalendarStatusEnum.doesnothavetime;
      case 'UNKNOWN':
        return CalendarStatusEnum.unknown;
      default:
        return CalendarStatusEnum.unknown;
    }
  }
}
