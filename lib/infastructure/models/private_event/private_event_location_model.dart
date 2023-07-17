import 'package:chattyevent_app_flutter/domain/entities/geocoding/address_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/geocoding/geo_json_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_location_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/geocoding/address_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/geocoding/geo_json_model.dart';

class PrivateEventLocationModel extends PrivateEventLocationEntity {
  PrivateEventLocationModel({
    GeoJsonEntity? geoJson,
    AddressEntity? address,
  }) : super(
          address: address,
          geoJson: geoJson,
        );

  factory PrivateEventLocationModel.fromJson(Map<String, dynamic> json) {
    return PrivateEventLocationModel(
      geoJson: json["geoJson"] != null
          ? GeoJsonModel.fromJson(json["geoJson"])
          : null,
      address: json["address"] != null
          ? AddressModel.fromJson(json["address"])
          : null,
    );
  }
}
