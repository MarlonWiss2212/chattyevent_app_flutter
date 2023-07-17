import 'package:chattyevent_app_flutter/domain/entities/geocoding/address_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/geocoding/geo_json_entity.dart';

class PrivateEventLocationEntity {
  final GeoJsonEntity? geoJson;
  final AddressEntity? address;

  PrivateEventLocationEntity({
    this.geoJson,
    this.address,
  });

  factory PrivateEventLocationEntity.merge({
    required PrivateEventLocationEntity newEntity,
    required PrivateEventLocationEntity oldEntity,
  }) {
    return PrivateEventLocationEntity(
      geoJson: newEntity.geoJson ?? oldEntity.geoJson,
      address: newEntity.address ?? oldEntity.address,
    );
  }
}
