import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';

class GetAllGroupchatData {
  final GroupchatEntity groupchat;
  final List<MessageEntity> messages;
  final List<GroupchatUserEntity> groupchatUsers;
  final List<GroupchatLeftUserEntity> groupchatLeftUsers;

  GetAllGroupchatData({
    required this.messages,
    required this.groupchat,
    required this.groupchatUsers,
    required this.groupchatLeftUsers,
  });
}
