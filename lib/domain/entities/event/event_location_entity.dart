import 'package:chattyevent_app_flutter/domain/entities/geocoding/address_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/geocoding/geo_json_entity.dart';

class EventLocationEntity {
  final GeoJsonEntity? geoJson;
  final AddressEntity? address;

  EventLocationEntity({
    this.geoJson,
    this.address,
  });

  factory EventLocationEntity.merge({
    required EventLocationEntity newEntity,
    required EventLocationEntity oldEntity,
  }) {
    return EventLocationEntity(
      geoJson: newEntity.geoJson ?? oldEntity.geoJson,
      address: newEntity.address ?? oldEntity.address,
    );
  }
}
