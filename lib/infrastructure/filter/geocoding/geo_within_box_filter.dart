class GeoWithinBoxFilter {
  final List<double> upperRightCoordinates;
  final List<double> bottomLeftCoordinates;

  GeoWithinBoxFilter({
    required this.upperRightCoordinates,
    required this.bottomLeftCoordinates,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "bottomLeftCoordinates": bottomLeftCoordinates,
      "upperRightCoordinates": upperRightCoordinates,
    };
    return map;
  }
}
