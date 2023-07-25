import 'package:chattyevent_app_flutter/domain/entities/introduction/app_feature_introduction_entity.dart';

class AppFeatureIntroductionModel extends AppFeatureIntroductionEntity {
  AppFeatureIntroductionModel({
    required super.finishedUsersPage,
    required super.finishedPrivateEventPage,
    required super.finishedGroupchatsPage,
  });

  factory AppFeatureIntroductionModel.fromJson(Map<String, dynamic> json) {
    return AppFeatureIntroductionModel(
      finishedUsersPage: json['finishedUsersPage'],
      finishedPrivateEventPage: json['finishedPrivateEventPage'],
      finishedGroupchatsPage: json['finishedGroupchatsPage'],
    );
  }
}
