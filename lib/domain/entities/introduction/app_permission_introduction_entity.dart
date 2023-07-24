class AppPermissionIntroductionEntity {
  final bool finishedNotificationPage;
  final bool finishedMicrophonePage;

  AppPermissionIntroductionEntity({
    required this.finishedMicrophonePage,
    required this.finishedNotificationPage,
  });

  AppPermissionIntroductionEntity copyWith({
    bool? finishedNotificationPage,
    bool? finishedMicrophonePage,
  }) {
    return AppPermissionIntroductionEntity(
      finishedNotificationPage:
          finishedNotificationPage ?? this.finishedNotificationPage,
      finishedMicrophonePage:
          finishedMicrophonePage ?? this.finishedMicrophonePage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'finishedMicrophonePage': finishedMicrophonePage,
      'finishedNotificationPage': finishedNotificationPage,
    };
  }
}
