import 'package:chattyevent_app_flutter/domain/entities/introduction/app_feature_introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/app_permission_introduction_entity.dart';
import 'package:hive/hive.dart';

part 'introduction_entity.g.dart';

@HiveType(typeId: 0)
class IntroductionEntity {
  @HiveField(0)
  final AppFeatureIntroductionEntity appFeatureIntroduction;

  @HiveField(1)
  final AppPermissionIntroductionEntity appPermissionIntroduction;

  IntroductionEntity({
    required this.appFeatureIntroduction,
    required this.appPermissionIntroduction,
  });

  IntroductionEntity copyWith({
    AppFeatureIntroductionEntity? appFeatureIntroduction,
    AppPermissionIntroductionEntity? appPermissionIntroduction,
  }) {
    return IntroductionEntity(
      appFeatureIntroduction:
          appFeatureIntroduction ?? this.appFeatureIntroduction,
      appPermissionIntroduction:
          appPermissionIntroduction ?? this.appPermissionIntroduction,
    );
  }
}
