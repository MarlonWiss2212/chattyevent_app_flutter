import 'package:chattyevent_app_flutter/domain/entities/introduction/app_feature_introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/app_permission_introduction_entity.dart';

class IntroductionEntity {
  final AppFeatureIntroductionEntity appFeatureIntroduction;
  final bool finishedAppFeatureIntroductionPage;
  final AppPermissionIntroductionEntity appPermissionIntroductionEntity;
  final bool finishedAppPermissionIntroductionPage;

  IntroductionEntity({
    required this.appFeatureIntroduction,
    required this.finishedAppFeatureIntroductionPage,
    required this.appPermissionIntroductionEntity,
    required this.finishedAppPermissionIntroductionPage,
  });

  IntroductionEntity copyWith({
    AppFeatureIntroductionEntity? appFeatureIntroduction,
    bool? finishedAppFeatureIntroductionPage,
    AppPermissionIntroductionEntity? appPermissionIntroductionEntity,
    bool? finishedAppPermissionIntroductionPage,
  }) {
    return IntroductionEntity(
      appFeatureIntroduction:
          appFeatureIntroduction ?? this.appFeatureIntroduction,
      finishedAppFeatureIntroductionPage: finishedAppFeatureIntroductionPage ??
          this.finishedAppFeatureIntroductionPage,
      appPermissionIntroductionEntity: appPermissionIntroductionEntity ??
          this.appPermissionIntroductionEntity,
      finishedAppPermissionIntroductionPage:
          finishedAppPermissionIntroductionPage ??
              this.finishedAppPermissionIntroductionPage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appFeatureIntroduction': appFeatureIntroduction.toJson(),
      'finishedAppFeatureIntroductionPage': finishedAppFeatureIntroductionPage,
      'appPermissionIntroductionEntity':
          appPermissionIntroductionEntity.toJson(),
      'finishedAppPermissionIntroductionPage':
          finishedAppPermissionIntroductionPage,
    };
  }
}
