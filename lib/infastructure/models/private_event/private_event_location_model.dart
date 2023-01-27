import 'package:social_media_app_flutter/domain/entities/private_event/private_event_location_entity.dart';

class PrivateEventLocationModel extends PrivateEventLocationEntity {
  PrivateEventLocationModel({
    required double latitude,
    required double longitude,
  }) : super(
          latitude: latitude,
          longitude: longitude,
        );

  factory PrivateEventLocationModel.fromJson(Map<String, dynamic> json) {
    return PrivateEventLocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
