import 'package:chattyevent_app_flutter/domain/entities/introduction/app_feature_introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/app_permission_introduction_entity.dart';

class IntroductionEntity {
  final AppFeatureIntroductionEntity appFeatureIntroduction;
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

  Map<String, dynamic> toJson() {
    return {
      'appFeatureIntroduction': appFeatureIntroduction.toJson(),
      'appPermissionIntroduction': appPermissionIntroduction.toJson(),
    };
  }
}
