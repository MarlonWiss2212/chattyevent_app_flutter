class CreateAddressDto {
  final String country;
  final String zip;
  final String city;
  final String street;
  final String housenumber;

  CreateAddressDto({
    required this.city,
    required this.country,
    required this.housenumber,
    required this.street,
    required this.zip,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      'city': city,
      'country': country,
      'housenumber': housenumber,
      'street': street,
      'zip': zip,
    };

    return map;
  }
}
