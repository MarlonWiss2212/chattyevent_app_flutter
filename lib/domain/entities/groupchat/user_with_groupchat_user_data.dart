import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

/// this will only be used for the current cubit
class UserWithGroupchatUserData extends UserEntity {
  final bool? admin;
  final DateTime? joinedAt;
  final String? usernameForChat;

  UserWithGroupchatUserData({
    this.admin,
    this.joinedAt,
    required super.id,
    super.birthdate,
    super.createdAt,
    super.email,
    this.usernameForChat,
    super.emailVerified,
    super.firstname,
    super.lastTimeOnline,
    super.lastname,
    super.profileImageLink,
    super.updatedAt,
    super.username,
  });

  factory UserWithGroupchatUserData.fromUserEntity({
    required UserEntity user,
    required GroupchatUserEntity groupchatUser,
  }) {
    return UserWithGroupchatUserData(
      id: user.id,
      birthdate: user.birthdate,
      username: user.username,
      firstname: user.firstname,
      lastname: user.lastname,
      email: user.email,
      emailVerified: user.emailVerified,
      lastTimeOnline: user.lastTimeOnline,
      profileImageLink: user.profileImageLink,
      createdAt: user.createdAt,
      usernameForChat: groupchatUser.usernameForChat,
      updatedAt: user.updatedAt,
      admin: groupchatUser.admin,
      joinedAt: groupchatUser.createdAt,
    );
  }
}
