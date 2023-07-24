class AppFeatureIntroductionEntity {
  final bool finishedUsersPage;
  final bool finishedPrivateEventPage;
  final bool finishedShoppingListPage;
  final bool finishedGroupchatsPage;

  AppFeatureIntroductionEntity({
    required this.finishedUsersPage,
    required this.finishedPrivateEventPage,
    required this.finishedShoppingListPage,
    required this.finishedGroupchatsPage,
  });

  AppFeatureIntroductionEntity copyWith({
    bool? finishedUsersPage,
    bool? finishedPrivateEventPage,
    bool? finishedShoppingListPage,
    bool? finishedGroupchatsPage,
  }) {
    return AppFeatureIntroductionEntity(
      finishedUsersPage: finishedUsersPage ?? this.finishedUsersPage,
      finishedPrivateEventPage:
          finishedPrivateEventPage ?? this.finishedPrivateEventPage,
      finishedShoppingListPage:
          finishedShoppingListPage ?? this.finishedShoppingListPage,
      finishedGroupchatsPage:
          finishedGroupchatsPage ?? this.finishedGroupchatsPage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'finishedUsersPage': finishedUsersPage,
      'finishedPrivateEventPage': finishedPrivateEventPage,
      'finishedShoppingListPage': finishedShoppingListPage,
      'finishedGroupchatsPage': finishedGroupchatsPage,
    };
  }
}
