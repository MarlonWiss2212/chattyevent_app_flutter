import 'package:chattyevent_app_flutter/domain/entities/geo_json/geo_json_entity.dart';

class GeoJsonModel extends GeoJsonEntity {
  GeoJsonModel({
    String? type,
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
      type: json["type"],
      coordinates: coordinates,
    );
  }
}
