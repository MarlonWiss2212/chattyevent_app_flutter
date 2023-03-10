class PrivateEventLocationEntity {
  final double? latitude;
  final double? longitude;
  final String? country;
  final String? zip;
  final String? city;
  final String? street;
  final String? housenumber;

  PrivateEventLocationEntity({
    this.latitude,
    this.longitude,
    this.country,
    this.zip,
    this.city,
    this.street,
    this.housenumber,
  });

  factory PrivateEventLocationEntity.merge({
    required PrivateEventLocationEntity newEntity,
    required PrivateEventLocationEntity oldEntity,
  }) {
    return PrivateEventLocationEntity(
      latitude: newEntity.latitude ?? oldEntity.latitude,
      longitude: newEntity.longitude ?? oldEntity.longitude,
      country: newEntity.country ?? oldEntity.country,
      zip: newEntity.zip ?? oldEntity.zip,
      city: newEntity.city ?? oldEntity.city,
      street: newEntity.street ?? oldEntity.street,
      housenumber: newEntity.housenumber ?? oldEntity.housenumber,
    );
  }
}
