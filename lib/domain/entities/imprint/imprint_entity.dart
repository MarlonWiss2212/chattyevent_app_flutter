import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_address_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_contact_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_disclaimer_entity.dart';

class ImprintEntity {
  final String imprintDescription;
  final String name;
  final ImprintAddressEntity address;
  final ImprintContactEntity contact;
  final ImprintDisclaimerEntity disclaimer;

  ImprintEntity({
    required this.imprintDescription,
    required this.name,
    required this.address,
    required this.contact,
    required this.disclaimer,
  });
}
