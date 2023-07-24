import 'package:chattyevent_app_flutter/domain/entities/introduction/introduction_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/introduction/app_feature_introduction_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/introduction/app_permission_introduction_model.dart';

class IntroductionModel extends IntroductionEntity {
  IntroductionModel({
    required super.finishedAppFeatureIntroductionPage,
    required super.finishedAppPermissionIntroductionPage,
    required super.appPermissionIntroductionEntity,
    required super.appFeatureIntroduction,
  });

  factory IntroductionModel.fromJson(Map<String, dynamic> json) {
    return IntroductionModel(
      appFeatureIntroduction: AppFeatureIntroductionModel.fromJson(
        json['appFeatureIntroduction'],
      ),
      finishedAppFeatureIntroductionPage:
          json['finishedAppFeatureIntroductionPage'],
      appPermissionIntroductionEntity: AppPermissionIntroductionModel.fromJson(
        json['appFeatureIntroduction'],
      ),
      finishedAppPermissionIntroductionPage:
          json['finishedAppPermissionIntroductionPage'],
    );
  }
}
