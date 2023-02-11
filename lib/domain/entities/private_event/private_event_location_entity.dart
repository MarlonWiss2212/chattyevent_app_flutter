class PrivateEventLocationEntity {
  final double latitude;
  final double longitude;
  final String? country;
  final String? zip;
  final String? city;
  final String? street;
  final String? housenumber;

  PrivateEventLocationEntity({
    required this.latitude,
    required this.longitude,
    this.country,
    this.zip,
    this.city,
    this.street,
    this.housenumber,
  });
}
