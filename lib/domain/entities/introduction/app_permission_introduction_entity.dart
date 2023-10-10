import 'package:hive/hive.dart';

part 'app_permission_introduction_entity.g.dart';

@HiveType(typeId: 1)
class AppPermissionIntroductionEntity {
  @HiveField(0)
  final bool finishedNotificationPage;

  @HiveField(1)
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
}
