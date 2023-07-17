class AddressEntity {
  final String? country;
  final String? zip;
  final String? city;
  final String? street;
  final String? housenumber;

  AddressEntity({
    this.country,
    this.zip,
    this.city,
    this.street,
    this.housenumber,
  });

  factory AddressEntity.merge({
    required AddressEntity newEntity,
    required AddressEntity oldEntity,
  }) {
    return AddressEntity(
      country: newEntity.country ?? oldEntity.country,
      zip: newEntity.zip ?? oldEntity.zip,
      city: newEntity.city ?? oldEntity.city,
      street: newEntity.street ?? oldEntity.street,
      housenumber: newEntity.housenumber ?? oldEntity.housenumber,
    );
  }
}
