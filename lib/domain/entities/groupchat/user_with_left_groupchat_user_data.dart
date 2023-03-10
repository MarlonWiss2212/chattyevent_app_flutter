import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';

/// this will only be used for the current cubit
class UserWithLeftGroupchatUserData extends UserEntity {
  final DateTime? leftAt;

  UserWithLeftGroupchatUserData({
    this.leftAt,
    required super.id,
    required super.authId,
    super.birthdate,
    super.createdAt,
    super.email,
    super.emailVerified,
    super.firstname,
    super.lastTimeOnline,
    super.lastname,
    super.profileImageLink,
    super.updatedAt,
    super.username,
  });

  factory UserWithLeftGroupchatUserData.fromUserEntity({
    required UserEntity user,
    required GroupchatLeftUserEntity leftGroupchatUser,
  }) {
    return UserWithLeftGroupchatUserData(
      id: user.id,
      authId: user.authId,
      birthdate: user.birthdate,
      username: user.username,
      firstname: user.firstname,
      lastname: user.lastname,
      email: user.email,
      emailVerified: user.emailVerified,
      lastTimeOnline: user.lastTimeOnline,
      profileImageLink: user.profileImageLink,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      leftAt: leftGroupchatUser.createdAt,
    );
  }
}
