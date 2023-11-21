import 'package:chattyevent_app_flutter/core/enums/geo_json/geo_json_type_enum.dart';

class CreateGeoJsonDto {
  final List<double> coordinates;
  final GeoJsonTypeEnum type;

  CreateGeoJsonDto({
    required this.coordinates,
    required this.type,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      'type': type.value,
      'coordinates': coordinates,
    };

    return map;
  }
}
