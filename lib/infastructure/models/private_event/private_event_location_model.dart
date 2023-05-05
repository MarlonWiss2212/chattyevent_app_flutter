import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_location_entity.dart';

class PrivateEventLocationModel extends PrivateEventLocationEntity {
  PrivateEventLocationModel({
    required double latitude,
    required double longitude,
    String? city,
    String? country,
    String? zip,
    String? street,
    String? housenumber,
  }) : super(
          city: city,
          country: country,
          zip: zip,
          street: street,
          housenumber: housenumber,
          latitude: latitude,
          longitude: longitude,
        );

  factory PrivateEventLocationModel.fromJson(Map<String, dynamic> json) {
    return PrivateEventLocationModel(
      latitude: json["latitude"] is double
          ? json["latitude"]
          : double.tryParse(json["latitude"].toString()),
      longitude: json["longitude"] is double
          ? json["longitude"]
          : double.tryParse(json["longitude"].toString()),
      city: json['city'],
      country: json['country'],
      zip: json['zip'],
      street: json['street'],
      housenumber: json['housenumber'],
    );
  }
}
