import 'package:hive/hive.dart';

part 'app_feature_introduction_entity.g.dart';

@HiveType(typeId: 2)
class AppFeatureIntroductionEntity {
  @HiveField(0)
  final bool finishedUsersPage;

  @HiveField(1)
  final bool finishedPrivateEventPage;

  @HiveField(2)
  final bool finishedGroupchatsPage;

  @HiveField(3)
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
}
