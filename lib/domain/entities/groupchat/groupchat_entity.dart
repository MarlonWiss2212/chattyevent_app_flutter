import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';

class GroupchatEntity {
  final String id;
  final String? title;
  final String? profileImageLink;
  final List<GroupchatUserEntity> users;
  final List<GroupchatLeftUserEntity> leftUsers;
  final String? description;
  final String? chatColorCode;
  final String? createdBy;
  final DateTime? createdAt;

  GroupchatEntity({
    required this.id,
    this.title,
    this.description,
    this.profileImageLink,
    required this.users,
    required this.leftUsers,
    this.chatColorCode,
    this.createdBy,
    this.createdAt,
  });
}
