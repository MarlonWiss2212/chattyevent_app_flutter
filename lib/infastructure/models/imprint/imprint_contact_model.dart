import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_contact_entity.dart';

class ImprintContactModel extends ImprintContactEntity {
  ImprintContactModel({
    required String phonenumber,
    required String email,
    String? websiteUrl,
  }) : super(
          phonenumber: phonenumber,
          email: email,
          websiteUrl: websiteUrl,
        );

  factory ImprintContactModel.fromJson(Map<String, dynamic> json) {
    return ImprintContactModel(
      phonenumber: json['phonenumber'],
      email: json['email'],
      websiteUrl: json['websiteUrl'],
    );
  }
}
