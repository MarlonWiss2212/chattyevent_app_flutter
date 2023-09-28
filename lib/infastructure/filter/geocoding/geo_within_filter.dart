import 'package:chattyevent_app_flutter/infastructure/filter/geocoding/geo_within_box_filter.dart';

class GeoWithinFilter {
  final GeoWithinBoxFilter box;

  GeoWithinFilter({required this.box});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"box": box.toMap()};
    return map;
  }
}
