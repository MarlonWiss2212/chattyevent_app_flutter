import 'package:chattyevent_app_flutter/infastructure/dto/geocoding/create_address_dto.dart';

class CreatePrivateEventLocationDto {
  final CreateAddressDto? address;

  CreatePrivateEventLocationDto({
    this.address,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map =
        address != null ? {'address': address!.toMap()} : {};

    return map;
  }
}
