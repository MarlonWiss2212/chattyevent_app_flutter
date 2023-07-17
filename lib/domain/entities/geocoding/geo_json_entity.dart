import 'package:chattyevent_app_flutter/core/enums/geo_json/geo_json_type_enum.dart';

class GeoJsonEntity {
  final GeoJsonTypeEnum? type;
  final List<double>? coordinates;

  GeoJsonEntity({
    this.type,
    this.coordinates,
  });
}
