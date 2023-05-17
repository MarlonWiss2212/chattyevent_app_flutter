import 'package:chattyevent_app_flutter/domain/entities/geo_json/geo_json_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_location_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/geo_json/geo_json_model.dart';

class PrivateEventLocationModel extends PrivateEventLocationEntity {
  PrivateEventLocationModel({
    GeoJsonEntity? geoJsonLocation,
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
          geoJsonLocation: geoJsonLocation,
        );

  factory PrivateEventLocationModel.fromJson(Map<String, dynamic> json) {
    return PrivateEventLocationModel(
      geoJsonLocation: json["geoJsonLocation"] != null
          ? GeoJsonModel.fromJson(
              json["geoJsonLocation"],
            )
          : null,
      city: json['city'],
      country: json['country'],
      zip: json['zip'],
      street: json['street'],
      housenumber: json['housenumber'],
    );
  }
}
