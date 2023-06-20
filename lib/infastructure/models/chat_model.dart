import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/private_event/private_event_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user_model.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    super.groupchat,
    super.privateEvent,
    super.user,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      groupchat: json["groupchat"] != null
          ? GroupchatModel.fromJson(json["groupchat"])
          : null,
      privateEvent: json["privateEvent"] != null
          ? PrivateEventModel.fromJson(json["privateEvent"])
          : null,
      user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
    );
  }
}
