import 'package:chattyevent_app_flutter/domain/entities/geocoding/address_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/geocoding/geo_json_entity.dart';

class MessageLocationEntity {
  final GeoJsonEntity? geoJson;
  final AddressEntity? address;

  MessageLocationEntity({
    this.geoJson,
    this.address,
  });

  factory MessageLocationEntity.merge({
    required MessageLocationEntity newEntity,
    required MessageLocationEntity oldEntity,
  }) {
    return MessageLocationEntity(
      geoJson: newEntity.geoJson ?? oldEntity.geoJson,
      address: newEntity.address ?? oldEntity.address,
    );
  }
}
