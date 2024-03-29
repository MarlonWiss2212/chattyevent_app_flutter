import 'package:chattyevent_app_flutter/domain/entities/geocoding/address_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/geocoding/geo_json_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_location_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/geocoding/address_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/geocoding/geo_json_model.dart';

class EventLocationModel extends EventLocationEntity {
  EventLocationModel({
    GeoJsonEntity? geoJson,
    AddressEntity? address,
  }) : super(
          address: address,
          geoJson: geoJson,
        );

  factory EventLocationModel.fromJson(Map<String, dynamic> json) {
    return EventLocationModel(
      geoJson: json["geoJson"] != null
          ? GeoJsonModel.fromJson(json["geoJson"])
          : null,
      address: json["address"] != null
          ? AddressModel.fromJson(json["address"])
          : null,
    );
  }
}
