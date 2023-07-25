class AppFeatureIntroductionEntity {
  final bool finishedUsersPage;
  final bool finishedPrivateEventPage;
  final bool finishedGroupchatsPage;

  AppFeatureIntroductionEntity({
    required this.finishedUsersPage,
    required this.finishedPrivateEventPage,
    required this.finishedGroupchatsPage,
  });

  AppFeatureIntroductionEntity copyWith({
    bool? finishedUsersPage,
    bool? finishedPrivateEventPage,
    bool? finishedGroupchatsPage,
  }) {
    return AppFeatureIntroductionEntity(
      finishedUsersPage: finishedUsersPage ?? this.finishedUsersPage,
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
    };
  }
}
