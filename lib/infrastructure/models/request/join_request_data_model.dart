import 'package:chattyevent_app_flutter/domain/entities/request/join_request_data_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/event/event_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/groupchat/groupchat_model.dart';

class JoinRequestDataModel extends JoinRequestDataEntity {
  JoinRequestDataModel({
    super.groupchat,
    super.event,
  });

  factory JoinRequestDataModel.fromJson(Map<String, dynamic> json) {
    return JoinRequestDataModel(
      event: json["event"] != null ? EventModel.fromJson(json["event"]) : null,
      groupchat: json["groupchat"] != null
          ? GroupchatModel.fromJson(json["groupchat"])
          : null,
    );
  }
}
