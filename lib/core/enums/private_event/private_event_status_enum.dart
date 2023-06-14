enum PrivateEventStatusEnum {
  takesplace,
  undecided,
  cancelled,
}

extension PrivateEventStatusEnumExtension on PrivateEventStatusEnum {
  String get value {
    switch (this) {
      case PrivateEventStatusEnum.takesplace:
        return 'TAKES_PLACE';
      case PrivateEventStatusEnum.undecided:
        return 'UNDECIDED';
      case PrivateEventStatusEnum.cancelled:
        return 'CANCELLED';
      default:
        return 'UNDECIDED';
    }
  }

  static PrivateEventStatusEnum fromValue(String value) {
    switch (value) {
      case 'TAKES_PLACE':
        return PrivateEventStatusEnum.takesplace;
      case 'UNDECIDED':
        return PrivateEventStatusEnum.undecided;
      case 'CANCELLED':
        return PrivateEventStatusEnum.cancelled;
      default:
        return PrivateEventStatusEnum.undecided;
    }
  }
}
