import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';

/// this will only be used for the current cubit
class LeftUserWithPrivateEventUserData {
  final UserEntity user;
  final PrivateEventLeftUserEntity privateEventLeftUser;

  LeftUserWithPrivateEventUserData({
    required this.user,
    required this.privateEventLeftUser,
  });
}
