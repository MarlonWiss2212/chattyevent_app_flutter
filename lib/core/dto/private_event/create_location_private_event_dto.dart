class CreatePrivateEventLocationDto {
  String country;
  String zip;
  String city;
  String street;
  String housenumber;

  CreatePrivateEventLocationDto({
    required this.city,
    required this.country,
    required this.housenumber,
    required this.street,
    required this.zip,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {
      'city': city,
      'country': country,
      'housenumber': housenumber,
      'street': street,
      'zip': zip,
    };

    return variables;
  }
}
