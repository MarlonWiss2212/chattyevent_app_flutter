import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_address_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_contact_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_disclaimer_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/imprint/imprint_disclaimer_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/imprint/imprint_contact_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/imprint/imprint_address_model.dart';

class ImprintModel extends ImprintEntity {
  ImprintModel({
    required String imprintDescription,
    required String name,
    required ImprintAddressEntity address,
    required ImprintContactEntity contact,
    required ImprintDisclaimerEntity disclaimer,
  }) : super(
          imprintDescription: imprintDescription,
          name: name,
          address: address,
          contact: contact,
          disclaimer: disclaimer,
        );

  factory ImprintModel.fromJson(Map<String, dynamic> json) {
    return ImprintModel(
      imprintDescription: json['imprintDescription'],
      name: json['name'],
      address: ImprintAddressModel.fromJson(json['address']),
      contact: ImprintContactModel.fromJson(json['contact']),
      disclaimer: ImprintDisclaimerModel.fromJson(json['disclaimer']),
    );
  }
}
