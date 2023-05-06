import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_disclaimer_entity.dart';

class ImprintDisclaimerModel extends ImprintDisclaimerEntity {
  ImprintDisclaimerModel({
    required String title,
    required String content,
  }) : super(
          title: title,
          content: content,
        );

  factory ImprintDisclaimerModel.fromJson(Map<String, dynamic> json) {
    return ImprintDisclaimerModel(
      title: json['title'],
      content: json['content'],
    );
  }
}
