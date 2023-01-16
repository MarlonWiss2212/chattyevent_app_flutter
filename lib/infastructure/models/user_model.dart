import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    String? username,
    String? email,
    String? firstname,
    String? lastname,
    String? emailVerified,
    String? profileImageLink,
    String? birthdate,
    String? lastTimeOnline,
    DateTime? createdAt,
  }) : super(
          id: id,
          username: username,
          email: email,
          firstname: firstname,
          lastname: lastname,
          emailVerified: emailVerified,
          profileImageLink: profileImageLink,
          birthdate: birthdate,
          lastTimeOnline: lastTimeOnline,
          createdAt: createdAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;
    return UserModel(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      profileImageLink: json['profileImageLink'],
      firstname: json["fistname"],
      lastname: json["lastname"],
      emailVerified: json["emailVerified"],
      birthdate: json["birthdate"],
      lastTimeOnline: json["lastTimeOnline"],
      createdAt: createdAt,
    );
  }
}
