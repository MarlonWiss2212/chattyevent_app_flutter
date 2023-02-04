import 'package:social_media_app_flutter/domain/entities/user_and_token_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/infastructure/models/user_model.dart';

class UserAndTokenModel extends UserAndTokenEntity {
  UserAndTokenModel({
    required String accessToken,
    required UserEntity user,
  }) : super(
          accessToken: accessToken,
          user: user,
        );

  factory UserAndTokenModel.fromJson(Map<String, dynamic> json) {
    return UserAndTokenModel(
      accessToken: json['access_token'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
