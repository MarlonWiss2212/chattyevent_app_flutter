import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_contact_entity.dart';

class ImprintContactModel extends ImprintContactEntity {
  ImprintContactModel({
    required String phoneNumber,
    required String email,
    String? websiteUrl,
  }) : super(
          phoneNumber: phoneNumber,
          email: email,
          websiteUrl: websiteUrl,
        );

  factory ImprintContactModel.fromJson(Map<String, dynamic> json) {
    return ImprintContactModel(
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      websiteUrl: json['websiteUrl'],
    );
  }
}
