import 'package:chattyevent_app_flutter/domain/entities/introduction/app_permission_introduction_entity.dart';

class AppPermissionIntroductionModel extends AppPermissionIntroductionEntity {
  AppPermissionIntroductionModel({
    required super.finishedMicrophonePage,
    required super.finishedNotificationPage,
  });

  factory AppPermissionIntroductionModel.fromJson(Map<String, dynamic> json) {
    return AppPermissionIntroductionModel(
      finishedMicrophonePage: json['finishedMicrophonePage'],
      finishedNotificationPage: json['finishedNotificationPage'],
    );
  }
}
