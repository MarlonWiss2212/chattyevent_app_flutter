import 'package:chattyevent_app_flutter/domain/entities/geocoding/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    super.city,
    super.country,
    super.housenumber,
    super.street,
    super.zip,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json["city"],
      country: json["country"],
      housenumber: json["housenumber"],
      street: json["street"],
      zip: json["zip"],
    );
  }
}
