import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_address_entity.dart';

class ImprintAddressModel extends ImprintAddressEntity {
  ImprintAddressModel({
    required String street,
    required String housenumber,
    required String country,
    required String city,
    required int zip,
  }) : super(
          street: street,
          city: city,
          housenumber: housenumber,
          country: country,
          zip: zip,
        );

  factory ImprintAddressModel.fromJson(Map<String, dynamic> json) {
    return ImprintAddressModel(
      street: json['street'],
      housenumber: json['housenumber'],
      country: json['country'],
      zip: json['zip'],
      city: json['city'],
    );
  }
}
