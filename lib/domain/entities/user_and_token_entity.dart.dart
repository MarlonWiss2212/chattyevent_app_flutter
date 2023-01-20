import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

class UserAndTokenEntity {
  final String accessToken;
  final UserEntity user;

  UserAndTokenEntity({
    required this.accessToken,
    required this.user,
  });
}
