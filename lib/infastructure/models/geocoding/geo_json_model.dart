import 'package:chattyevent_app_flutter/core/enums/geo_json/geo_json_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/geocoding/geo_json_entity.dart';

class GeoJsonModel extends GeoJsonEntity {
  GeoJsonModel({
    GeoJsonTypeEnum? type,
    List<double>? coordinates,
  }) : super(
          type: type,
          coordinates: coordinates,
        );

  factory GeoJsonModel.fromJson(Map<String, dynamic> json) {
    List<double>? coordinates;
    if (json['coordinates'] != null) {
      for (final coordinate in json['coordinates']) {
        coordinates ??= [];
        coordinates.add(
          coordinate is double
              ? coordinate
              : double.parse(coordinate.toString()),
        );
      }
    }

    return GeoJsonModel(
      type: json["type"] != null
          ? GeoJsonTypeEnumExtension.fromValue(json["type"])
          : null,
      coordinates: coordinates,
    );
  }
}
