import 'package:chattyevent_app_flutter/infrastructure/dto/geocoding/create_address_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/geocoding/create_geo_json_dto.dart';

class CreateMessageLocationDto {
  final CreateAddressDto? address;
  final CreateGeoJsonDto? geoJson;

  CreateMessageLocationDto({
    this.address,
    this.geoJson,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (address != null) {
      map.addAll({'address': address!.toMap()});
    }
    if (geoJson != null) {
      map.addAll({'geoJson': geoJson!.toMap()});
    }

    return map;
  }
}
