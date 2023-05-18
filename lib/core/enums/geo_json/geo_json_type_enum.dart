enum GeoJsonTypeEnum {
  point,
}

extension GeoJsonTypeEnumExtension on GeoJsonTypeEnum {
  String get value {
    switch (this) {
      case GeoJsonTypeEnum.point:
        return 'Point';
      default:
        throw Exception('Invalid value');
    }
  }

  static GeoJsonTypeEnum fromValue(String value) {
    switch (value) {
      case 'Point':
        return GeoJsonTypeEnum.point;
      default:
        throw Exception('Invalid value');
    }
  }
}
