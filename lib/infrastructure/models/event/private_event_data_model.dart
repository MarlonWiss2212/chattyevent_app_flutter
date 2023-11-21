import 'package:chattyevent_app_flutter/domain/entities/event/private_event_data_entity.dart';

class PrivateEventDataModel extends PrivateEventDataEntity {
  PrivateEventDataModel({
    String? groupchatTo,
  }) : super(
          groupchatTo: groupchatTo,
        );

  factory PrivateEventDataModel.fromJson(Map<String, dynamic> json) {
    return PrivateEventDataModel(
      groupchatTo: json["groupchatTo"],
    );
  }
}
