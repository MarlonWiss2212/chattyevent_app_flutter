import 'package:chattyevent_app_flutter/domain/entities/geo_json/geo_json_entity.dart';

class PrivateEventLocationEntity {
  final GeoJsonEntity? geoJsonLocation;
  final String? country;
  final String? zip;
  final String? city;
  final String? street;
  final String? housenumber;

  PrivateEventLocationEntity({
    this.geoJsonLocation,
    this.country,
    this.zip,
    this.city,
    this.street,
    this.housenumber,
  });

  factory PrivateEventLocationEntity.merge({
    required PrivateEventLocationEntity newEntity,
    required PrivateEventLocationEntity oldEntity,
  }) {
    return PrivateEventLocationEntity(
      geoJsonLocation: newEntity.geoJsonLocation ?? oldEntity.geoJsonLocation,
      country: newEntity.country ?? oldEntity.country,
      zip: newEntity.zip ?? oldEntity.zip,
      city: newEntity.city ?? oldEntity.city,
      street: newEntity.street ?? oldEntity.street,
      housenumber: newEntity.housenumber ?? oldEntity.housenumber,
    );
  }
}
