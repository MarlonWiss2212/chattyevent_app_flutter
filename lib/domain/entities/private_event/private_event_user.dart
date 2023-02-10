import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

/// this will only be used for the current cubit
class PrivateEventUser extends UserEntity {
  final bool accapted;
  final bool declined;
  final bool invited;
  final bool? admin;

  PrivateEventUser({
    this.declined = false,
    this.accapted = false,
    this.invited = false,
    this.admin,
    required super.id,
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

  factory PrivateEventUser.fromUserEntity({
    required UserEntity user,
    bool accapted = false,
    bool declined = false,
    bool invited = false,
    bool? admin,
  }) {
    return PrivateEventUser(
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
      updatedAt: user.updatedAt,
      accapted: accapted,
      declined: declined,
      invited: invited,
      admin: admin,
    );
  }

  factory PrivateEventUser.fromPrivateEventUser({
    required PrivateEventUser privateEventUser,
    bool? accapted,
    bool? declined,
    bool? invited,
    bool? admin,
  }) {
    return PrivateEventUser(
      id: privateEventUser.id,
      birthdate: privateEventUser.birthdate,
      username: privateEventUser.username,
      firstname: privateEventUser.firstname,
      lastname: privateEventUser.lastname,
      email: privateEventUser.email,
      emailVerified: privateEventUser.emailVerified,
      lastTimeOnline: privateEventUser.lastTimeOnline,
      profileImageLink: privateEventUser.profileImageLink,
      createdAt: privateEventUser.createdAt,
      updatedAt: privateEventUser.updatedAt,
      accapted: accapted ?? privateEventUser.accapted,
      declined: declined ?? privateEventUser.declined,
      invited: invited ?? privateEventUser.invited,
      admin: admin ?? privateEventUser.admin,
    );
  }
}
