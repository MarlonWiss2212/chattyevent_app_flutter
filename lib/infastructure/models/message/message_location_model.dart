import 'package:chattyevent_app_flutter/domain/entities/geocoding/address_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/geocoding/geo_json_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_location_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/geocoding/address_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/geocoding/geo_json_model.dart';

class MessageLocationModel extends MessageLocationEntity {
  MessageLocationModel({
    GeoJsonEntity? geoJson,
    AddressEntity? address,
  }) : super(
          address: address,
          geoJson: geoJson,
        );

  factory MessageLocationModel.fromJson(Map<String, dynamic> json) {
    return MessageLocationModel(
      geoJson: json["geoJson"] != null
          ? GeoJsonModel.fromJson(json["geoJson"])
          : null,
      address: json["address"] != null
          ? AddressModel.fromJson(json["address"])
          : null,
    );
  }
}
