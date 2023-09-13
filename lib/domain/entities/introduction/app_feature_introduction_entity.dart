class AppFeatureIntroductionEntity {
  final bool finishedUsersPage;
  final bool finishedPrivateEventPage;
  final bool finishedGroupchatsPage;
  final bool finishedMessagesPage;

  AppFeatureIntroductionEntity({
    required this.finishedUsersPage,
    required this.finishedPrivateEventPage,
    required this.finishedGroupchatsPage,
    required this.finishedMessagesPage,
  });

  AppFeatureIntroductionEntity copyWith({
    bool? finishedUsersPage,
    bool? finishedPrivateEventPage,
    bool? finishedGroupchatsPage,
    bool? finishedMessagesPage,
  }) {
    return AppFeatureIntroductionEntity(
      finishedUsersPage: finishedUsersPage ?? this.finishedUsersPage,
      finishedMessagesPage: finishedMessagesPage ?? this.finishedMessagesPage,
      finishedPrivateEventPage:
          finishedPrivateEventPage ?? this.finishedPrivateEventPage,
      finishedGroupchatsPage:
          finishedGroupchatsPage ?? this.finishedGroupchatsPage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'finishedUsersPage': finishedUsersPage,
      'finishedPrivateEventPage': finishedPrivateEventPage,
      'finishedGroupchatsPage': finishedGroupchatsPage,
      'finishedMessagesPage': finishedMessagesPage,
    };
  }
}
