class CreatePrivateEventLocationDto {
  double latitude;
  double longitude;

  CreatePrivateEventLocationDto({
    required this.latitude,
    required this.longitude,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'latitude': latitude,
      'longitude': longitude,
    };

    return variables;
  }
}
