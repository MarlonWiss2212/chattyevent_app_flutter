import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/event/event_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/groupchat/groupchat_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/user/user_model.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    super.groupchat,
    super.event,
    super.user,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      groupchat: json["groupchat"] != null
          ? GroupchatModel.fromJson(json["groupchat"])
          : null,
      event: json["event"] != null ? EventModel.fromJson(json["event"]) : null,
      user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
    );
  }
}
